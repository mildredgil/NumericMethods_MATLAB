function [varargout] = simpson2(eq, min, max, it)

varargout{1} = 0;
varargout{2} = 0;
varargout{3} = [0];
varargout{4} = 'Both evaluated limits have the same sign.';
      
f = matlabFunction(evalin(symengine, eq));
Xi = min;
Xu = max;
X1 = (2*Xi+Xu)/3;
X2 = (Xi+2*Xu)/3;
eq2=0;
eq3=0;
n=it;
counter=1;
is_continue = true;
is_root = false;
ea=0;
h=(Xu-Xi)/n;
s=(3/8)*(f(Xi)+3*f(X1)+3*f(X2)+f(Xu));
% for i=0:nstep-1
%       % Determine number of segments and h
%       NN(i+1)=2^(i+1) ;
%       h=(b-a)/NN(i+1) ;
%       % Use the rule to find the approximation
%       integral = f(a) + f(b) ;
%       for j=1:2:NN(i+1)-1
%           integral = integral + 3*f(a+h*j) ;
%       end
%       for j=2:2:NN(i+1)-2
%           integral = integral + 3*f(a+h*j) ;
%       end
%       for j=3:2:NN(i+1)-3
%           integral = integral + 2*f(a+h*j) ;
%       end
% end
for i=2:3:n-1
    eq2= eq2 + 3*(f(i)+f(i+1));
end

for i=4:3:n-2
    eq3= eq3 + 2*(f(i));
end
while(counter <= it)
        Xr = (Xi + Xu) / n;
        if(counter > 1)
            ea = abs((Xr - ea) / Xr) * 100;
            varargout{3} = [varargout{3} ea];
        end
        varargout{2} = ea;
        counter = counter + 1;
end
I=3*h/8*(f(Xi)+eq2+eq3+f(Xu));
varargout{1}=I;
varargout{2} = ea;
varargout{3}=[varargout{3} ea];
varargout{4}='Success!';