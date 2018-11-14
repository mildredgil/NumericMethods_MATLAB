%Parameters: function, min, max, segments
%output    : integration, vector, message 
function [varargout] = trapezoidal(handle, min, max, sgm)

f = matlabFunction(evalin(symengine, handle));
Xi = min;
Xu = max;
n=sgm;
h=(Xu-Xi)/n;
X = Xi:h:Xu;
v = [];
s=0.5*(f(Xi)+f(Xu));
for i=1:n+1
    s = s+(f(X(i)));
    v = [v, [X(i); f(X(i))]];
end
varargout{1} = h*s;
varargout{2} = v;
varargout{3} = 'Success!';