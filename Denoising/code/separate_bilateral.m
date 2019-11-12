function img_bilateral_separate = separate_bilateral(img_noflash, img_flash, ss, is)
    img_bilateral_separate_r = myBilateralFiltering(img_noflash(:, :, 1), img_flash(:, :, 1), ss, is);
    img_bilateral_separate_g = myBilateralFiltering(img_noflash(:, :, 2), img_flash(:, :, 2), ss, is);
    img_bilateral_separate_b = myBilateralFiltering(img_noflash(:, :, 3), img_flash(:, :, 3), ss, is);

    img_bilateral_separate = cat(3, img_bilateral_separate_r, img_bilateral_separate_g, img_bilateral_separate_b);

end