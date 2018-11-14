%Parameters: function, initX, initY, h, iteretions
%output    : root, vector, message 
function [varargout] = Euler(f, x, y, h, it)
            func = diff(evalin(symengine, f));
            handle = matlabFunction(func);
            v = [x; y];
            for i=1:it
               fx = handle(x);
               y = y + (fx*h);
               x = x + h;
               v = [v, [x;y]];
            end
            varargout{1} = x;
            varargout{2} = v;
            varargout{3} = 'Success!';
 end
                
                
            
            