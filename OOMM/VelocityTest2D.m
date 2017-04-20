clear
clc

VP2D = velocityFieldParameters();
VFun = Swell2D(VP2D);

region = [-100, 100];
%elementSize = [2, 2];
Swell2D_1 = VFun.buildVelocityField(region);

%Swell2D_2 = VFun.buildVelocityField(region, elementSize);

earthField = getEarthField();

Swell2DField = magneticField2D(Swell2D_1, earthField);

%point = [0, 0];
%magnetic = Swell2DField.getMagnetic(point);
magneticField = Swell2DField.Zero2Bottom();