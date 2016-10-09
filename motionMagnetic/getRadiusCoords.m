function R = getRadiusCoords(p1,p2)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
    validateattributes(p1,{'numeric'},{'numel',2},'getRadius','p1',1);
    validateattributes(p2,{'numeric'},{'numel',2},'getRadius','p2',2);
    %检查结束
    
    R = [0,0];
    R(1) = p2(1)-p1(1);
    R(2) = p2(2)-p1(2);
end