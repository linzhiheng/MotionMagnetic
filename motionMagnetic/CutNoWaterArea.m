function [ outArray ] = CutNoWaterArea( inArray, cutLine, dz, a)
%输入一段速度场数据，将大于表面起伏的部分置零
%   此处显示详细说明

z = -a;
nz = 1;
while z < cutLine
    inArray(nz) = 0.0;
    z = z + dz;
    nz = nz + 1;
end
outArray = inArray;

end

