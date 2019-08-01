function y = process_image(image, x1, y1, x2, y2)
% Crear ROI
ROI_image = ROI(image, x1, y1, x2, y2);
% Pre-procesado
filtered_ROI = imgaussfilt(ROI_image, 1);
gray_filt_ROI = rgb2gray(filtered_ROI);
gray_double = im2double(gray_filt_ROI);
% normalized_image = normalizar_img(gray_double);
nieto = nieto_filtering(gray_double, 100); % Extraer lineas
level = graythresh(nieto); binarized = imbinarize(nieto, level); % Binarizar imagen
treated_image = bwareaopen(binarized,90); % Eliminar todos los objetos con menos de 90 pixeles.
edges = edge(treated_image, 'Sobel');
%edges = edge(treated_image, 'Canny', [0.1, 0.25]); % Deteccion de bordes   
%y = treated_image;
y = edges;
end

