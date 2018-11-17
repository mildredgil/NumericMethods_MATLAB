function [varargout] = simpson(eq, min, max, sgm)
    f = matlabFunction(evalin(symengine, eq));
    h = (max-min)/sgm;
    vX = min:h:max;
    eq2 = 0;
    for i=2:sgm
        if(mod(i,3) == 1)
           eq2 = eq2 + 2*f(vX(i));
        else
           eq2 = eq2 + 3*f(vX(i));
        end
        display(eq2);
    end
    vY = f(vX);
    I = 3*h*(f(vX(1))+eq2+f(vX(sgm+1)))/8;
    realI = integral(f,min,max);
    varargout{1} = I;
    varargout{2} = (realI-I)/realI;
    varargout{3} = [vX;vY];
    varargout{4} = 'Success!';
end
