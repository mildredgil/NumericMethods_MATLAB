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
            % Calculate x,y
           minX = min(v(1,:));
           maxX = max(v(1,:));
                            
           position = (maxX-minX)/it;
           x = minX:position:maxX;
            
           g = handle(x);
           error = (g-v(2,:))./g;
           
           varargout{1} = x;
           varargout{2} = v;
           varargout{3} = error;
           varargout{4} = 'success';
 end
                
                
            
            