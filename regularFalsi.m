%Parameters: handle, min, max, #iteretions
%output    : root, ea, vector, message
function [varargout] = regularFalsi(h, min, max, it)
handle = matlabFunction(evalin(symengine, h));
Xi = min;
Xu = max;
is_continue = true;
is_root = false;
%verify if limits are roots
if(handle(Xi)*handle(Xu) == 0)
    is_continue = false;
    if(handle(Xi) == 0)
        varargout{1} = Xi;
    else
        varargout{1} = Xu;
    end
    varargout{2} = 0;
    varargout{3} = 0;
    varargout{4} = 'Success!';
else
    %verify if limits are correct (positive and negative)
    if(handle(Xi)*handle(Xu) > 0)
        is_continue = false;
        varargout{1} = 0;
        varargout{2} = 0;
        varargout{3} = [0];
        varargout{4} = 'Try with other limits.';
    end
end
if(is_continue)
    counter = 1;
    ea = 0;
    varargout{3}=[];
    while(counter <= it)
        Xr = Xu-((handle(Xu)*(Xi-Xu))/(handle(Xi)-handle(Xu)));
        if(counter>1)
            ea = abs((Xr-ea)/Xr)*100;
            varargout{3} = [varargout{3} ea];
        end
        if(round(handle(Xr),4)== 0)
            varargout{1} = Xr;
            counter = it;
            is_root = true;
            varargout{4} = 'Success!';
        elseif(handle(Xr)*handle(Xi) < 0)
            Xu = Xr;
        elseif(handle(Xr)*handle(Xi) > 0)
            Xi = Xr;
        end
        varargout{2} = ea;
        ea = Xr;
        counter=counter+1;
    end
    if(~is_root)
        varargout{1} = Xr;
        if(Xi == Xu)
            varargout{4} = 'Try with other limits.';
        else
            varargout{4} = 'Try with more iterations.';
        end
    end
end
end