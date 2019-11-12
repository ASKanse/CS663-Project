function img_bilateral_combined = combined_bilateral(img_noflash, img_flash, ss, is)
    img_bilateral_combined_r = myBilateralFiltering_joint_intensity(img_noflash(:, :, 1), img_flash, ss, is);
    img_bilateral_combined_g = myBilateralFiltering_joint_intensity(img_noflash(:, :, 2), img_flash, ss, is);
    img_bilateral_combined_b = myBilateralFiltering_joint_intensity(img_noflash(:, :, 3), img_flash, ss, is);

    img_bilateral_combined = cat(3, img_bilateral_combined_r, img_bilateral_combined_g, img_bilateral_combined_b);

end