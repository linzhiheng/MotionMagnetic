function velocityField = formVelocityField(frequency, depth)
    format long 
    
    waveHeight = 1;
    gravity = 9.8;
    t = 0;
    width = 2000;
    
    a = waveHeight;
    g = gravity;
    w = 2*pi*frequency;
    d = depth;
    k = get_k(w,d);
    velocity_x = @(z,x,t) ( (a*g*k)/w ) * ( (exp(-1*k*z)+exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * sin( (k*x) - (w*t) );
    velocity_z = @(z,x,t) -1 * ( (a*g*k)/w ) * ( (exp(-1*k*z)-exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * cos( (k*x) - (w*t) );
% %     velocity_x = @(z,x,t) ( (a*g*k)/w ) * ( cosh(k*(d-z))/cosh(k*d) ) * sin( (k*x) - (w*t) );
% %     velocity_z = @(z,x,t) -1 * ( (a*g*k)/w ) * ( sinh(k*(d-z))/cosh(k*d) ) * cos( (k*x) - (w*t) );
    
    velocityField = zeros(depth+1,width+1,2);
    for ix = 0:width
        for iz = 0:depth
            velocityField(iz+1,ix+1,1) = velocity_x(iz,ix,t);
            velocityField(iz+1,ix+1,2) = velocity_z(iz,ix,t);
        end
    end
    
end