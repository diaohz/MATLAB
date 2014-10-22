function output = cmplxSort(input)
% COMPLXSORT - Sort the input complex points in an ordered way friendly for plotting.

    % Convert the input into an array
    input = reshape(input,1,[]);

    % Find the centroid of the points.
    center = mean(input);

    % Calculate the angles with respect to the centroid.
    tmp = angle(input-center);
    [~,idx] = sort(tmp);

    output = input(idx);
end
