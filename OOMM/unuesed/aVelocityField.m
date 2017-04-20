classdef aVelocityField < handle
    properties
        velocityField;
        origin;
        elementSize;
        conductivity;
        aVelocityFieldParameter;
    end

    methods
        function obj = aVelocityField(aVelocityFieldParameter, inputs)
            obj.aVelocityFieldParameter = aVelocityFieldParameter;
            getElementSize(obj, inputs);
            getOrigin(obj, inputs);
        end
    end

    methods (Abstract)
        %toElements(obj);
        %getParameters(obj);
        getElementSize(obj, varargin);
        getOrigin(obj, varargin);
    end
end