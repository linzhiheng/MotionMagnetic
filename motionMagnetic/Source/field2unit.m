function unit = field2unit(field,origin)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
    validateattributes(field,{'numeric'},{'ndims',3},'field2unit','field',1);
    validateattributes(origin,{'struct'},{'size',[1,1]},'field2unit','origin',2);
    %������
    [nRow, nColumn, nd] = size(field);
    unit(nRow-1,nColumn-1) = struct('velocity',[],'coords',[],'conductivity',[]);
    
    conductivity = 3;
    
%     origin.x = 0;
%     origin.z = 0;
    dx = 1;
    dz = 1;
    for j = 1:nColumn-1
        for i = 1:nRow-1
            x1 = (j-1)*dx + origin.x;
            x2 = x1;
            x3 = x1+dx;
            x4 = x3;
            z1 = (i-1)*dz +origin.z;
            z2 = z1 + dz;
            z3 = z2;
            z4 = z1;
            unit(i,j).coords = [x1,z1;x2,z2;x3,z3;x4,z4];
            
            unit(i,j).velocity = [field(i, j, :); field(i+1, j, :); field(i+1, j+1, :); field(i, j+1, :)];
            
            unit(i,j).conductivity = conductivity;
        end
    end
%     unit = field;
end