function centre = getCenterCoords(C1,C3,varargin)
    
    %输入检查
    p = inputParser;
    %输入检查，输入的C1和C2需要是一个含有两个元素的数组
    p.addRequired('C1',@(C1)  validateattributes(C1,{'numeric'},{'numel',2},'getCenterCoords','C1',1));
    p.addRequired('C3',@(C3)  validateattributes(C3,{'numeric'},{'numel',2},'getCenterCoords','C3',2));
    
    defaultC2 = C3;
    p.addOptional('C2',defaultC2,@(C2)  validateattributes(C2,{'numeric'},{'numel',2},'getCenterCoords','C2',3));
    defaultC4 = C3;
    p.addOptional('C4',defaultC4,@(C4)  validateattributes(C4,{'numeric'},{'numel',2},'getCenterCoords','C4',4));
    
    p.parse(C1,C3,varargin{:});
    %检查结束
    
    C = p.Results.C1;
    Cdiagonal = p.Results.C3;
    
    x = 1;
    z = 2;
    if(C(x)==Cdiagonal(x)||C(z)==Cdiagonal(z))
        Cdiagonal = p.Results.C2;
        if(C(x)==Cdiagonal(x)||C(z)==Cdiagonal(z))
            Cdiagonal = p.Results.C4;
        end
    end
    
    centre = [0,0];
    centre(x) = ( C(x)+Cdiagonal(x) )/2;
    centre(z) = ( C(z)+Cdiagonal(z) )/2;
%     centre(x) = ( C1(x)+C2(x) )/2;
%     centre(z) = ( C1(z)+C2(z) )/2;
end