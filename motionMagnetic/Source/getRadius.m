function R = getRadius(p1,p2)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
    validateattributes(p1,{'numeric'},{'numel',2},'getRadius','p1',1);
    validateattributes(p2,{'numeric'},{'numel',2},'getRadius','p2',2);
    %������
    x = 1;
    z = 2;
    
    R = [0,0];
    R(x) = p2(x)-p1(x);
    R(z) = p2(z)-p1(z);
end