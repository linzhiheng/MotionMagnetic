classdef aVelocityField2D
    properties
        aParameters;
        meshCoords;
        VFun;
        V;
    end

    methods
        function obj = aVelocityField2D(aVelocityFieldParameters)
            obj.aParameters = aVelocityFieldParameters;
            obj.VFun = buildVelocityFunction(obj);
        end
    end

    methods(Abstract)
        [VFun] = buildVelocityFunction(obj);
    end

    methods

        function obj = buildVelocityField(obj, region, varargin)
            obj.meshCoords = buildMesh(obj, region, varargin);
            
            [nz, nx] = size(obj.meshCoords.z);
            obj.V.x = zeros(nz, nx);
            obj.V.z = zeros(nz, nx);
            
            t = obj.aParameters.t;
            for ix = 1:nx
                xCoord = obj.meshCoords.x(1, ix);
                for iz = 1:nz
                    zCoord = obj.meshCoords.z(iz, 1);
                    obj.V.x(iz, ix) = obj.VFun.x(zCoord, xCoord, t);
                    obj.V.z(iz, ix) = obj.VFun.z(zCoord, xCoord, t);
                end
            end

            obj.V = CutNoWaterArea(obj, obj.V);
            
        end

        function [meshCoords] = buildMesh(obj, region, inputs)
            [dz, dx] = getElementSize(obj, inputs);

            x = region(1);
            nextX = x + dx;
            while ( nextX < region(2) )
                x = [x,nextX];
                nextX = nextX + dx;
            end
            x = [x,region(2)];

            z = -obj.aParameters.amplitude;
            nextZ = z + dz;
            while ( nextZ < obj.aParameters.depth )
                z = [z,nextZ];
                nextZ = nextZ + dz;
            end
            z = [z,obj.aParameters.depth];

            [meshCoords.x, meshCoords.z] = meshgrid(x,z);

        end

        function [dz, dx] = getElementSize(~, elementSize)
            switch (numel(elementSize))
            case 1  %manul
                dx = abs( elementSize{1}(1) );
                dz = abs( elementSize{1}(2) );
            case 0  %default
                dx = 1;
                dz = 1;
            end
        end

        function [outinField] = CutNoWaterArea(obj, inField)
            [~, nx] = size(inField.z);
            
            for ix = 1:nx
                x = obj.meshCoords.x(1,ix);
                fluctuate = obj.VFun.fluctuate(x);
                nz = 1;
                z = obj.meshCoords.z(nz,1);
                while z < fluctuate
                    inField.x(nz, ix) = NaN;
                    inField.z(nz, ix) = NaN;
                    nz = nz + 1;
                    z = obj.meshCoords.z(nz,1);
                end
            end
            outinField = inField;

        end

        function show(obj)
            subplot(1, 2, 1)
                pcolor(obj.meshCoords.x, obj.meshCoords.z, obj.V.x)
                shading flat
                
                c1 = colorbar;
                    axpos = get(gca,'Position');
                    cpos = get(c1,'Position');
                    cpos(3) = 0.5*cpos(3);
                    set(c1,'Position',cpos)
                    set(gca,'Position',axpos)
                    
                set(get(gca, 'Title'), 'String', 'Vx');
                set(get(gca, 'XLabel'), 'String', 'position');
                set(get(gca, 'YLabel'), 'String', 'depth');
                set(gca,'YDir','reverse');
                %set(gca,'YScale','log')

            subplot(1, 2, 2)
                pcolor(obj.meshCoords.x, obj.meshCoords.z, obj.V.z)
                shading flat
                
                c2 = colorbar;
                    axpos = get(gca,'Position');
                    cpos = get(c2,'Position');
                    cpos(3) = 0.5*cpos(3);
                    set(c2,'Position',cpos)
                    set(gca,'Position',axpos)
                    
                set(get(gca, 'Title'), 'String', 'Vz');
                set(get(gca, 'XLabel'), 'String', 'position');
                set(get(gca, 'YLabel'), 'String', 'depth');
                set(gca,'YDir','reverse');
                
        end

        function dispParameters(obj)
            p = sprintf('\n-------------------Velocity Field Parameters---------------- \n');
            p = [p, sprintf('        Wave Height  : %6.2f m \n', obj.aParameters.waveHeight)];
            p = [p, sprintf('            Frequency  : %6.2f Hz \n', obj.aParameters.frequency)];
            p = [p, sprintf('            Amplitude  : %6.2f m \n', obj.aParameters.amplitude)];
            p = [p, sprintf('      Wave Number  : %6.2f \n', obj.aParameters.waveNumber)];
            p = [p, sprintf('----------------------------------------------------------------- \n')];
            disp(p);
        end
    end
end