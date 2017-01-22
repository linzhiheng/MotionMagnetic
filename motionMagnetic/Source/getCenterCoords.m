function centre = getCenterCoords(C1,C3,varargin)
    
    %������
    p = inputParser;
    %�����飬�����C1��C2��Ҫ��һ����������Ԫ�ص�����
    p.addRequired('C1',@(C1)  validateattributes(C1,{'numeric'},{'numel',2},'getCenterCoords','C1',1));
    p.addRequired('C3',@(C3)  validateattributes(C3,{'numeric'},{'numel',2},'getCenterCoords','C3',2));
    
    defaultC2 = C3;
    p.addOptional('C2',defaultC2,@(C2)  validateattributes(C2,{'numeric'},{'numel',2},'getCenterCoords','C2',3));
    defaultC4 = C3;
    p.addOptional('C4',defaultC4,@(C4)  validateattributes(C4,{'numeric'},{'numel',2},'getCenterCoords','C4',4));
    
    p.parse(C1,C3,varargin{:});
    %������
    
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