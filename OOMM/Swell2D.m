classdef Swell2D < aVelocityField2D

    methods
        function obj = Swell2D(aVelocityFieldParameters)
            obj = obj@aVelocityField2D(aVelocityFieldParameters);
        end

        function [VFun] = buildVelocityFunction(obj)
            g = obj.aParameters.gravity;
            a = obj.aParameters.amplitude;
            w = obj.aParameters.w;
            d = obj.aParameters.depth;
            k = obj.aParameters.waveNumber;

            VFun.x = @(z,x,t) ( (a*g*k)/w ) * ( (exp(-1*k*z)+exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * sin( (k*x) - (w*t) );
            VFun.z = @(z,x,t) -1 * ( (a*g*k)/w ) * ( (exp(-1*k*z)-exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * cos( (k*x) - (w*t) );
            VFun.fluctuate = @(x) a*sin(k*x);
        end

    end
    
end