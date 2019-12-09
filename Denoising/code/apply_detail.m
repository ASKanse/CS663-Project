function [final_result] = apply_detail(A_NR, MASK, noflash,F_DETAIL)
	A_BASE(:,:,1) = basicBilateralFiltering(noflash(:,:,1), 15, 0.2, 35);
	A_BASE(:,:,2) = basicBilateralFiltering(noflash(:,:,2), 15, 0.2, 35);
	A_BASE(:,:,3) = basicBilateralFiltering(noflash(:,:,3), 15, 0.2, 35);
    figure;imshow(A_BASE)
    imwrite(A_BASE,'../../results/BOTTLE_A_BASE','png');

	final_result = (1 - MASK).*A_NR.*F_DETAIL + MASK .* A_BASE;
end
