%% This script should find the speculations in the flash image, using the flash no flash pair
% A stands for the ambient image
% F - Flash Image
% M_SHADOW - masks from flash
%YUV_A = rgb2ycbcr(imread('../../data/`'));
%YUV_F = rgb2ycbcr(imread('../../data/carpet_00_flash.tif'));
%A = YUV_A(:,:,1) - sum(sum(YUV_A(:,:,1)))/prod(size(YUV_A(:,:,1)));
%F = YUV_F(:,:,1) - sum(sum(YUV_F(:,:,1)))/prod(size(YUV_F(:,:,1)));

%A3 = (imread('../../data/cave01_01_noflash.tif'));
%F3 = (imread('../../data/cave01_00_flash.tif'));
function [MASK] = getMask(A3,F3,t_spec,t_shadow)
A = A3(:,:,1) * 0.2126 + A3(:,:,2) * 0.7152 + A3(:,:,3) * 0.0722; % formula for luma https://en.wikipedia.org/wiki/Luma_(video)
F = F3(:,:,1) * 0.2126 + F3(:,:,2) * 0.7152 + F3(:,:,3) * 0.0722; % ITU-R BT.709
MASK_SHADOWS = zeros(size(A));
MASK_SPECULATIONS = F > (t_spec * max(F(:)));
se = exp(-(-20:20).^2/32);
se = se'*se;
MASK_SPECULATIONS = double(MASK_SPECULATIONS);
MASK_SPECULATIONS = imfilter(MASK_SPECULATIONS,se);
MASK_SPECULATIONS = (MASK_SPECULATIONS>(max(MASK_SPECULATIONS(:)) + MASK_SPECULATIONS>min(MASK_SPECULATIONS(:))/2));
%figure; imshow(MASK_SPECULATIONS);
se = strel('disk',2,8);
MASK_SHADOWS = (F-A) < t_shadow;
%figure;imagesc(MASK_SHADOWS);
MASK_SHADOWS = imerode(MASK_SHADOWS,se);
%figure;imshow(MASK_SHADOWS);
%se = exp(-(-20:20).^2/32);
%se = se'*se;
%MASK_SHADOWS = double(MASK_SHADOWS);
%MASK_SHADOWS = imfilter(MASK_SHADOWS,se);
%MASK_SHADOWS = (MASK_SHADOWS>(max(MASK_SHADOWS(:)) + MASK_SHADOWS>min(MASK_SHADOWS(:))/2));

MASK = (logical(MASK_SHADOWS) | logical(MASK_SPECULATIONS));
figure;imshow(MASK)
imwrite(MASK,'../../results/BOTTLE_MASK','png');

end
