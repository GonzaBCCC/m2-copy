% VROF model inpainting

clearvars;

name= 'Image_to_Restore';

I = double(imread([ name '.png']));

%Number of pixels for each dimension, and number of channles
[ni, nj, nC] = size(I);

%Normalize values into [0,1]
I=I-min(I(:));
I=I/max(I(:));

%Load the mask
mask_img = double(imread([name '_mask.png']));

%We want to inpaint those areas in which mask == 1
for i=1:nC
    mask(:,:,i) = mask_img >0.5; %mask(i,j) == 1 means we have lost information in that pixel
                      %mask(i,j) == 0 means we have information in that
                      %pixel
end                                                                    

figure(1)
imshow(I);
title('Before')

%gradient descent parameters
p_0.x = zeros(size(I));
p_0.y = zeros(size(I));

tol = 10^(-2);
dt = 1/8;
iterMax = 200;
lambda = 0.05;

%VROF model TV minimization with Dual Problem approach
Iinp = G11_Bresson( I, p_0, mask, tol, dt, iterMax, lambda);

figure(3)
imshow(Iinp)
title('After');

