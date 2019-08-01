function y = extrapolate_line(image, parameters)
%{
Parameters ? [slope, intercept, size]
output = [x1,y1,x2,y2]
%}
size_image = size(image);
slope = parameters(1);
intercept = parameters(2);
if slope < 0 %left
    if floor(intercept) < (size_image(1)-10)
        bottom_x = 0;
        bottom_y = intercept;
    else
        bottom_y = size_image(1)-10;
        bottom_x = round((bottom_y-intercept)/slope);
    end
end
if slope > 0
    bottom_y = size_image(1)-10;
    bottom_x = round((bottom_y-intercept)/slope);
    if bottom_x > size_image(2)
        bottom_x = size_image(2);
        bottom_y = slope*bottom_x + intercept;
    end
end
top_y = 10;
top_x = round((top_y-intercept)/slope);

y = [bottom_x bottom_y top_x top_y];
end