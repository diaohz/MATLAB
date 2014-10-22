function absolute_path = pth2fullpath(pth)
% PATHMERGER - Convert a relative path to an absolute path.

    % Replace the ~/ with the full path
    if strcmp(pth(1),'~')
        pth(1) = '';
        pth = strcat(getenv('HOME'), pth);
    end
    % Remove the file separator if it appears at the beginning.
    if pth(1)==filesep
        pth(1) = '';
    end
    % Remove the file separator if it appears at the end.
    if pth(end)==filesep
        pth(end) = '';
    end

    % Find the first file separator in PTH.
    idx = find(pth==filesep, 1);

    % Locate the last letter of the first folder
    % in the input relative path.
    if isempty(idx)
        % PTH only contains the name of a folder.
        idx = length(pth);
    else
        idx = idx-1;
    end

    % Find starting position of the duplicated part in PWD.
    idx = strfind(pwd, pth(1:idx));
    pathBEFOREpth = pwd;
    if isempty(idx)
        % There is not overlapping between PWD and PTH.
        pth = strcat(filesep, pth);
    else
        idx = idx - 1;
        pathBEFOREpth = pathBEFOREpth(1:idx);
    end

    absolute_path = strcat(pathBEFOREpth, pth);
end
