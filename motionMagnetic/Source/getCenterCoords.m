function centre = getCenterCoords(C1,C2,varargin)
    
    %输入检查
    p = inputParser;
    %输入检查，输入的C1和C2需要是一个含有两个元素的数组
    p.addRequired('C1',@(C1)  validateattributes(C1,{'numeric'},{'numel',2},'getCenterCoords','C1',1));
    p.addRequired('C2',@(C2)  validateattributes(C2,{'numeric'},{'numel',2},'getCenterCoords','C2',2));
    
    defaultC3 = C2;
    p.addOptional('C3',defaultC3,@(C3)  validateattributes(C3,{'numeric'},{'numel',2},'getCenterCoords','C3',3));
    defaultC4 = C2;
    p.addOptional('C4',defaultC4,@(C4)  validateattributes(C4,{'numeric'},{'numel',2},'getCenterCoords','C4',4));
    
    p.parse(C1,C2,varargin{:});
    %检查结束
    
    C = p.Results.C1;
    Cdiagonal = p.Results.C2;
    
    x = 1;
    z = 2;
    if(C(x)==Cdiagonal(x)||C(z)==Cdiagonal(z))
        Cdiagonal = p.Results.C3;
        if(C(x)==Cdiagonal(x)||C(z)==Cdiagonal(z))
            Cdiagonal = p.Results.C4;
        end
    end
    
    centre = [0,0];
    centre(x) = ( C(x)+Cdiagonal(x) )/2;
    centre(z) = ( C(z)+Cdiagonal(z) )/2;
end