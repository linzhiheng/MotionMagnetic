function velocityField = formVelocityField(waveLength, frequency)
    format long 
    
    waveHeight = 0.3;
    gravity = 10;
    waveNumber = (2*pi)/waveLength;
    t = 0;
    depth = 200;
    width = 200;
    
    a = waveHeight;
    g = gravity;
    k = waveNumber;
    w = 2*pi*frequency;
    d = depth;
    velocity_x = @(z,x,t) ( (a*g*k)/w ) * ( (exp(-1*k*z)+exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * sin( (k*x) - (w*t) );
%     velocity_z = @(x,z,t) -1 * ( (a*g*k)/w ) * ( (exp(-1*k*z)-exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * cos( (k*x) - (w*t) );
% %     velocity_x = @(z,x,t) ( (a*g*k)/w ) * ( cosh(k*(d-z))/cosh(k*d) ) * sin( (k*x) - (w*t) );
% %     velocity_z = @(x,z,t) -1 * ( (a*g*k)/w ) * ( sinh(k*(d-z))/cosh(k*d) ) * cos( (k*x) - (w*t) );
    
    velocityField = zeros(depth+1,width+1,2);
    for ix = 0:width
        for iz = 0:depth
            velocityField(iz+1,ix+1,1) = velocity_x(iz,ix,t);
%             velocityField(iz,ix,2) = velocity_z(iz,ix,t);
        end
    end
    
end