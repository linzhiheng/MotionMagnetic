%motionMagnetic
parpool(4);

addpath(genpath(pwd));

frequency = 0.03;
depth = 50;
width = 500;
velocityField = formVelocityField(frequency, depth, width);
origin.x = -1*width;
origin.z = 0;
unit = field2unit(velocityField,origin);

% global earthField Sigma Zeta Ak;
[earthField, Sigma, Zeta, Ak] = readParameter;
parameter.earthField = earthField;
parameter.Sigma = Sigma;
parameter.Zeta = Zeta;
parameter.Ak = Ak;

totalEarthField = 5*10^-5;
dipEarthField = 70;
inclinationEarthField = 0;

parameter.earthField(1) = totalEarthField*cosd(dipEarthField)*cosd(inclinationEarthField);
parameter.earthField(2) = totalEarthField*cosd(dipEarthField)*sind(inclinationEarthField);
parameter.earthField(3) = totalEarthField*sind(dipEarthField);

magneticField = zeros(depth+1,3);
[ni, nj] = size(unit);

parfor nP = 1:depth+1
    point = [0,nP-1];
    for i = 1:ni
        for j = 1:nj
            magneticField(nP,:) = magneticField(nP,:) + unitIntegrate(unit(i,j),point,parameter);
        end
    end
end

poolobj = gcp('nocreate');
delete(poolobj);
 
xlswrite('magneticField',magneticField);

