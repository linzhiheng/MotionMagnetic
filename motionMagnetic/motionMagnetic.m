% motionMagnetic
parpool(4);

addpath(genpath(pwd));

frequency = 0.04;
depth = 50;
field = formVelocityField(frequency, depth);

unit = field2unit(field);

% global earthField Sigma Zeta Ak;
% [earthField, Sigma, Zeta, Ak] = readParameter;
% totalEarthField = 5*10^-5;
% dipEarthField = 70;
% inclinationEarthField = 0;
% earthField(1) = totalEarthField*cosd(dipEarthField)*cosd(inclinationEarthField);
% earthField(2) = totalEarthField*cosd(dipEarthField)*sind(inclinationEarthField);
% earthField(3) = totalEarthField*sind(dipEarthField);


magneticField = zeros(depth+1,3);
[ni, nj] = size(unit);

parfor nP = 1:depth+1
    point = [1000,nP-1];
    for i = 1:ni
        for j = 1:nj
            magneticField(nP,:) = magneticField(nP,:) + unitIntegrate(unit(i,j),point);
        end
    end
end

poolobj = gcp('nocreate');
delete(poolobj);