function img_denoised = separate_denoising(img, std, ps, ws, nnp)
    img_denoised_r = myPCADenoising2(img(:, :, 1), std, ps, ws, nnp);
    img_denoised_g = myPCADenoising2(img(:, :, 2), std, ps, ws, nnp);
    img_denoised_b = myPCADenoising2(img(:, :, 3), std, ps, ws, nnp);
    
    img_denoised = cat(3, img_denoised_r, img_denoised_g, img_denoised_b);
end