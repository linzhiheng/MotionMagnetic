function [ outArray ] = CutNoWaterArea( inArray, cutLine, dz, a)
%����һ���ٶȳ����ݣ������ڱ�������Ĳ�������
%   �˴���ʾ��ϸ˵��

z = -a;
nz = 1;
while z < cutLine
    inArray(nz) = 0.0;
    z = z + dz;
    nz = nz + 1;
end
outArray = inArray;

end

