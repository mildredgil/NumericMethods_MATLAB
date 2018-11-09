%Parameters: handle, min, max, #iteretions
%output    : root, ea, vector, message
function [varargout] = bisection(h, min, max, it)

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
  varargout{3} = [0];
  varargout{4} = 'Success!';

%verify if limits are correct (positive and negative)
else
  if(handle(Xi)*handle(Xu) > 0)
      is_continue = false;

      varargout{1} = 0;
      varargout{2} = 0;
      varargout{3} = [0];
      varargout{4} = 'Both evaluated limits have the same sign.';
  end
end

while(is_continue)
    iteration = it;
    counter = 1;
    ea = 0;
    varargout{3} = [];
    while(counter <= iteration)
        Xr = (Xi + Xu) / 2;
        if(counter > 1)
            ea = abs((Xr - ea) / Xr) * 100;
            varargout{3} = [varargout{3} ea];
        end
        if(round(handle(Xr),4)== 0)
            varargout{1} = Xr;
            counter = iteration;
            is_root = true;
            varargout{4} = 'Success!';
            is_continue = false;
        elseif(handle(Xr)*handle(Xi) < 0)
            Xu = Xr;
        elseif(handle(Xr)*handle(Xi) > 0)
            Xi = Xr;
        end
        ea = Xr;
        varargout{2} = ea;
        counter = counter + 1;
    end
    if(~is_root)
        varargout{1} = Xr;
        if(Xi == Xu)
            varargout{4} = 'Try with other limits.';
            is_continue = false;
        else
            varargout{4} = 'Try with more iterations.';
            is_continue = false;
        end
    end
end

display(varargout{3});
