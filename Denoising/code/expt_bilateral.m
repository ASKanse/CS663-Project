% choose data
DATA = "lamp";

% set crop parameters
CROP_START_Y = 565;
CROP_START_X = 1205;
CROP_SIZE = 256;

% set gaussian parameters
SPATIAL_SIGMA_SEPARATE = 0.061;
INTENSITY_SIGMA_SEPARATE = 1.8;

SPATIAL_SIGMA_COMBINED = 0.09;
INTENSITY_SIGMA_COMBINED = 2;

%% Read cropped images
[img_flash, img_noflash, img_bilateral, img_result] = read_imgs(DATA);  % also does im2double
[img_flash, img_noflash, img_bilateral, img_result] = crop_imgs(img_flash, img_noflash, img_bilateral, img_result, CROP_START_Y, CROP_START_X, CROP_SIZE);

%% Convert from rgb to L*a*b
img_noflash_lab = rgb2lab(img_noflash);
img_flash_lab = rgb2lab(img_flash);

%% Perform separate bilateral filtering
img_bilateral_separate = separate_bilateral(img_noflash, img_flash, SPATIAL_SIGMA_SEPARATE, INTENSITY_SIGMA_SEPARATE);
img_bilateral_separate_lab = lab2rgb(separate_bilateral(img_noflash_lab, img_flash_lab, SPATIAL_SIGMA_SEPARATE, INTENSITY_SIGMA_SEPARATE));

%% Perform combined bilateral filtering
img_bilateral_combined = combined_bilateral(img_noflash, img_flash, SPATIAL_SIGMA_COMBINED, INTENSITY_SIGMA_COMBINED);
img_bilateral_combined_lab = lab2rgb(combined_bilateral(img_noflash_lab, img_flash_lab, SPATIAL_SIGMA_COMBINED, INTENSITY_SIGMA_COMBINED));

%% Plot
subplot(3, 3, 1), imshow(img_flash), title('Original Flash');
subplot(3, 3, 2), imshow(img_noflash), title('Original NoFlash');
subplot(3, 3, 3), imshow(img_bilateral), title('Their Bilateral');
subplot(3, 3, 4), imshow(img_bilateral_separate), title('Separate Bilateral RGB');
subplot(3, 3, 5), imshow(img_bilateral_combined), title('Combined Bilateral RGB');
subplot(3, 3, 6), imshow(img_bilateral_separate_lab), title('Separate Bilateral L*a*b');
subplot(3, 3, 7), imshow(img_bilateral_combined_lab), title('Combined Bilateral L*a*b');