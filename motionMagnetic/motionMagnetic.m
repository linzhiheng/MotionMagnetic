% motionMagnetic
addpath(genpath(pwd));

unit = field2unit(field);

point = [0,0];

magneticField = [0,0,0];
[ni, nj] = size(unit);
for i = 1:ni
    for j = 1:nj
        magneticField = magneticField + unitIntegrate(unit(i,j),point);
    end
end