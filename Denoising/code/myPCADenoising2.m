function [im2] = myPCADenoising2(im1, std, ps, ws, nnp)


[x, y] = size(im1);
avg = zeros(x,y);
im2 = zeros(x,y);
hws = floor(ws/2);
im1 = padarray(im1,[hws hws],inf,'both');
P_n = zeros(ps*ps, (ws-ps+1)*(ws-ps+1));
pix_in_patch = ps*ps;
patches_in_window = (ws-ps+1)*(ws-ps+1);
for r=hws+1 : (hws+x-ps+1)
    for c=hws+1 : (hws+x-ps+1)
% Vectorizing all patches in current window
        count=1;
        window = im1(c-hws:c+hws,r-hws:r+hws);
        orig_patch = im1(c:c+ps-1, r:r+ps-1);
    for i=1 : (ws-ps+1)
    for j=1 : (ws-ps+1)
        patch = window(j:j+ps-1,i:i+ps-1);
        P_n(:,count) = patch(:);
        count = count+1;
    end
    end

 % Finding 200 nearest patches
    
    rmse = sqrt(sum((P_n - orig_patch(:)).^2)/pix_in_patch);
    m=min(size(find(rmse<inf),2),nnp);
    [B,I] = mink(rmse,m);
    P = P_n(:,I);
    
    
% Finding eigenspace

PPT = P*P';
[V,D] = eigs(PPT, pix_in_patch);
alpha = V' * P;
alpha_sq = alpha.^2;
alpha_sum = (sum(alpha_sq,2)/m-1)-std^2;
alpha_sb = max(0,alpha_sum);

% Weiner filter like update

wf_den = 1./alpha_sb;
wf_den = (wf_den*std^2)+1;
alpha_fin = (V'*orig_patch(:))./wf_den;
P_fin = V * alpha_fin;
im2(c-hws:c-hws+ps-1,r-hws:r-hws+ps-1) = im2(c-hws:c-hws+ps-1,r-hws:r-hws+ps-1) + reshape(P_fin,[ps,ps]);
avg(c-hws:c-hws+ps-1,r-hws:r-hws+ps-1) = avg(c-hws:c-hws+ps-1,r-hws:r-hws+ps-1) + 1;     
    end
end

im2 = im2./avg;

end