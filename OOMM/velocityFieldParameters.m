classdef velocityFieldParameters < aVelocityFieldParameters

    methods
        function obj = velocityFieldParameters()
            obj.waveHeight = 2;     %m
            obj.frequency = 0.1;    %Hz
            obj.gravity = 9.8;
            obj.t = 0;
            obj.depth = 300;        %m
        end
    end
end