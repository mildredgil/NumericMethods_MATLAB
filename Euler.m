%Parameters: function, initX, initY, h, iteretions
%output    : root, vector, message 
function [varargout] = Euler(f, x, y, h, it)
            func = matlabFunction(evalin(symengine, f));
            dxdy = diff(evalin(symengine, f));
            handle = matlabFunction(dxdy);
            v = [x; y];
            realY = [];
            for i=1:it
               fx = handle(x);
               realY = [realY; func(x)];
               y = y + (fx*h);
               x = x + h;
               v = [v, [x;y]];
            end
            varargout{1} = x;
            varargout{2} = v;
            %varargout{3} = realY;
            varargout{3} = 'success';
 end
                
                
            
            