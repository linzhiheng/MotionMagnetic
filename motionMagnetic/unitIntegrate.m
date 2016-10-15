function R = unitIntegrate(unit,point)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
    validateattributes(unit,{'struct'},{'size',[1,1,1]},'unitIntegrate','unit',1);
    validateattributes(point,{'numeric'},{'numel',2},'unitIntegrate','point',2);
    %������
    
    EMField = [1,1,1];
    Conductivity = unit.conductivity;
    
    Zeta = [0,0,0];
    Zeta(1) = sqrt(15)/(-5);
    Zeta(2) = 0;
    Zeta(3) = sqrt(15)/(5);
    
    Ak = [0,0,0];
    Ak(1) = 5/9;
    Ak(2) = 8/9;
    Ak(3) = 5/9;
    
    
    
    c = [0,0,0,0];
    c(1) = unit.coords(1,:);
    c(2) = unit.coords(2,:);
    c(3) = unit.coords(3,:);
    c(4) = unit.coords(4,:);
    center = getCenterCoords(c(1), c(2), c(3), c(4));
    
    radius = getRadius(point,center);
    
    R = [0,0,0];
    nij = length(Zeta);
    for i = 1:nij
        for j = 1:nij
            R = R + Ak(i)*Ak(j)*Integrand(Zeta(i),Zeta(j),EMField,unit,radius)*Conductivity*(10^-7);
        end
    end
    
end