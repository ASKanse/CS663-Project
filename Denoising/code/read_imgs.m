function [img_flash, img_noflash, img_bilateral, img_result] = read_imgs(img_name)
    path_data = "data";
    path_prefix = path_data + "/" + img_name + "_";
    
    path_flash = path_prefix + "00_flash.tif";
    path_noflash = path_prefix + "01_noflash.tif";
    path_bilateral = path_prefix + "02_bilateral.tif";
    path_result = path_prefix + "03_our_result.tif";
    
    img_flash = im2double(imread(char(path_flash)));
    img_noflash = im2double(imread(char(path_noflash)));
    img_bilateral = im2double(imread(char(path_bilateral)));
    img_result = im2double(imread(char(path_result)));
end