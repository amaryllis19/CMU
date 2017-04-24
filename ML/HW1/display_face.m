function [] = display_face(Imgs, w, h, i)
    L = Imgs(i,:);
    L = reshape(L',w,h)';         % Reshapes column vector into a 2D array
    figure;
    image(L);
    colormap(gray(256));
    daspect([1 1 1]);
    axis off;
end
