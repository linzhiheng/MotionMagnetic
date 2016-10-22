% motionMagnetic
unit = field2unit(field);

B = [0,0,0];
point = [0,0];

[ni, nj] = size(unit);
for i = 1:ni
    for j = 1:nj
        B = B + unitIntegrate(unit(i,j),point);
    end
end