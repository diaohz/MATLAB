function DispButcherTableau(A,b,c)

    n = size(A,1);

    pre= 4; % precision
    fw = pre+2+1; % field width
    FormSpec = ['% ',num2str(fw),'.',num2str(pre),'f'];

    leadTab = repmat(' ',1,3);

    % print c(i) | A(:,j)
    for i = 1:n
        fprintf(1,[leadTab,FormSpec,' |'], c(i));
        for j = 1:n
            fprintf(1, [' ', FormSpec], A(i,j));
        end
        fprintf(1,'\n');
    end

    % print the seperator line
    tmp = repmat('-', 1, fw+1+n*(fw+1));
    fprintf(1, [leadTab, ' ', tmp, '\n']);

    % print   | b(i)
    fprintf(1, [leadTab, repmat(' ',1,fw+1),'|']);
    for i = 1:n
        fprintf(1, [' ', FormSpec], b(i));
    end
    fprintf(1, '\n');
end