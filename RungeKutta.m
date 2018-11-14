%Parameters: function, initX, initY, h, iteretions
%output    : root, vector, message
function [varargout] = RungeKutta(f, initX, initY, h, it)
           handle = matlabFunction(evalin(symengine, f)); 
           xi = initX;
           yi = initY;
           vxy = [xi; yi];
           for i=1:it
               k1= handle(xi,yi);
               
               kx2= xi + ((1/2) * h); 
               ky2= yi + ((1/2) * k1 * h);
               k2 = handle(kx2,ky2); 
               
               kx3= xi + ((1/2) * h); 
               ky3= yi + ((1/2) * k2 * h); 
               k3 = handle(kx3,ky3); 
               
               kx4= xi + h;
               ky4= yi + (k3 * h);
               k4 = handle(kx4,ky4);
               
               yii= yi + (1/6 * (k1+2*k2+2*k3+k4))*h;
               yi = yii;
               xi = xi + h;
               vxy = [vxy, [xi; yi]];
           end
           varargout{1} = xi;
           varargout{2} = vxy;
           varargout{3} = 'Success!';
           
end