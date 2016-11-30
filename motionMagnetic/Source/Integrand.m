function Integrand = Integrand(Xi,Eta,earthField,unit,radius)
    %输入检查，输入的Xi和Eta需要在[-1,1]之间。
    validateattributes(Xi,{'numeric'},{'>=',-1,'<=',1},'Integrand','Xi',1);
    validateattributes(Eta,{'numeric'},{'>=',-1,'<=',1},'Integrand','Eta',2);
    validateattributes(earthField,{'numeric'},{'numel',3},'Integrand','earthField',3);
    validateattributes(unit,{'struct'},{'size',[1,1,1]},'Integrand','unit',4);
    validateattributes(radius,{'numeric'},{'numel',2},'Integrand','radius',5);
    %检查结束
    
    x = radius(1)+Xi;
    z = radius(2)-Eta;                                                   %z = radius(2)+Eta;
    R3 = (sqrt( x^2+z^2 ))^3;
    
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
        Cumulate(3) = Cumulate(3)+N(i)*( Vx(i)*Fy-Vz(i)*Fx )*x;
    end
    
    Integrand = [0,0,0];
    for i = 1:3
        Integrand(i) = Cumulate(i)*(J/R3);
    end
    if radius == [0,0]
        Integrand = [0,0,0];
    end
end