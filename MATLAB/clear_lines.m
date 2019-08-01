function [left_parameters, right_parameters] = clear_lines(image, lines)

%{
lines format must be lines.point1, and lines.point2 directly exported from
houghlines.
% Parameters contain [slope,intercept,size;...]
%}
left_parameters = [];
right_parameters = [];
if isempty(lines)
    disp('none');
else
    size_image = size(image);
    i = 1; j = 1; number_lines = 2;
    for k = 1:length(lines)
        line = [lines(k).point1, lines(k).point2]; % lines(k,:)
        size_line = line_length(line(1:2), line(3:4));
        [slope,intercept] = get_slope_intercept(line);
        close_y = size_image(1)-10;
        close_x = round((close_y-intercept)/slope);
        far_y = 10;
        far_x = round((far_y-intercept)/slope);
        if size_line > 50
            if (slope > 0.4) & (slope < 3) & (close_x > round(3*size_image(2)/4))  & (close_x < (size_image(2)+200)) & (far_x > round(size_image(2)/3)) & (i <= number_lines)% dcha
                right_parameters = [right_parameters;[slope, intercept, size_line]];
                i = i + 1;
            elseif (slope < -0.4) & (slope > -3) & (close_x < round(size_image(2)/4)) & (close_x > (0-200)) & (far_x < round(2*size_image(2)/3)) & (j <= number_lines)% izq
                left_parameters = [left_parameters;[slope,intercept, size_line]];
                j = j + 1;
            end
        end
    end
end
end