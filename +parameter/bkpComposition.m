classdef Composition < parameter.rization
    properties
        % The cell contains the objects of each mapping.
        % The mapping sequence is
        % objlist{1} -> objlist{2} -> objlist{3} -> ...
        objlist
    end

    properties (Access=private)
        n % number of objects on the OBJLIST
    end

    %% properties %%
    %% methods    %%

    methods
        function cobj = Composition(varargin)
        % cobj: Composition Object
            cobj.name = 'Composite';

        % cobj.objlist = objectCell;
            cobj.objlist=varargin;
        end
        
        function set.objlist(cobj, objectCell)
            cobj.objlist = objectCell;
            cobj.n = length(objectCell);

            if ~isempty(cobj.y)
                notify(cobj,'UpdateOutput');
            end

            % When there is any updates in any object,
            % the entire compsite output will be updated.
            for nn = 1:cobj.n
                addlistener(cobj.objlist{nn},'UpdateOutput',@cobj.fun4output);
            end
        end

        function fun(cobj)
            cobj.objlist{1}.x = cobj.x;

            for nn = 2:cobj.n
                cobj.objlist{nn}.x = cobj.objlist{nn-1}.y;
            end

            cobj.y = cobj.objlist{cobj.n}.y;
        end
        function dfun(cobj)
            cobj.dydx = cobj.objlist{1}.dydx;

            for nn = 2:cobj.n
                cobj.dydx = cobj.dydx .* cobj.objlist{nn}.dydx;
            end
        end

        function plotMapping(cobj)
            fh = findall(0,'type','figure');
            if isempty(fh) fh=0; end
            figure(max(fh)+1);

            % define the smooth colors
            part4magenta= linspace(1,0,cobj.n+1);
            part4cyan   = linspace(0,1,cobj.n+1);
            for nn = 1:cobj.n+1
                colorStr{nn} = [part4magenta(nn), part4cyan(nn), 1];
            end

            % define the titles
            titleStr = cell(1,cobj.n+1);
            titleStr{1} = '$x$-plane';
            tmp = 'x';
            for nn = 1:cobj.n
                tmp = ['f_{',num2str(nn),'}(',tmp,')'];
                titleStr{nn+1} = ['$', tmp,'$-plane'];
            end

            % do the plotting
            for nn = 1:cobj.n
                subplot(1,cobj.n+1,nn);
                auxiliary.cmplxPlot(cobj.objlist{nn}.x,'.','Color',colorStr{nn});
                title(titleStr{nn},'Interpreter','latex');
                axis equal;
            end

            subplot(1,cobj.n+1,cobj.n+1);
            auxiliary.cmplxPlot(cobj.objlist{nn}.y,'.','Color',colorStr{nn+1});
            title(['y=',titleStr{cobj.n+1}],'Interpreter','latex');
            axis equal;
        end
    end
end