function unit = field2unit(field)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
%     validateattributes(field,{'numeric'},{'ndims',3},'field2unit','field',1);
    %检查结束
    [nRow, nColumn, nd] = size(field);
    unit(nRow-1,nColumn-1) = struct('velocity',[],'coords',[],'conductivity',[]);
    
    for j = 1:nColumn-1
        for i = 1:nRow-1
            unit(i,j).velocity = [field(i, j, :); field(i+1, j, :); field(i+1, j+1, :); field(i, j+1, :)];
        end
    end
%     unit = field;
end