function S = getTriangleArea(a,b,c)
    %������
    validateattributes(a,{'numeric'},{'positive'},'getTriangleArea','a',1);
    validateattributes(b,{'numeric'},{'positive'},'getTriangleArea','b',2);
    validateattributes(c,{'numeric'},{'positive'},'getTriangleArea','c',3);

    L = 0.5*(a+b+c);
    S = sqrt( L*(L-a)*(L-b)*(L-c) );
end