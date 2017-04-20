clear all
clc

VP = velocityFieldParameters();
VFun = Drift3D(VP);

region = [-100, 100; -100, 100];
elementSize = [5, 5, 3];
Drift3D_1 = VFun.buildVelocityField(region, elementSize);

earthField = getEarthField();

Drift3DField = magneticField3D(Drift3D_1, earthField);

% point = [0, 0, 0];
% magnetic = Drift3DField.getMagnetic(point);

D = 100;
point = [0:2:D; 0:2:D; 0:2:D]';
point(:, 1:2) = 0;
magneticField = Drift3DField.getMagneticField(point);