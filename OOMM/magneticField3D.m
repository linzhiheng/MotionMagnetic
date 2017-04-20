classdef magneticField3D
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
        function obj = magneticField3D(aVelocityField, earthField)
            obj.velocityField.V = aVelocityField.V;
            obj.velocityField.V.x( isnan( obj.velocityField.V.x ) ) = 0;
            obj.velocityField.V.y( isnan( obj.velocityField.V.y ) ) = 0;
            obj.velocityField.V.z( isnan( obj.velocityField.V.z ) ) = 0;
            obj.velocityField.meshCoords = aVelocityField.meshCoords;
            obj.earthField = earthField;
        end

        function [magneticField] = getMagneticField(obj, point)
            [np, ~, ~] = size(point);
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
            [nz, nx, ny] = size(obj.velocityField.meshCoords.z);
            for iy = 1:ny-1
                for iz = 1:nz-1
                    for ix = 1:nx-1
                        element = getElement(obj, iz, ix, iy);
                        magnetic = magnetic + magneticOf(obj, element, point);
                    end
                end
            end
            
        end

        function [magnetic] = magneticOf(obj, element, point)

            A = obj.IntegralFactors.Ak;


            constantTerm = element.conductivity * (10^-7);
            nij = numel(obj.IntegralFactors.Ak);
            
            integrand.x = 0;
            integrand.y = 0;
            integrand.z = 0;
            for i = 1:nij
                Alpha = obj.IntegralFactors.Zeta(i);
                for j = 1:nij
                Beta = obj.IntegralFactors.Zeta(j);
                    for k = 1:nij
                        Chi = obj.IntegralFactors.Zeta(k);
                        
                        [Jacobi] = getJacobi(obj, element, Alpha, Beta, Chi);
                        
                        [V, X, Y, Z] = shapeFunction(obj, Alpha, Beta, Chi, element);
                        Rx = X - point(1);
                        Ry = Y - point(2);
                        Rz = Z - point(3);
                        R3 = ( sqrt((Rz*Rz) + (Rx*Rx) + (Ry*Ry)) )^3;
                        [current] = getCurrent(obj, V);
                        
                        integrand.x = integrand.x + ( A(i)*A(j)*A(k) * ( current.y*Rz - current.z*Ry ) / R3 * Jacobi );
                        integrand.y = integrand.y + ( A(i)*A(j)*A(k) * ( current.z*Rx - current.x*Rz ) / R3 * Jacobi );
                        integrand.z = integrand.z + ( A(i)*A(j)*A(k) * ( current.x*Ry - current.y*Rx ) / R3 * Jacobi );
                    end
                end
            end

            magnetic = constantTerm * [integrand.x, integrand.y, integrand.z];
        end

        function [Jacobi] = getJacobi(~, element, Alpha, Beta, Chi)
            matrix1 = [
                       -(1-Beta)*(1-Chi), -(1-Beta)*(1+Chi), ...
                       (1-Beta)*(1+Chi), (1-Beta)*(1-Chi), ...
                       -(1+Beta)*(1-Chi), -(1+Beta)*(1+Chi), ...
                       (1+Beta)*(1+Chi), (1+Beta)*(1-Chi); ...

                       -(1-Alpha)*(1-Chi), -(1-Alpha)*(1+Chi), ...
                       -(1+Alpha)*(1+Chi), -(1+Alpha)*(1-Chi), ...
                       (1-Alpha)*(1-Chi), (1-Alpha)*(1+Chi), ...
                       (1+Alpha)*(1+Chi), (1+Alpha)*(1-Chi); ...

                       -(1-Alpha)*(1-Beta), (1-Alpha)*(1-Beta), ...
                       (1+Alpha)*(1-Beta), -(1+Alpha)*(1-Beta), ...
                       -(1-Alpha)*(1+Beta), (1-Alpha)*(1+Beta), ...
                       (1+Alpha)*(1+Beta), -(1+Alpha)*(1+Beta)
                      ];

            x = reshape(element.meshCoords.x, 8,1);
            y = reshape(element.meshCoords.y, 8,1);
            z = reshape(element.meshCoords.z, 8,1);
            matrix2 = [x,y,z];
            
            Jacobi = det( 0.125*( matrix1*matrix2 ) );
        end

        function [V, X, Y, Z] = shapeFunction(~, Alpha, Beta, Chi, element)
            N = [0,0,0,0,0,0,0,0];
            N(1) = 0.125 * (1-Alpha) * (1-Beta) * (1-Chi);
            N(2) = 0.125 * (1-Alpha) * (1-Beta) * (1+Chi);
            N(3) = 0.125 * (1+Alpha) * (1-Beta) * (1+Chi);
            N(4) = 0.125 * (1+Alpha) * (1-Beta) * (1-Chi);
            N(5) = 0.125 * (1-Alpha) * (1+Beta) * (1-Chi);
            N(6) = 0.125 * (1-Alpha) * (1+Beta) * (1+Chi);
            N(7) = 0.125 * (1+Alpha) * (1+Beta) * (1+Chi);
            N(8) = 0.125 * (1+Alpha) * (1+Beta) * (1-Chi);


            V.x = 0;
            V.y = 0;
            V.z = 0;
            X = 0;
            Y = 0;
            Z = 0;
            for i = 1:8
                V.x = V.x + element.V.x(i)*N(i);
                V.y = V.y + element.V.y(i)*N(i);
                V.z = V.z + element.V.z(i)*N(i);
                X = X + element.meshCoords.x(i)*N(i);
                Y = Y + element.meshCoords.y(i)*N(i);
                Z = Z + element.meshCoords.z(i)*N(i);
            end
        end

        function [current] = getCurrent(obj, V)
            Fx = obj.earthField(1);
            Fy = obj.earthField(2);
            Fz = obj.earthField(3);

            current.x = V.y*Fz - V.z*Fy;
            current.y = V.z*Fx - V.x*Fz;
            current.z = V.x*Fy - V.y*Fx;
        end

        function [element] = getElement(obj, z, x, y)
            x = int32(x);
            y = int32(y);
            z = int32(z);
            element.V.x = [ 
                            obj.velocityField.V.x(z, x, y), ...
                            obj.velocityField.V.x(z+1, x, y), ...
                            obj.velocityField.V.x(z+1, x+1, y), ...
                            obj.velocityField.V.x(z, x+1, y), ...
                            obj.velocityField.V.x(z, x, y+1), ...
                            obj.velocityField.V.x(z+1, x, y+1), ...
                            obj.velocityField.V.x(z+1, x+1, y+1), ...
                            obj.velocityField.V.x(z, x+1, y+1) 
                          ];

            element.V.y = [ 
                            obj.velocityField.V.y(z, x, y), ...
                            obj.velocityField.V.y(z+1, x, y), ...
                            obj.velocityField.V.y(z+1, x+1, y), ...
                            obj.velocityField.V.y(z, x+1, y), ...
                            obj.velocityField.V.y(z, x, y+1), ...
                            obj.velocityField.V.y(z+1, x, y+1), ...
                            obj.velocityField.V.y(z+1, x+1, y+1), ...
                            obj.velocityField.V.y(z, x+1, y+1) 
                          ];

            element.V.z = [ 
                            obj.velocityField.V.z(z, x, y), ...
                            obj.velocityField.V.z(z+1, x, y), ...
                            obj.velocityField.V.z(z+1, x+1, y), ...
                            obj.velocityField.V.z(z, x+1, y), ...
                            obj.velocityField.V.z(z, x, y+1), ...
                            obj.velocityField.V.z(z+1, x, y+1), ...
                            obj.velocityField.V.z(z+1, x+1, y+1), ...
                            obj.velocityField.V.z(z, x+1, y+1) 
                          ];
            
            element.meshCoords.x = [ 
                                    obj.velocityField.meshCoords.x(z, x, y);
                                    obj.velocityField.meshCoords.x(z+1, x, y);
                                    obj.velocityField.meshCoords.x(z+1, x+1, y);
                                    obj.velocityField.meshCoords.x(z, x+1, y);
                                    obj.velocityField.meshCoords.x(z, x, y+1);
                                    obj.velocityField.meshCoords.x(z+1, x, y+1);
                                    obj.velocityField.meshCoords.x(z+1, x+1, y+1);
                                    obj.velocityField.meshCoords.x(z, x+1, y+1)
                                    ];

            element.meshCoords.y = [ 
                                    obj.velocityField.meshCoords.y(z, x, y);
                                    obj.velocityField.meshCoords.y(z+1, x, y);
                                    obj.velocityField.meshCoords.y(z+1, x+1, y);
                                    obj.velocityField.meshCoords.y(z, x+1, y);
                                    obj.velocityField.meshCoords.y(z, x, y+1);
                                    obj.velocityField.meshCoords.y(z+1, x, y+1);
                                    obj.velocityField.meshCoords.y(z+1, x+1, y+1);
                                    obj.velocityField.meshCoords.y(z, x+1, y+1)
                                    ]; 

            element.meshCoords.z = [ 
                                    obj.velocityField.meshCoords.z(z, x, y);
                                    obj.velocityField.meshCoords.z(z+1, x, y);
                                    obj.velocityField.meshCoords.z(z+1, x+1, y);
                                    obj.velocityField.meshCoords.z(z, x+1, y);
                                    obj.velocityField.meshCoords.z(z, x, y+1);
                                    obj.velocityField.meshCoords.z(z+1, x, y+1);
                                    obj.velocityField.meshCoords.z(z+1, x+1, y+1);
                                    obj.velocityField.meshCoords.z(z, x+1, y+1)
                                    ];
            
            element.conductivity = getConductivity(obj, z, x, y);
        end

        function [conductivity] = getConductivity(~, z, x, y)
            conductivity = 4.0;
        end

        function [magneticField] = Zero2Bottom(obj)
            [nz, ~, ~] = size(obj.velocityField.meshCoords.z);
            D = obj.velocityField.meshCoords.z(nz,1,1);
            point = [0:D; 0:D; 0:D]';
            point(:, 1:2) = 0;
            
            magneticField = getMagneticField(obj, point);
        end

    end
end