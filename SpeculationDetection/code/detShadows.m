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

SliderH = uislider(FigH,'position',[50 50 150  3],'limits',[1 40], 'ValueChangedFcn', @(SliderH,event) callbackfn(SliderH,YUV_A,YUV_F));
%addlistener(SliderH, 'Value', 'PostSet', @callbackfn);
movegui(FigH, 'center')
function callbackfn(SliderH,A,F)
    num          = SliderH.Value;
    TextH.String = num2str(num);
%imshow(((F-A)>num));
M = (F(:,:,1)-A(:,:,1)) < num;
imshow(M);
end
