function [order, so] = OrderOfMethod(name,stage)

    if ~isempty(strfind(name,'RadauIIA')) || strcmp(name,'ImplicitEuler')
        tmp = 1;
    elseif ~isempty(strfind(name,'LobattoIIIC'))
        tmp = 2;
    elseif ~isempty(strfind(name,'Gauss'))
        tmp = 0;
    end

    order = 2*stage-tmp;
    so = stage-tmp+1; % stage order
end
