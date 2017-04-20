classdef velocityField2D < aVelocityField
    %velocityField

    methods
        function obj = velocityField2D(aVelocityFieldParameter, varargin)
            if(~isa(aVelocityFieldParameter, 'velocityFieldParameters2D')) 
                error('velocityParameters is not 2D');
            end
            narginchk(1, 4);
            
            obj = obj@aVelocityField(aVelocityFieldParameter, varargin);
        end

        getElementSize(obj, varargin);
        getOrigin(obj, varargin);
    end
    
end 