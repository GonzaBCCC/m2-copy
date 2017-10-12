clearvars;
dst = double(imread('lena.png'));
src = double(imread('girl.png')); % flipped girl, because of the eyes
[ni,nj, nChannels]=size(dst);

param.hi=1;
param.hj=1;

%masks to exchange: Eyes
mask_src=logical(imread('mask_src_eyes.png'));
mask_dst=logical(imread('mask_dst_eyes.png'));

for nC = 1: nChannels
    % source image gradient computed with forward differences    
    drivingGrad_i = G11DiFwd(src(:,:,nC),1);%forward difference vertical
    drivingGrad_j = G11DjFwd(src(:,:,nC),1);%forward difference horizontal
    % src function laplacian operator
    driving_on_src = drivingGrad_i - G11DiBwd(src(:,:,nC),1) + drivingGrad_j - G11DjBwd(src(:,:,nC),1);
    
    driving_on_dst = zeros(size(src(:,:,1)));   
    driving_on_dst(mask_dst(:)) = driving_on_src(mask_src(:));
    
    param.driving = driving_on_dst;
    dst1(:,:,nC) = sol_Poisson_Equation_Axb(dst(:,:,nC), mask_dst,  param);
end

%Mouth
%masks to exchange: Mouth
mask_src=logical(imread('mask_src_mouth.png'));
mask_dst=logical(imread('mask_dst_mouth.png'));
for nC = 1: nChannels
    % source image gradient computed with forward differences    
    drivingGrad_i = G11DiFwd(src(:,:,nC),1);%forward difference vertical
    drivingGrad_j = G11DjFwd(src(:,:,nC),1);%forward difference horizontal
    % src function laplacian operator
    driving_on_src = drivingGrad_i - G11DiBwd(src(:,:,nC),1) + drivingGrad_j - G11DjBwd(src(:,:,nC),1);
    
    driving_on_dst = zeros(size(src(:,:,1)));  
    driving_on_dst(mask_dst(:)) = driving_on_src(mask_src(:));
    
    param.driving = driving_on_dst;

    dst1(:,:,nC) = sol_Poisson_Equation_Axb(dst1(:,:,nC), mask_dst,  param);
end
figure(2)
imshow(dst1/256)
