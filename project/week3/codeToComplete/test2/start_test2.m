clearvars;
dst = double(imread('test2_dest.jpg'));
src = double(imread('test2_src.jpg'));  % flipped girl, because of the eyes
[ni,nj, nChannels]=size(dst);

param.hi=1;
param.hj=1;

mask_src=logical(im2bw(imread('test2_src_mask.jpg'), 0.4));
mask_dst=logical(im2bw(imread('test2_dest_mask.jpg'), 0.4));


for nC = 1: nChannels
    % source image gradient computed with forward differences    
    drivingGrad_i = G11DiFwd(src(:,:,nC),1);  % forward difference vertical
    drivingGrad_j = G11DjFwd(src(:,:,nC),1);  % forward difference horizontal

    % src function laplacian operator
    driving_on_src = -(drivingGrad_i - G11DiBwd(src(:,:,nC),1) + drivingGrad_j - G11DjBwd(src(:,:,nC),1));
    
    driving_on_dst = zeros(size(src(:,:,1)));   
    driving_on_dst(mask_dst(:)) = driving_on_src(mask_src(:));
    
    param.driving = driving_on_dst;
    dst1(:,:,nC) = G11_Poisson_Equation_Axb(dst(:,:,nC), mask_dst,  param);
end


figure(2)
imshow(dst1/256)
