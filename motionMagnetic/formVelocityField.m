function velocityField = formVelocityField(waveLength, frequency)
    waveHeight = 1;
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
    velocity_x = @(z,x,t) vpa('( (a*g*k)/w ) * ( cosh(k*(d-z))/cosh(k*d) ) * sin( (k*x) - (w*t) )',20);
    
%     velocity_z = @(x,z,t) -1 * ( (a*g*k)/w ) * ( sinh(k*(d-z))/cosh(k*d) ) * cos( (k*x) - (w*t) );
    
    velocityField = zeros(depth+1,width+1,2);
    for ix = 0:width
        for iz = 0:depth
            ix
            iz
            velocity_x(iz,ix,t)
            velocityField(iz+1,ix+1,1) = velocity_x(iz,ix,t);
%             velocityField(iz,ix,2) = velocity_z(iz,ix,t);
        end
    end
    
end