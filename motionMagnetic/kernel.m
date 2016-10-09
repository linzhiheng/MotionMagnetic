function B = kernel(Xi,Eta,p)
    %输入检查，输入的Xi和Eta需要在[-1,1]之间。
    validateattributes(Xi,{'numeric'},{'>=',-1,'<=',1},'kernel','Xi',1);
    validateattributes(Eta,{'numeric'},{'>=',-1,'<=',1},'kernel','Eta',2);
    validateattributes(p,{'numeric'},{'numel',2},'kernel','p',3);
    %检查结束
    
    x = p(1);
    z = p(2);
    R3 = (sqrt( (x+Xi)^2+(z+Eta)^2 ))^3;
    
    N = [0,0,0,0];
    N(1) = 0.25*(1-Xi)*(1+Eta);
    N(2) = 0.25*(1-Xi)*(1-Eta);
    N(3) = 0.25*(1+Xi)*(1-Eta);
    N(4) = 0.25*(1+Xi)*(1+Eta);
    
    
    
    B = 0;
end