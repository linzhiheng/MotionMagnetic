function R = unitIntegrate(unit,p)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
    validateattributes(unit,{'struct'},{'size',[1,1]},'unitIntegrate','unit',1);
    validateattributes(p,{'numeric'},{'numel',2},'unitIntegrate','p',2);
    %������
    
    c1 = unit.coords(:,1);
    c2 = unit.coords(:,2);
    c3 = unit.coords(:,3);
    c4 = unit.coords(:,4);
    center = getCenterCoords(c1, c2, c3, c4);
    
    
    
    R = 0;
end