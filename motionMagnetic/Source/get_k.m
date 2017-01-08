%get wave number 'k'
function k = get_k(omega,D)
y = @(k) 9.8*k*tanh(k*D)-omega^2;
opt = optimset('TolFun',1e-16,'Display','off');
k = fsolve(y,0,opt);