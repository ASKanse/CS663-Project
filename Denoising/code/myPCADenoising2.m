function [im2] = myPCADenoising2(im1, std)


[x, y] = size(im1);
avg = zeros(x,y);
im2 = zeros(x,y);
im1 = padarray(im1,[15 15],inf,'both');
ps = 7;
ws = 31;
P_n = zeros(49, 625);
for r=16 : (15+x-ps+1)
    for c=16 : (15+x-ps+1)
% Vectorizing all patches in current window
        count=1;
        window = im1(c-15:c+15,r-15:r+15);
        orig_patch = im1(c:c+ps-1, r:r+ps-1);
    for i=1 : (ws-ps+1)
    for j=1 : (ws-ps+1)
        patch = window(j:j+ps-1,i:i+ps-1);
        P_n(:,count) = patch(:);
        count = count+1;
    end
    end

 % Finding 200 nearest patches
    
    rmse = sqrt(sum((P_n - orig_patch(:)).^2)/49);
    m=min(size(find(rmse<inf),2),201);
    [B,I] = mink(rmse,m);
    P = zeros(49,m-1);
    pnc=1;
    for k=2:m
       P(:,pnc) = P_n(:,I(k));
       pnc = pnc+1;
    end
    
    
% Finding eigenspace

PPT = P*P';
[V,D] = eigs(PPT, 49);
alpha = V' * P;
alpha_sq = alpha.^2;
alpha_sum = (sum(alpha_sq,2)/m-1)-std^2;
alpha_sb = max(0,alpha_sum);

% Weiner filter like update

wf_den = 1./alpha_sb;
wf_den = (wf_den*std^2)+1;
alpha_fin = (V'*orig_patch(:))./wf_den;
P_fin = V * alpha_fin;
im2(c-15:c-15+ps-1,r-15:r-15+ps-1) = im2(c-15:c-15+ps-1,r-15:r-15+ps-1) + reshape(P_fin,[7,7]);
avg(c-15:c-15+ps-1,r-15:r-15+ps-1) = avg(c-15:c-15+ps-1,r-15:r-15+ps-1) + 1;     
    end
end

im2 = im2./avg;

end