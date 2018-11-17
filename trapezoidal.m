%Parameters: function, min, max, segments
%output    : integration, vector, message 
function [varargout] = trapezoidal(handle, min, max, sgm)
    %assign the handle
    f = matlabFunction(evalin(symengine, handle));
    Xi = min;
    Xu = max;
    n=sgm;
    %calculate the size of the segments
    h=(Xu-Xi)/n;
    %create an array with the points of the segments
    X = (Xi+h):h:(Xu-h);
    %calculate the integration
    Vy = [f(Xi), 2*f(X), f(Xu)];
    I = sum(Vy)*h*0.5;
    %create a vector(2x1) with the (x,y) values
    Vx = [Xi, X, Xu];
    v = [Vx;[f(Xi), f(X), f(Xu)]];
    %return values
    realI = integral(f,min,max);
    varargout{1} = I;
    varargout{2} = (realI-I)/realI;
    varargout{3} = v;
    varargout{4} = 'Success!';