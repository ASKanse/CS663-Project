function opImg=myBilateralFiltering_joint_intensity(NoflashImg, flashImg, ss, is)
[r,c]=size(NoflashImg);

%is=0.09; %intensity gaussian sigma
%ss=2; %spacial gaussian sigma
wind=7;  %window size
hwind=floor(wind/2);
%padding image to help apply filter to the image endings
NoflashPIpImg = padarray(NoflashImg,[hwind hwind],-1,'both');
NoflashPIpImg1=NoflashPIpImg;

flashPIpImg = padarray(flashImg,[hwind hwind],-1,'both');
flashPIpImg1=flashPIpImg;

%creating Spatial Gaussian Filter
sG1=fspecial('gaussian',wind,ss);


for i=(1+hwind):(r+hwind)
   for j=(1+hwind):(c+hwind)
       w=NoflashPIpImg(i-hwind:i+hwind,j-hwind:j+hwind); 
       flashw_r = flashPIpImg(i-hwind:i+hwind,j-hwind:j+hwind, 1);
       flashw_g = flashPIpImg(i-hwind:i+hwind,j-hwind:j+hwind, 2);
       flashw_b = flashPIpImg(i-hwind:i+hwind,j-hwind:j+hwind, 3);
       
       wl=~(logical(w==-1));  %logical window to cut the filter when pixels are on the edge of the image
       sG=(sG1.*wl);
       sG=sG./(sum(sum(sG)));
       % creating Intesity Gaussian Filter
       iG_r=flashw_r-flashPIpImg(i,j, 1);
       iG_g=flashw_g-flashPIpImg(i,j, 2);
       iG_b=flashw_b-flashPIpImg(i,j, 3);
       
       iG = exp(-(iG_r.^2 + iG_g.^2 + iG_b.^2) / (2*is*is));    
       iG=iG.*wl;
       iG=iG./(sum(sum(iG)));
       gM=(sG.*iG);           % Creating final Filter by multiplying corresponding intensity and spatial gaussian values
       gM=gM./(sum(sum(gM))); % Normalising final Filter so that the weights add upto 1
       int=sum(sum((w.*gM))); % weighted average of the pixels in the window
       NoflashPIpImg1(i,j)=int;
   end
end
opImg=NoflashPIpImg1(1+hwind:r+hwind,1+hwind:c+hwind);

end