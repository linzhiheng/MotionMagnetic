function Integrand = Integrand(Xi,Eta,earthField,unit,radius,w)
    %�����飬�����Xi��Eta��Ҫ��[-1,1]֮�䡣
    validateattributes(Xi,{'numeric'},{'>=',-1,'<=',1},'Integrand','Xi',1);
    validateattributes(Eta,{'numeric'},{'>=',-1,'<=',1},'Integrand','Eta',2);
    validateattributes(earthField,{'numeric'},{'numel',3},'Integrand','earthField',3);
    validateattributes(unit,{'struct'},{'size',[1,1,1]},'Integrand','unit',4);
    validateattributes(radius,{'numeric'},{'numel',2},'Integrand','radius',5);
    %������
    
    lightVelocity = 3*10^8; %m/s
    
    x = radius(1)+Xi;
    z = radius(2)-Eta;                                                   %z = radius(2)+Eta;
    R = sqrt( x^2+z^2 );
    R2 = (R)^2;
    
    J = getJacobi(Xi,Eta,unit.coords);
    
    N = [0,0,0,0];
    N(1) = 0.25*(1-Xi)*(1+Eta);
    N(2) = 0.25*(1-Xi)*(1-Eta);
    N(3) = 0.25*(1+Xi)*(1-Eta);
    N(4) = 0.25*(1+Xi)*(1+Eta);
    
    Vx = [0,0,0,0];
    Vz = [0,0,0,0];
    for i = 1:4
        Vx(i) = unit.velocity(i,1);
        Vz(i) = unit.velocity(i,2);
    end
    
    Fx = earthField(1);
    Fy = earthField(2);
    Fz = earthField(3);
    
    Cumulate = [0,0,0];
    for i = 1:4
        Cumulate(1) = Cumulate(1)+N(i)*( Vz(i)*Fx-Vx(i)*Fz )*z;
        Cumulate(2) = Cumulate(2)+N(i)*( Vx(i)*Fy*x + Vz(i)*Fy*z );
        Cumulate(3) = Cumulate(3)+N(i)*( Vx(i)*Fz-Vz(i)*Fx )*x;
    end
    
    c = lightVelocity;
    temp1 = ( (R*w)/(sqrt(2)*c) )^2;
    Integrand = [0,0,0];
    for i = 1:3
        Integrand(i) = Cumulate(i)*(J/R2)*(1+temp1);
    end
    if radius == [0,0]
        Integrand = [0,0,0];
    end
end