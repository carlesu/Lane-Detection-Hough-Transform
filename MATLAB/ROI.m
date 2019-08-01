function y = ROI(image, x1, y1, x2, y2)
roi_coord = [x1 y1 x2 y2];
y = imcrop(image, roi_coord);
end