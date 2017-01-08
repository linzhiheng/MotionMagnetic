function J = getJacobi(Xi,Eta,coords)
%     %
%     validateattributes(Xi,{'numeric'},{'>=',-1,'<=',1},'getJacobi','Xi',1);
%     validateattributes(Eta,{'numeric'},{'>=',-1,'<=',1},'getJacobi','Eta',2);
%     validateattributes(coords,{'numeric'},{'size',[4,2]},'getJacobi','coords',3);
%     %
%     matrix1 = [-(1+Eta), -(1-Eta),   1-Eta,    1+Eta;...
%                         1-Xi,      -(1-Xi),   -(1+Xi),   1+Xi  ];
%     matrix2 = coords;
%     
%     J = det( 0.25*(matrix1*matrix2) );
    J = -0.25;
end