classdef aVelocityField3D
    properties
        fieldParameters;
        meshCoords;
        VFun;
        V;
    end

     methods
        function obj = aVelocityField3D(aVelocityFieldParameters)
            obj.fieldParameters = aVelocityFieldParameters;
            obj.VFun = buildVelocityFunction(obj);
        end
    end

    methods(Abstract)
        [VFun] = buildVelocityFunction(obj);
    end

    methods

        function obj = buildVelocityField(obj, region, varargin)
            obj.meshCoords = buildMesh(obj, region, varargin);
            
            [nz, nx, ny] = size(obj.meshCoords.z);
            obj.V.x = zeros(nz, nx, ny);
            obj.V.y = zeros(nz, nx, ny);
            obj.V.z = zeros(nz, nx, ny);
            
            t = obj.fieldParameters.t;
            for iy = 1:ny
                yCoord = obj.meshCoords.y(1, 1, iy);
                for ix = 1:nx
                    xCoord = obj.meshCoords.x(1, ix, 1);
                    for iz = 1:nz
                        zCoord = obj.meshCoords.z(iz, 1, 1);
                        obj.V.x(iz, ix, iy) = obj.VFun.x(zCoord, xCoord, yCoord, t);
                        obj.V.y(iz, ix, iy) = obj.VFun.y(zCoord, xCoord, yCoord, t);
                        obj.V.z(iz, ix, iy) = obj.VFun.z(zCoord, xCoord, yCoord, t);
                    end
                end
            end

            obj.V = CutNoWaterArea(obj, obj.V);

        end

        function [meshCoords] = buildMesh(obj, region, inputs)
            [dz, dx, dy] = getElementSize(obj, inputs);

            z = -obj.fieldParameters.amplitude;
            nextZ = z + dz;
            while ( nextZ < obj.fieldParameters.depth )
                z = [z,nextZ];
                nextZ = nextZ + dz;
            end
            z = [z,obj.fieldParameters.depth];

            x = region(1,1);
            nextX = x + dx;
            while ( nextX < region(1,2) )
                x = [x,nextX];
                nextX = nextX + dx;
            end
            x = [x,region(1,2)];

            y = region(2,1);
            nextY = y + dy;
            while ( nextY < region(2,2) )
                y = [y,nextY];
                nextY = nextY + dy;
            end
            y = [y,region(2,2)];


            [meshCoords.x, meshCoords.z, meshCoords.y] = meshgrid(x,z,y);

        end

        function [dz, dx, dy] = getElementSize(~, elementSize)
            switch (numel(elementSize))
            case 1  %manul
                dx = abs( elementSize{1}(1) );
                dy = abs( elementSize{1}(2) );
                dz = abs( elementSize{1}(3) );
            case 0  %default
                dx = 1;
                dy = 1;
                dz = 1;
            end
        end

        function [outinField] = CutNoWaterArea(obj, inField)
            [~, nx, ny] = size(inField.z);
            
            for iy = 1:ny
                y = obj.meshCoords.x(1, 1, iy);
                for ix = 1:nx
                    x = obj.meshCoords.x(1, ix, 1);
                    fluctuate = obj.VFun.fluctuate(x, y);
                    nz = 1;
                    z = obj.meshCoords.z(nz, 1, 1);
                    while z < fluctuate
                        inField.x(nz, ix, iy) = NaN;
                        inField.y(nz, ix, iy) = NaN;
                        inField.z(nz, ix, iy) = NaN;
                        nz = nz + 1;
                        z = obj.meshCoords.z(nz, 1, 1);
                    end
                end
            end

            outinField = inField;

        end

        function dispParameters(obj)
            p = sprintf('\n-------------------Velocity Field Parameters---------------- \n');
            p = [p, sprintf('        Wave Height  : %6.2f m \n', obj.fieldParameters.waveHeight)];
            p = [p, sprintf('            Frequency  : %6.2f Hz \n', obj.fieldParameters.frequency)];
            p = [p, sprintf('            Amplitude  : %6.2f m \n', obj.fieldParameters.amplitude)];
            p = [p, sprintf('      Wave Number  : %6.2f \n', obj.fieldParameters.waveNumber)];
            p = [p, sprintf('----------------------------------------------------------------- \n')];
            disp(p);
        end
    end
end