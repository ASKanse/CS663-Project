% choose data
cave_DATA = "cave01";
carpet_DATA = "carpet";

% set crop parameters
CROP_START_Y = 565;
CROP_START_X = 1205;
CROP_SIZE = 255;

% set gaussian parameters
SPATIAL_SIGMA_SEPARATE = 0.061;
INTENSITY_SIGMA_SEPARATE = 1.8;

SPATIAL_SIGMA_COMBINED = 0.09;
INTENSITY_SIGMA_COMBINED = 2;

%% Read cropped images
[cave_img_flash, cave_img_noflash, cave_img_bilateral, cave_img_result] = read_imgs(cave_DATA);  % also does im2double
[cave_img_flash, cave_img_noflash, cave_img_bilateral, cave_img_result] = crop_imgs(cave_img_flash, cave_img_noflash, cave_img_bilateral, cave_img_result, CROP_START_Y, CROP_START_X, CROP_SIZE);
%%
[carpet_img_flash, carpet_img_noflash, carpet_img_bilateral, carpet_img_result] = read_imgs(carpet_DATA);  % also does im2double
%%
[carpet_img_flash, carpet_img_noflash, carpet_img_bilateral, carpet_img_result] = crop_imgs(carpet_img_flash, carpet_img_noflash, carpet_img_bilateral, carpet_img_result, 531, 2143, CROP_SIZE);

%% Convert from rgb to L*a*b
%cave_img_noflash_lab = rgb2lab(cave_img_noflash);
%cave_img_flash_lab = rgb2lab(cave_img_flash);
%carpet_img_noflash_lab = rgb2lab(carpet_img_noflash);
%carpet_img_flash_lab = rgb2lab(carpet_img_flash);

%% Perform separate bilateral filtering
cave_img_bilateral_separate = separate_bilateral(cave_img_noflash, cave_img_flash, 4, 0.07, 35);
%cave_img_bilateral_separate_lab = lab2rgb(separate_bilateral(cave_img_noflash_lab, cave_img_flash_lab, SPATIAL_SIGMA_SEPARATE, INTENSITY_SIGMA_SEPARATE));
carpet_img_bilateral_separate = separate_bilateral(carpet_img_noflash, carpet_img_flash, 5, 0.08, 35);
%carpet_img_bilateral_separate_lab = lab2rgb(separate_bilateral(carpet_img_noflash_lab, carpet_img_flash_lab, SPATIAL_SIGMA_SEPARATE, INTENSITY_SIGMA_SEPARATE));

%% Perform combined bilateral filtering
cave_img_noflash = im2double(cave_img_noflash);
cave_img_flash = im2double(cave_img_flash);
cave_img_bilateral_combined = combined_bilateral(cave_img_noflash, cave_img_flash, 4, 0.07, 35);
imshow(cave_img_bilateral_combined)
%%
carpet_img_noflash = im2double(carpet_img_noflash);
carpet_img_flash = im2double(carpet_img_flash);
carpet_img_bilateral_combined = combined_bilateral(carpet_img_noflash, carpet_img_flash, 5, 0.08, 35);
imshow(carpet_img_bilateral_combined)
%%
carpet_detail_added = add_detail(carpet_img_bilateral_combined, carpet_img_flash, 5, 0.08, 35);
figure, imshow(carpet_detail_added);

%%
cave_detail_added = add_detail(cave_img_bilateral_combined, cave_img_flash, 4, 0.07, 35);
figure, imshow(cave_detail_added);
carpet_detail_added = add_detail(carpet_img_bilateral_combined, carpet_img_flash, 5, 0.08, 35);
figure, imshow(carpet_detail_added);
%%
%cave_img_bilateral_combined_lab = lab2rgb(combined_bilateral(cave_img_noflash_lab, cave_img_flash_lab, SPATIAL_SIGMA_COMBINED, INTENSITY_SIGMA_COMBINED));

%% Plot
subplot(3, 3, 1), imshow(cave_img_flash), title('Original Flash');
subplot(3, 3, 2), imshow(cave_img_noflash), title('Original NoFlash');
subplot(3, 3, 3), imshow(cave_img_bilateral), title('Their Bilateral');
subplot(3, 3, 4), imshow(cave_img_bilateral_separate), title('Separate Bilateral RGB');
subplot(3, 3, 5), imshow(cave_img_bilateral_combined), title('Combined Bilateral RGB');
subplot(3, 3, 6), imshow(cave_img_bilateral_separate_lab), title('Separate Bilateral L*a*b');
subplot(3, 3, 7), imshow(cave_img_bilateral_combined_lab), title('Combined Bilateral L*a*b');