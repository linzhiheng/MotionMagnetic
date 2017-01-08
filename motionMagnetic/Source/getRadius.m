function R = getRadius(p1,p2)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
    validateattributes(p1,{'numeric'},{'numel',2},'getRadius','p1',1);
    validateattributes(p2,{'numeric'},{'numel',2},'getRadius','p2',2);
    %检查结束
    x = 1;
    z = 2;
    
    R = [0,0];
    R(x) = p2(x)-p1(x);
    R(z) = p2(z)-p1(z);
end