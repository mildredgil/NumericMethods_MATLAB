%Parameters: Vector #X, Vector #B, #iteretions
%output    : root, ea, vector, message
function [varargout] = gaussSeidel(vecX,vecB,it)
functions = vecX;
B = vecB;
trash = functions.^2;
[values positionX] = max(trash,[],2);
values = values.^(1/2);
cant = max(positionX);
[trash] = unique(positionX);
if(cant~=length(trash))
    varargout{1}=0;
    varargout{2}=0;
    varargout{3}=0;
    varargout{4}='No converge.';
else
    Xp = zeros(1,cant);
    for i=1:cant
        if(functions(i,positionX(i))<0)
            B(i)= B(i)*(-1);
        else
            functions(i,:)=functions(i,:)*(-1);
        end
        functions(i,positionX(i))=0;
    end
    functions = [B functions];
    functions=functions(1:cant,:)./values;
    f = [];
    f = [f; functions(positionX(1:cant),:)];
    is_root = false;
    counter = 1;
    varargout{3}=[];
    while(counter <= it)
        X = [1 Xp];
        for i=1:cant
            X(i+1) = sum(f(i,:).*X);
        end
        X(1) = [];
        Ea = (X-Xp)./X;
        Ea = (Ea.^2).^(1/2);
        Ea = 100*Ea;
        varargout{3}=[varargout{3} Ea'];
        if(round(X,8)==round(Xp,8))
            varargout{1} = X';
            varargout{2} = Ea';
            counter = it;
            is_root = true;
            varargout{3}=varargout{3}';
            varargout{4}='Success!';
        end
        Xp = X;
        counter=counter+1;
    end
    if(~is_root)
        varargout{1} = X';
        varargout{2} = Ea';
        varargout{3}=varargout{3}';
        varargout{4} = 'Aproximate answer.';
    end
end
end