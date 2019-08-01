function y = draw_lines(image, lines, x1, y1, size, color_line)
%{
Lines must be inf format [x11 y11 x12 y12; x21 y21 x22  y22;...]
x11 y11 = left bottom corner
x12 y
x1 y2 x2 y2 are the coords from ROI, in order to place the lines found in
the ROI into the correct place on the real image.
%}
actual_frame = image;
real_lines = lines + [x1 y1 x1 y1];
for k = 1:length(lines(:,1))
    actual_frame = insertShape(actual_frame,'Line',real_lines(k,:),'LineWidth',size,'Color',color_line);
end
y = actual_frame;
end