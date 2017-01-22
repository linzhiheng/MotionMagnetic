function Bxyz = unitIntegrate(unit,point,parameter)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
    validateattributes(unit,{'struct'},{'size',[1,1,1]},'unitIntegrate','unit',1);
    validateattributes(point,{'numeric'},{'numel',2},'unitIntegrate','point',2);
    validateattributes(parameter,{'struct'},{'size',[1,1,1,1]},'unitIntegrate','parameter',3);
    %检查结束
    
%     积分参数    

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
    c3 = unit.coords(3,:);
    center = getCenterCoords(c1,c3);
    
    radius = getRadius(point,center);   %m
    
    constantTerm = Sigma*(10^-7)*2;
    
    Bxyz = [0,0,0];
    nij = length(Zeta);
    for i = 1:nij
        for  j = 1:nij
            Bxyz = Bxyz + Ak(i)*Ak(j)*Integrand(Zeta(i),Zeta(j),earthField,unit,radius);
        end
    end
    Bxyz = Bxyz*constantTerm;
    
end