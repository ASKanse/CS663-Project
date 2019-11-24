wb_factor = [0 0.25 0.5 0.75 1];
flash_image = imread('../data/flash_pots.jpg');
amb_image = imread('../data/amb_pots.jpg');
s = size(amb_image);
amb_double = im2double(amb_image);
flash_double = im2double(flash_image);

hsv_flash = rgb2hsv(flash_image);
hsv_amb = rgb2hsv(amb_image);

for i = 1:5
hsv_wb(:,:,2) = (1-wb_factor(i))*hsv_amb(:,:,2) + wb_factor(i)*hsv_flash(:,:,2);
hsv_wb(:,:,1) = hsv_amb(:,:,1);
hsv_wb(:,:,3) = (1-wb_factor(i))*hsv_amb(:,:,3) + wb_factor(i)*hsv_flash(:,:,3);

rgb_adjusted = hsv2rgb(hsv_wb);
figure;imshow(rgb_adjusted);

end

