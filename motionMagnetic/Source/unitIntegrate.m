function Bxyz = unitIntegrate(unit,point)
    %输入检查，输入的p1和p2需要是一个含有两个元素的数组
    validateattributes(unit,{'struct'},{'size',[1,1,1]},'unitIntegrate','unit',1);
    validateattributes(point,{'numeric'},{'numel',2},'unitIntegrate','point',2);
    %检查结束
    
%积分参数    
%     EMField = [1,1,0];
%     
%     Sigma = unit.conductivity;
%     
%     Zeta = [0,0,0];
%     
%     Zeta(1) = sqrt(15)/(-5);
%     Zeta(2) = 0;
%     Zeta(3) = sqrt(15)/(5);
%     
%     Ak = [0,0,0];
%     Ak(1) = 5/9;
%     Ak(2) = 8/9;
%     Ak(3) = 5/9;
%
%     [EMField, Sigma, Zeta, Ak] = readParameter;

%     global earthField Sigma Zeta Ak
    [earthField, Sigma, Zeta, Ak] = readParameter;
    totalEarthField = 5*10^-5;
    dipEarthField = 70;
    inclinationEarthField = 0;
    earthField(1) = totalEarthField*cosd(dipEarthField)*cosd(inclinationEarthField);
    earthField(2) = totalEarthField*cosd(dipEarthField)*sind(inclinationEarthField);
    earthField(3) = totalEarthField*sind(dipEarthField);

    
    c1 = unit.coords(1,:);
    c2 = unit.coords(2,:);
    c3 = unit.coords(3,:);
    c4 = unit.coords(4,:);
    center = getCenterCoords(c1, c2, c3, c4);
    
    radius = getRadius(point,center);
    
    Bxyz = [0,0,0];
    nij = length(Zeta);
    for i = 1:nij
        for  j = 1:nij
            Bxyz = Bxyz + Ak(i)*Ak(j)*Integrand(Zeta(i),Zeta(j),earthField,unit,radius)*Sigma*(10^-7);
        end
    end
    
end