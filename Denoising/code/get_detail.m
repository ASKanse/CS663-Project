function [f_detail]= get_detail(img_flash, ss, is, ws)
    r_bilateral = basicBilateralFiltering(img_flash(:,:,1), ss, is, ws);
    g_bilateral = basicBilateralFiltering(img_flash(:,:,2), ss, is, ws);
    b_bilateral = basicBilateralFiltering(img_flash(:,:,3), ss, is, ws);
    
%	r_bilateral = fastBilateral(img_flash(:,:,1),[ss,ss,10] );
%	g_bilateral = fastBilateral(img_flash(:,:,2),[ss,ss,10] );
%	b_bilateral = fastBilateral(img_flash(:,:,3),[ss,ss,10] );
    f_base = cat(3, r_bilateral, g_bilateral, b_bilateral);
    f = img_flash;
    %f_detail1 = (f + 0.02)./(f_base + 0.02);
    f_detail = (f + eps)./(f_base + eps);
    imwrite(f_detail,'../../results/BOTTLE_F','png');

    figure;imshow(f_detail);
end
