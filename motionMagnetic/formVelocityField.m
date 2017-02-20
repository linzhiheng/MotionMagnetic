function velocityField = formVelocityField(waveHeight, frequency, depth,width,dz,dx)
    format long 
    
    gravity = 9.8;
    t = 0;
    
    %流速计算方程
    a = waveHeight/2;
    g = gravity;
    w = 2*pi*frequency;
    d = depth;
    k = get_k(w,d);%角波数k=2pi/lamda
    velocity_x = @(z,x,t) ( (a*g*k)/w ) * ( (exp(-1*k*z)+exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * sin( (k*x) - (w*t) );
    velocity_z = @(z,x,t) -1 * ( (a*g*k)/w ) * ( (exp(-1*k*z)-exp(-2*k*d+k*z)) / (1+exp(-2*k*d)) ) * cos( (k*x) - (w*t) );
    %###
    %表面起伏方程
    fluctuate = @(x) a*sin(k*x);
    %###
    x = 1;
    z = 2;
    
    nx = (2*width/dx)+1;
    nz = ((depth+a)/dz)+1;
    velocityField = zeros(nz, nx,2);
    serfaceFluctuate = zeros(nx,1);
    for i = 1:nx
        ix = dx*(i-1)-width;
        for j = 1:nz     
            jz = dz*(j-1)-a;
            velocityField(j, i, x) = velocity_x(jz, ix, t);
            velocityField(j, i, z) = velocity_z(jz, ix, t);
        end
        velocityField(:, i, x) = CutNoWaterArea( velocityField(:, i, x), fluctuate(ix), dz, a);
        velocityField(:, i, z) = CutNoWaterArea( velocityField(:, i, z), fluctuate(ix), dz, a);
    end
    
end