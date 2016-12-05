function Bxyz = unitIntegrate(unit,point,parameter)
    %�����飬�����p1��p2��Ҫ��һ����������Ԫ�ص�����
    validateattributes(unit,{'struct'},{'size',[1,1,1]},'unitIntegrate','unit',1);
    validateattributes(point,{'numeric'},{'numel',2},'unitIntegrate','point',2);
    validateattributes(parameter,{'struct'},{'size',[1,1,1,1]},'unitIntegrate','parameter',3);
    %������
    
%     ���ֲ���    

%     global earthField Sigma Zeta Ak

%     [earthField, Sigma, Zeta, Ak] = readParameter;
%     totalEarthField = 5*10^-5;
%     dipEarthField = 70;
%     inclinationEarthField = 0;
%     earthField(1) = totalEarthField*cosd(dipEarthField)*cosd(inclinationEarthField);
%     earthField(2) = totalEarthField*cosd(dipEarthField)*sind(inclinationEarthField);
%     earthField(3) = totalEarthField*sind(dipEarthField);
    
    earthField = parameter.earthField;
    Sigma = parameter.Sigma;
    Zeta = parameter.Zeta;
    Ak = parameter.Ak;
    
    c1 = unit.coords(1,:);
    c2 = unit.coords(2,:);
    c3 = unit.coords(3,:);
    c4 = unit.coords(4,:);
    center = getCenterCoords(c1, c2, c3, c4);
    
    radius = getRadius(point,center);   %m
    
    Bxyz = [0,0,0];
    nij = length(Zeta);
    for i = 1:nij
        for  j = 1:nij
            Bxyz = Bxyz + Ak(i)*Ak(j)*Integrand(Zeta(i),Zeta(j),earthField,unit,radius)*Sigma*(10^-7);
        end
    end
    
end