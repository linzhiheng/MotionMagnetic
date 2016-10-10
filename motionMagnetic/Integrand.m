function B = Integrand(Xi,Eta,EMField,unit,radius)
    %输入检查，输入的Xi和Eta需要在[-1,1]之间。
    validateattributes(Xi,{'numeric'},{'>=',-1,'<=',1},'Integrand','Xi',1);
    validateattributes(Eta,{'numeric'},{'>=',-1,'<=',1},'Integrand','Eta',2);
    validateattributes(EMField,{'numeric'},{'numel',3},'Integrand','EMField',3);
    validateattributes(unit,{'struct'},{'size',[1,1]},'Integrand','unit',4);
    validateattributes(radius,{'numeric'},{'numel',2},'Integrand','radius',5);
    %检查结束
    
    x = radius(1);
    z = radius(2);
    R3 = (sqrt( (x+Xi)^2+(z+Eta)^2 ))^3;
    
    N = [0,0,0,0];
    N(1) = 0.25*(1-Xi)*(1+Eta);
    N(2) = 0.25*(1-Xi)*(1-Eta);
    N(3) = 0.25*(1+Xi)*(1-Eta);
    N(4) = 0.25*(1+Xi)*(1+Eta);
    
    Vx = [0,0,0,0];
    Vz = [0,0,0,0];
    
    
    
    B = 0;
end