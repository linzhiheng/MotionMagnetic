function R = getRadius(p1,p2)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
    validateattributes(p1,{'numeric'},{'numel',2},'getRadius','p1',1);
    validateattributes(p2,{'numeric'},{'numel',2},'getRadius','p2',2);
    %������
    
    R = [0,0];
    R(1) = p2(1)-p1(1);
    R(2) = p2(2)-p1(2);
end