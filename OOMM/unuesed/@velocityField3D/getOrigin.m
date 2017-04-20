function getOrigin(obj, inputs)
            switch (numel(inputs))
            case 1  %manul
                obj.origin.x = inputs{1}(1);
                obj.origin.y = inputs{1}(2);
                obj.origin.z = inputs{1}(3);
            case 4  %manul
                obj.origin.x = inputs{4}(1);
                obj.origin.y = inputs{4}(2);
                obj.origin.z = inputs{4}(3);
            case {0 3}  %default
                obj.origin.x = -obj.aVelocityFieldParameter.region.x;
                obj.origin.y = -obj.aVelocityFieldParameter.region.y;
                obj.origin.z = obj.aVelocityFieldParameter.amplitude;
            end
end