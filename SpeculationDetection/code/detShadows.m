%% This script should find the speculations in the flash image, using the flash no flash pair
% A stands for the ambient image
% F - Flash Image
% M_SHADOW - masks from flash
close all;
YUV_A = rgb2ycbcr(imread('../../data/potsdetail_01_noflash.tif'));
YUV_F = rgb2ycbcr(imread('../../data/potsdetail_00_flash.tif'));


FigH = uifigure ;
%imshow(A,'parent',FigH.UIAxes);
TextH = uicontrol('style','text','position',[170 340 40 15]);
MASK_SHADOWS = zeros(size(YUV_A(:,:,1)));
MASK_SPECULATIONS = YUV_F(:,:,1) > (0.90 * max(YUV_A(:)));
se = exp(-(-20:20).^2/18);
se = se'*se;
MASK_SPECULATIONS = double(MASK_SPECULATIONS);
%MASK_SPECULATIONS = imdilate(MASK_SPECULATIONS,se);
MASK_SPECULATIONS = imfilter(MASK_SPECULATIONS,se);
MASK_SPECULATIONS = (MASK_SPECULATIONS>(max(MASK_SPECULATIONS(:)) + MASK_SPECULATIONS>min(MASK_SPECULATIONS(:))/2)) ;
figure; imshow(MASK_SPECULATIONS);
SliderH = uislider(FigH,'position',[50 50 150  3],'limits',[1 40], 'ValueChangedFcn', @(SliderH,event) callbackfn(SliderH,YUV_A,YUV_F,MASK_SHADOWS));
%addlistener(SliderH, 'Value', 'PostSet', @callbackfn);
movegui(FigH, 'center')
function callbackfn(SliderH,A,F,MASK_SHADOWS)
    num          = SliderH.Value;
    TextH.String = num2str(num);
%imshow(((F-A)>num));
MASK_SHADOWS = (F(:,:,1)-A(:,:,1)) < num;
imshow(MASK_SHADOWS);
end
