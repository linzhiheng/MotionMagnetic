classdef magneticField2D
    properties
        velocityField;
        earthField;
    end

    properties (Dependent)
        IntegralFactors;
    end

    methods
        function IntegralFactors = get.IntegralFactors(~)
            IntegralFactors.Zeta = [-0.7745967, 0, 0.7745967];
            IntegralFactors.Ak = [0.5555556, 0.8888889, 0.5555556];
        end
    end

    methods
        function obj = magneticField2D(aVelocityField, earthField)
            obj.velocityField.V = aVelocityField.V;
            obj.velocityField.V.x( isnan( obj.velocityField.V.x ) ) = 0;
            obj.velocityField.V.z( isnan( obj.velocityField.V.z ) ) = 0;
            obj.velocityField.meshCoords = aVelocityField.meshCoords;
            obj.earthField = earthField;
        end

        function [magneticField] = getMagneticField(obj, point)
            [np, ~] = size(point);
            magneticField = zeros(np,3);
            
            parpool(4)
            
            parfor ip = 1:np
                magneticField(ip,:) = getMagnetic(obj, point(ip, :));
            end
            
            poolobj = gcp('nocreate');
            delete(poolobj);
        end
        
        function [magnetic] = getMagnetic(obj, point)
            magnetic = [0, 0, 0];
            [nz, nx] = size(obj.velocityField.meshCoords.z);
            for iz = 1:nz-1
                for ix = 1:nx-1
                    [element] = getElement(obj, iz, ix);
                    magnetic = magnetic + magneticOf(obj, element, point);
                end
            end
            
        end

        function [magnetic] = magneticOf(obj, element, point)

            A = obj.IntegralFactors.Ak;

            
            constantTerm = 2 * element.conductivity * (10^-7);
            nij = numel(obj.IntegralFactors.Ak);
            
            integrand.x = 0;
            integrand.y = 0;
            integrand.z = 0;
            for i = 1:nij
                Alpha = obj.IntegralFactors.Zeta(i);
                for j = 1:nij
                    Beta = obj.IntegralFactors.Zeta(j);
                    
                    [Jacobi] = getJacobi(obj, element, Alpha, Beta);

                    [V, X, Z] = shapeFunction(obj, Alpha, Beta, element);
                    Rx = X - point(1);
                    Rz = Z - point(2);
                    R2 = (Rx*Rx) + (Rz*Rz);
                    [current] = getCurrent(obj, V);

                    integrand.x = integrand.x + ( A(i)*A(j) * ( current.y*Rz ) / R2 ) * Jacobi;
                    integrand.y = integrand.y + ( A(i)*A(j) * ( current.z*Rx - current.x*Rz ) / R2 ) * Jacobi;
                    integrand.z = integrand.z + ( A(i)*A(j) * ( -current.y )*Rx / R2 ) * Jacobi;
                end
            end

            magnetic = constantTerm * [integrand.x, integrand.y, integrand.z];
        end

        function [Jacobi] = getJacobi(~, element, Alpha, Beta)
            matrix1 = [-(1+Beta), -(1-Beta), 1-Beta, 1+Beta;...
                        1-Alpha, -(1-Alpha), -(1+Alpha), 1+Alpha];

            x = reshape(element.meshCoords.x, 4,1);
            z = reshape(element.meshCoords.z, 4,1);
            matrix2 = [x,z];
            
            Jacobi = det( 0.25*( matrix1*matrix2 ) );
        end

        function [V, X, Z] = shapeFunction(~, Alpha, Beta, element)
            N = [0,0,0,0];
            N(1) = 0.25*(1-Alpha)*(1-Beta);
            N(2) = 0.25*(1-Alpha)*(1+Beta);
            N(3) = 0.25*(1+Alpha)*(1+Beta);
            N(4) = 0.25*(1+Alpha)*(1-Beta);

            V.x = 0;
            V.z = 0;
            X = 0;
            Z = 0;
            for i = 1:4
                V.x = V.x + element.V.x(i)*N(i);
                V.z = V.z + element.V.z(i)*N(i);
                X = X + element.meshCoords.x(i)*N(i);
                Z = Z + element.meshCoords.z(i)*N(i);
            end
        end
        
        function [current] = getCurrent(obj, V)
            Fx = obj.earthField(1);
            Fy = obj.earthField(2);
            Fz = obj.earthField(3);

            current.x = -V.z*Fy;
            current.y = V.z*Fx - V.x*Fz;
            current.z = V.x*Fy;
        end

        function [element] = getElement(obj, z, x)
            x = int32(x);
            z = int32(z);
            element.V.x = [ 
                            obj.velocityField.V.x(z, x), ...
                            obj.velocityField.V.x(z+1, x), ...
                            obj.velocityField.V.x(z+1, x+1), ...
                            obj.velocityField.V.x(z, x+1) 
                          ];

            element.V.z = [ 
                            obj.velocityField.V.z(z, x), ...
                            obj.velocityField.V.z(z+1, x), ...
                            obj.velocityField.V.z(z+1, x+1), ...
                            obj.velocityField.V.z(z, x+1) 
                          ];
            
            element.meshCoords.x = [ 
                                    obj.velocityField.meshCoords.x(z, x);
                                    obj.velocityField.meshCoords.x(z+1, x);
                                    obj.velocityField.meshCoords.x(z+1, x+1);
                                    obj.velocityField.meshCoords.x(z, x+1)
                                    ];

            element.meshCoords.z = [ 
                                    obj.velocityField.meshCoords.z(z, x);
                                    obj.velocityField.meshCoords.z(z+1, x);
                                    obj.velocityField.meshCoords.z(z+1, x+1);
                                    obj.velocityField.meshCoords.z(z, x+1)
                                    ];
            
            element.conductivity = getConductivity(obj, z, x);
        end

        function [conductivity] = getConductivity(~, z, x)
            conductivity = 4.0;
        end

        function [magneticField] = Zero2Bottom(obj)
            [nz, ~] = size(obj.velocityField.meshCoords.z);
            D = obj.velocityField.meshCoords.z(nz,1);
            point = [0:D; 0:D]';
            point(:, 1) = 0;
            
            magneticField = getMagneticField(obj, point);
        end

    end
end