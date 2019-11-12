function [img1_crop, img2_crop, img3_crop, img4_crop] = crop_imgs(img1, img2, img3, img4, start_y, start_x, size)
    img1_crop =  img1(start_y:start_y+size, start_x:start_x+size, :);
    img2_crop =  img2(start_y:start_y+size, start_x:start_x+size, :);
    img3_crop =  img3(start_y:start_y+size, start_x:start_x+size, :);
    img4_crop =  img4(start_y:start_y+size, start_x:start_x+size, :);
end