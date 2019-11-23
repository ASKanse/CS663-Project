% choose data
cave_DATA = "cave01";
carpet_DATA = "carpet";

% set crop parameters
CROP_START_Y = 565;
CROP_START_X = 1205;
CROP_SIZE = 126;

% set denoising std
STD = 0.01;

%% Read cropped images
[cave_img_flash, cave_img_noflash, cave_img_bilateral, cave_img_result] = read_imgs(cave_DATA);  % also does im2double
[cave_img_flash, cave_img_noflash, cave_img_bilateral, cave_img_result] = crop_imgs(cave_img_flash, cave_img_noflash, cave_img_bilateral, cave_img_result, CROP_START_Y, CROP_START_X, CROP_SIZE);
%%
[carpet_img_flash, carpet_img_noflash, carpet_img_bilateral, carpet_img_result] = read_imgs(carpet_DATA);  % also does im2double
[carpet_img_flash, carpet_img_noflash, carpet_img_bilateral, carpet_img_result] = crop_imgs(carpet_img_flash, carpet_img_noflash, carpet_img_bilateral, carpet_img_result, CROP_START_Y, CROP_START_X, CROP_SIZE);

%% Perform PCA denoising
%cave_img_flash_denoised = separate_denoising(cave_img_flash, STD);
cave_img_noflash_denoised = separate_denoising(cave_img_noflash, STD);
%%
%carpet_img_flash_denoised = separate_denoising(carpet_img_flash, STD);
carpet_img_noflash_denoised = separate_denoising(carpet_img_noflash, 0.01, 7, 51, 20);

figure
%subplot(221), imshow(carpet_img_flash), title('Original flash');
subplot(121), imshow(carpet_img_noflash), title('Original noflash');
%subplot(223), imshow(carpet_img_flash_denoised), title('Denoised flash');
subplot(122), imshow(carpet_img_noflash_denoised), title('Denoised noflash');
%% Plot
figure
%subplot(221), imshow(cave_img_flash), title('Original flash');
subplot(121), imshow(cave_img_noflash), title('Original noflash');
%subplot(223), imshow(cave_img_flash_denoised), title('Denoised flash');
subplot(122), imshow(cave_img_noflash_denoised), title('Denoised noflash');
%%
figure
%subplot(221), imshow(carpet_img_flash), title('Original flash');
subplot(121), imshow(carpet_img_noflash), title('Original noflash');
%subplot(223), imshow(carpet_img_flash_denoised), title('Denoised flash');
subplot(122), imshow(carpet_img_noflash_denoised), title('Denoised noflash');

%%
carpet_detail_added = add_detail(carpet_img_noflash_denoised, carpet_img_flash, 5, 0.03, 35);
figure, imshow(carpet_detail_added);
