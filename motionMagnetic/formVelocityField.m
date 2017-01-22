function velocityField = formVelocityField(frequency, depth,width,dz,dx)
    format long 
    
    waveHeight = 1;
    gravity = 9.8;
    t = 0;
    
    %流速计算方程
    a = waveHeight;
    g = gravity;
    w = 2*pi*frequency;
    d = depth;
    k = get_k(w,d);
    velocity_x = @(z,x,t) ( (a*g*k)/w ) * ( (exp(-1*k*z)+exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * sin( (k*x) - (w*t) );
    velocity_z = @(z,x,t) -1 * ( (a*g*k)/w ) * ( (exp(-1*k*z)-exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * cos( (k*x) - (w*t) );
    %###
    
    nx = (2*width/dx)+1;
    nz = (depth/dz)+1;
    velocityField = zeros(nz, nx,2);
    for i = 1:nx
        for j = 1:nz
            ix = dx*(i-1)-width;
            jz = dz*(j-1);
            velocityField(j, i, 1) = velocity_x(jz, ix, t);
            velocityField(j, i, 2) = velocity_z(jz, ix, t);
        end
    end
    
end