classdef Drift3D < aVelocityField3D
    methods
        function obj = Drift3D(velocityFieldParameters)
            obj = obj@aVelocityField3D(velocityFieldParameters);
        end

        function [VFun] = buildVelocityFunction(obj)
            g = obj.aParameters.gravity;
            a = obj.aParameters.amplitude;
            w = obj.aParameters.w;
            d = obj.aParameters.depth;
            k = obj.aParameters.waveNumber;

            VFun.x = @(z,x,y,t) ( (a*g*k)/w ) * ( (exp(-1*k*z)+exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * sin( (k*x) - (w*t) );
            VFun.y = @(z,x,y,t) 0;
            VFun.z = @(z,x,y,t) -1 * ( (a*g*k)/w ) * ( (exp(-1*k*z)-exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * cos( (k*x) - (w*t) );
            VFun.fluctuate = @(x,y) a*sin(k*x);
        end

    end
end