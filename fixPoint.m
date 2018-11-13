%Parameters: handle, inicialValue, #iteretions
%output    : root, ea, vector, message
function [varargout] = fixPoint(h, iv, it)
handle = matlabFunction(evalin(symengine, h));
Xp = iv;
is_root = false;
counter = 1;
ea = 0;
varargout{3} = [];
while(counter <= it)
    X = handle(Xp);
    if(counter > 1)
        ea = abs((X-Xp)/X)*100;
        varargout{3} = [varargout{3} ea];
    end
    if(round(X,4)==round(Xp,4))
        varargout{1} = X;
        counter = iteraciones;
        is_root = true;
        varargout{4} = 'Success!';
    end
    varargout{2} = ea;
    Xp = X;
    counter = counter + 1;
end
if(~is_root)
    varargout{1} = X;
    varargout{4} = 'Aproximate answer.';
end
end
