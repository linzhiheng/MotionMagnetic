classdef aVelocityFieldParameters < handle

    properties
        waveHeight;    %m
        frequency;     %Hz
        depth;         %m
        gravity;
        t;
    end

    properties (Dependent)
        amplitude;
        w;
        waveNumber;
    end
 
    methods

        function a = get.amplitude(obj)
            a = obj.waveHeight/2;
        end
        
        function w = get.w(obj)
            w = obj.frequency*2*pi;
        end

        function k = get.waveNumber(obj)
            w = obj.w;
            g = obj.gravity;
            k = (w*w)/g;
        end

    end

end