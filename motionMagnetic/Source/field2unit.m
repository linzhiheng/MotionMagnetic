function unit = field2unit(field)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
    validateattributes(field,{'numeric'},{'ndims',3},'field2unit','field',1);
    %检查结束
    [nRow, nColumn, nd] = size(field);
    unit(nRow-1,nColumn-1) = struct('velocity',[],'coords',[],'conductivity',[]);
    
    conductivity = 3;
    
    Origin.x = 0;
    Origin.z = 0;
    dx = 10;
    dz = 8;
    for j = 1:nColumn-1
        for i = 1:nRow-1
            x1 = (j-1)*dx + Origin.x;
            x2 = x1;
            x3 = x1+dx;
            x4 = x3;
            z1 = (i-1)*dz +Origin.z;
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