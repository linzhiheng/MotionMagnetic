% motionMagnetic
addpath(genpath(pwd));

field = formVelocityField(1, 0.1);
unit = field2unit(field);

global EMField Sigma Zeta Ak;
[EMField, Sigma, Zeta, Ak] = readParameter;

point = [0,0];

magneticField = [0,0,0];
[ni, nj] = size(unit);
for i = 1:ni
    for j = 1:nj
        magneticField = magneticField + unitIntegrate(unit(i,j),point);
    end
end