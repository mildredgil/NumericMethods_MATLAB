%{
Newton Raphson system equations
Input  : 
% matEq  Matrix with the n equations
% vVal   Vector with the initial value of the variables
% it     Number of iterations
output : 
% vRoots
% vEa
% message
%}
function [varargout] = NRS(matEq, vVal, it)
    n = size(matEq,1);
    v = [vVal];
    vEa = [];
    syms(sym('x', [1 n]));
    for i=1:n
        x(i) = evalin(symengine, "x" + i); 
    end

    for i=1:n
        F = [];
        J = [];
        for j=1:n
            F = [F; evalin(symengine,matEq{j,1})];   %convert to expression
        end
        for k=1:n  %se guarda las derivadas evaluadas en xk para el Jacobiano
            J = jacobian(F,x);
        end
    end
    
    for q=1:it       
        Fe = subs(F,x,transpose(v(:,q)));
        Je = subs(J,x,transpose(v(:,q)));
        v = [v, v(:,q)-(Je^-1)*Fe];
        ea = [];
        for p=1:n
            ea = [ea; abs((v(p,q+1)-v(p,q))/v(p,q+1))*100];
        end
        vEa = [vEa, ea];
    end   
    
    varargout{1} = eval(vpa(v(:,it)));
    varargout{2} = vEa;
    varargout{3} = 'success!';
end

