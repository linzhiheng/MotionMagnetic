function velocityFunction(velocityField2D)
    if(~isa(velocityField2D, 'velocityField2D')) 
        error('input is not 2D VelocityField');
    end
    
end