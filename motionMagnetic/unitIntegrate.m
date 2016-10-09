function R = unitIntegrate(unit,p)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
    validateattributes(unit,{'struct'},{'size',[1,1]},'unitIntegrate','unit',1);
    validateattributes(p,{'numeric'},{'numel',2},'unitIntegrate','p',2);
    %检查结束
    
    c1 = unit.coords(:,1);
    c2 = unit.coords(:,2);
    c3 = unit.coords(:,3);
    c4 = unit.coords(:,4);
    center = getCenterCoords(c1, c2, c3, c4);
    
    
    
    R = 0;
end