%motionMagnetic
clear all
clc

parpool(4);

addpath(genpath(pwd));

frequency = 0.1;    %Hz
depth = 50;    %m
width = 50;   %m
velocityField = formVelocityField(frequency, depth, width);
origin.x = -1*width;
origin.z = 0;
unit = field2unit(velocityField,origin);

% global earthField Sigma Zeta Ak;
[earthField, Sigma, Zeta, Ak] = readParameter;
parameters.earthField = earthField;
parameters.Sigma = Sigma;    %S/m
parameters.Zeta = Zeta;
parameters.Ak = Ak; 
parameters.w = 2*pi*frequency;

totalEarthField = 4.5*10^-5;    %T
dipEarthField = 60; %`
inclinationEarthField = 30; %`

parameters.earthField(1) = totalEarthField*cosd(dipEarthField)*cosd(inclinationEarthField);
parameters.earthField(2) = totalEarthField*cosd(dipEarthField)*sind(inclinationEarthField);
parameters.earthField(3) = totalEarthField*sind(dipEarthField);

magneticField = zeros(depth+1,3);
[ni, nj] = size(unit);

parfor nP = 1:depth+1
    point = [0,nP-1];
    for i = 1:ni
        for j = 1:nj
            magneticField(nP,:) = magneticField(nP,:) + unitIntegrate(unit(i,j),point,parameters);
        end
    end
end

poolobj = gcp('nocreate');
delete(poolobj);
 
xlswrite('magneticField',magneticField);

