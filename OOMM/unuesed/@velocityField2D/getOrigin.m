function getOrigin(obj, inputs)
            switch (numel(inputs))
            case 1  %manul
                obj.origin.x = inputs{1}(1);
                obj.origin.z = inputs{1}(2);
            case 3  %manul
                obj.origin.x = inputs{3}(1);
                obj.origin.z = inputs{3}(2);
            case {0 2}  %default
                obj.origin.x = -obj.aVelocityFieldParameter.region.x;
                obj.origin.z = obj.aVelocityFieldParameter.amplitude;
            end
end