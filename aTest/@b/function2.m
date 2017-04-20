function f = function2(~, varargin)
    A = varargin{1};
    B = 50;
    f = @(x) A*x+B;
end

