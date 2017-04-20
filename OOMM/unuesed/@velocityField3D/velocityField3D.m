classdef velocityField3D < aVelocityField
    %velocityField

    methods
        function obj = velocityField3D(aVelocityFieldParameter, varargin)
            if(~isa(aVelocityFieldParameter, 'velocityFieldParameters3D')) 
                error('velocityParameters is not 3D');
            end
            if(nargin == 3)
                error('Wrong input arguments.');
            end
            narginchk(1, 5);
            
            obj = obj@aVelocityField(aVelocityFieldParameter, varargin);
        end

        getElementSize(obj, varargin);
        getOrigin(obj, varargin);
    end
    
end