function line_params = average_lines(parameters)

% parameters must be a list of [slope1, intercept1; slope2, intercept2,...]
% it returns averaged parameters
line_params = [];
if isempty(parameters)
    disp('none')
else
    avg_slope = mean(parameters(:,1));
    avg_intercept = mean(parameters(:,2));
    line_params = [avg_slope, avg_intercept];
end
end