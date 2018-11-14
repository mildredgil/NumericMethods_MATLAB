%Parameters: Vector #X, Vector #B, #iteretions
%output    : root, ea, vector, message
function [varargout] = gaussSeidel(vecX,vecB,it)
% Recibir datos
funciones = vecX;
B = vecB;
basura = funciones.^2;
[valores ordenX] = max(basura,[],2);
valores = valores.^(1/2);
cant = max(ordenX);
[basura] = unique(ordenX);
if(cant~=length(basura))
    varargout{1}=0;
    varargout{2}=0;
    varargout{3}='No converge.';
else
    Xp = zeros(1,cant);
    for i=1:cant
        if(funciones(i,ordenX(i))<0)
            B(i)= B(i)*(-1);
        else
            funciones(i,:)=funciones(i,:)*(-1);
        end
        funciones(i,ordenX(i))=0;
    end
    funciones = [B funciones];
    funciones=funciones(1:cant,:)./valores;
    encontrado = false;
        contador = ones(1,cant);
        varargout{2}=[];
        while(contador <= it)
            X = [1 Xp];
            for i=1:cant
                X(i+1) = sum(funciones(i,:).*X);
            end
            X(1) = [];
            Ea = (X-Xp)./X;
            Ea = (Ea.^2).^(1/2);
            Ea = 100*Ea;
            varargout{2}=[varargout{2} Ea'];
            if(round(X,4)==round(Xp,4))
                varargout{1} = [X;Ea];
                contador = it;
                encontrado = true;
                varargout{2}=varargout{2}';
                varargout{3}='Success!';
            end
            Xp = X;
            contador=contador+1;
        end
        if(~encontrado)
            varargout{1} = [X;Ea];
            varargout{2}=varargout{2}';
            varargout{3} = 'Aproximate answare.';
        end
end
display(varargout{2});
end