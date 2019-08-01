% MinLength, si son mas cortas que..., elimina la linea
% FillGap, si el gap entre dos lineas del mismo bin es mas grande que...no une la linea.
function y = hough_lines(binary_image, min_line_length, fill_gap_between_lines, rhores, thresh)
% Ancho del cuadrado de Rho para decidir done caen los puntos
% Theta: valores de theta en los que recorremos el espacio x-y en funcion de
% theta para calcular rho = x*cos(theta) + y*sin(Theta)
%a1 = -79:1:-30; a2 = 31:1:80; a = [a1, a2];
a1 = -79:1:-30; a2 = 31:1:80; a = [a1, a2];
[H ,T, R]= hough(binary_image, 'RhoResolution', rhores, 'Theta', a); %'RhoResolution = 1 default, 'Theta = -90:89 default
P  = houghpeaks(H, 50, 'Threshold', thresh);
%P  = houghpeaks(H, 1000);
if isempty(P)
    P = [1 1; 1 1];
end
y = houghlines(binary_image, T, R, P, 'MinLength', min_line_length, 'FillGap', fill_gap_between_lines);
end