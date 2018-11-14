%Parameters: handle, inicialValue, iteretions
%output    : root, ea, vector, message
function [varargout] = newtonRaphson(h,iv,it)
    syms x;
    %handle of the function
    handle = matlabFunction(evalin(symengine, h));
    %handle of the derivate
    handleD = matlabFunction(diff(evalin(symengine, h)));
    varargout{5} = handleD;
    Xp = iv;
    is_continue = true;
    is_root = false;
    if(is_continue)
        counter = 1;
        ea = 0;
        varargout{3}=[];
        while(counter <= it)
            X = Xp-(handle(Xp)/handleD(Xp));
            if(counter > 1)
            ea = abs((X-Xp)/X)*100;
            varargout{3} = [varargout{3} ea];
            end
            if(round(X,8)==round(Xp,8))
                varargout{1} = X;
                counter = it;
                is_root = true;
                varargout{4} = 'Success!';
            end
            Xp = X;
            varargout{2} = ea;
            counter=counter+1;
        end
        if(~is_root)
            varargout{4} = 'Aproximate answare.';
        end
    end
end