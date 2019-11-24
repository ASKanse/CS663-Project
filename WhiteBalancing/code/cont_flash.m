alpha = [0 0.25 0.5 0.75 1];

flash_image = imread('../data/flash_bottels.jpeg');
amb_image = imread('../data/amb_bottels.jpeg');

[MOVINGREG_r] = registerImages(amb_image,flash_image);

amb_reg = MOVINGREG_r.RegisteredImage;
figure;imshow(amb_reg);


yrb_flash = rgb2ycbcr(flash_image);
%yrb_amb = rgb2ycbcr(amb_image);
yrb_amb = rgb2ycbcr(amb_reg);

y_flash = yrb_flash(:,:,1);
cb_flash = yrb_flash(:,:,2);
cr_flash = yrb_flash(:,:,3);
y_amb = yrb_amb(:,:,1);
cb_amb = yrb_amb(:,:,2);
cr_amb = yrb_amb(:,:,3);

for i = 1:5
y_adjusted = (1-alpha(i))*y_amb + alpha(i)*y_flash;
cb_adjusted = (1-alpha(i))*cb_amb + alpha(i)*cb_flash;
cr_adjusted = (1-alpha(i))*cr_amb + alpha(i)*cr_flash;

yrb_adjusted(:,:,1) = y_adjusted;
yrb_adjusted(:,:,2) = cb_adjusted;
yrb_adjusted(:,:,3) = cr_adjusted;

adjusted_image = ycbcr2rgb(yrb_adjusted);

figure;imshow(adjusted_image);
path = strcat('../results/baby_',num2str(alpha(i)*100),'.png');
imwrite(adjusted_image,path)
end

