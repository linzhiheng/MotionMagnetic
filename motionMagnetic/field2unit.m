function unit = field2unit(field)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
%     validateattributes(field,{'numeric'},{'ndims',3},'field2unit','field',1);
    %������
    [nRow, nColumn, nd] = size(field);
    unit(nRow-1,nColumn-1) = struct('velocity',[],'coords',[],'conductivity',[]);
    
    for j = 1:nColumn-1
        for i = 1:nRow-1
            unit(i,j).velocity = [field(i, j, :); field(i+1, j, :); field(i+1, j+1, :); field(i, j+1, :)];
        end
    end
%     unit = field;
end