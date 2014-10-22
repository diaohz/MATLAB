function mydir(input)
    
    if nargin==0
        input = [];
    else
        input = [blanks(1),input];
    end
    
    expression = strcat('system(''ls -l', input, ''');');
    
    eval(expression);
end