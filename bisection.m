%
% Original  : Naomi Macias Honti 
% Edited by : Mildred Gil Melchor 
% Created   : 05/10/2018
% Edited    : 11/07/2018

%Parameters: handle, min, max, #iteretions
function [varargout] = bisection(h, min, max, it)
%Se calcula Xr con:
%Xr = (Xi+Xu)/2
%Se calcula Ea con:
%Ea = abs((Xr-Xrp)/Xr)*100
%Se encuentra raiz cuando handle(Xr)=0 
display(h);
handle = matlabFunction(evalin(symengine, h));
Xi = min;
Xu = max;
continuar = true;
encontrado = false;
while(continuar)
    iteraciones = it;
    fprintf('\n');
    contador = 1;
    Ea = 0;
    varargout{3}=[];
    while(contador <= iteraciones)
        Xr = (Xi+Xu)/2;
        if(contador>1)
            Ea = abs((Xr-Ea)/Xr)*100;
            varargout{3} = [varargout{3} Ea];
        end        
        if(round(handle(Xr),4)== 0)
            varargout{1} = Xr;
            varargout{2} = Ea;
            contador = iteraciones;
            encontrado = true;
        elseif(handle(Xr)*handle(Xi) < 0)
            fprintf("\nXu toma el valor de Xr");
            Xu = Xr;
        elseif(handle(Xr)*handle(Xi) > 0)
            fprintf("\nXi toma el valor de Xr");
            Xi = Xr;
        end
        Ea = Xr;
        contador=contador+1;
    end
    fprintf("\n");
    if(encontrado)
        fprintf('Se encontro una raiz en %.4f\n',Xr);
        fprintf('Con un valor aproximado de error de %.2f\n',Ea);
        continuar = false;
        fprintf('\n');
    else
        if(Xi==Xu)
            fprintf('No hay una raiz entre los limites recibidos');
            continuar = false;
            fprintf('\n');
        else
            fprintf('Aun no se ha encontrado una raiz\n');
            continuar = input('Desea refinar? [true/1 o false/0] ');
        end
    end
end
end
