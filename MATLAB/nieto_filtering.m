% For Gray Scale Images
% Tau is lines estimated girth.
function y = nieto_filtering(image, tau)
siz = size(image);
y = image;
y(:) = 0;
tauabs = tau;
for i = 1:1:siz(1) % rows
    img_column = image(i,:);
    y_column = y(i,:);
    for j = (1+tau):1:(siz(2)-tau) % columns
        if img_column(j) ~= 0
            aux = 2*img_column(j);
            aux = aux - (img_column(j-tau) + img_column(j+tau));
            aux = aux - abs(img_column(j-tau) - img_column(j+tau));
            if aux<0
                aux = 0;
            end
            if aux>255
                aux = 255;
            end
            y_column(j) = aux;
        end
    end
    y(i,:) = y_column;
end
end
