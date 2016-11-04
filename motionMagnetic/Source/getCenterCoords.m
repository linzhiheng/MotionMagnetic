function centre = getCenterCoords(C1,C2,varargin)
    
    %������
    p = inputParser;
    %�����飬�����C1��C2��Ҫ��һ����������Ԫ�ص�����
    p.addRequired('C1',@(C1)  validateattributes(C1,{'numeric'},{'numel',2},'getCenterCoords','C1',1));
    p.addRequired('C2',@(C2)  validateattributes(C2,{'numeric'},{'numel',2},'getCenterCoords','C2',2));
    
    defaultC3 = C2;
    p.addOptional('C3',defaultC3,@(C3)  validateattributes(C3,{'numeric'},{'numel',2},'getCenterCoords','C3',3));
    defaultC4 = C2;
    p.addOptional('C4',defaultC4,@(C4)  validateattributes(C4,{'numeric'},{'numel',2},'getCenterCoords','C4',4));
    
    p.parse(C1,C2,varargin{:});
    %������
    
    C = p.Results.C1;
    Cdiagonal = p.Results.C2;
    
    if(C(1)==Cdiagonal(1)||C(2)==Cdiagonal(2))
        Cdiagonal = p.Results.C3;
        if(C(1)==Cdiagonal(1)||C(2)==Cdiagonal(2))
            Cdiagonal = p.Results.C4;
        end
    end
    
    centre = [0,0];
    centre(1) = ( C(1)+Cdiagonal(1) )/2;
    centre(2) = ( C(2)+Cdiagonal(2) )/2;
end