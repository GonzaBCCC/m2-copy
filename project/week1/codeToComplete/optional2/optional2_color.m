%Read the image
I = double(imread('../Image_to_Restore.png'));
% I = double(imread('../image6_toRestore.tif'));

[ni, nj, nC] = size(I);


I = I - min(I(:));
I = I / max(I(:));

figure(1);
subplot(1, 2, 1); imshow(I); title('Original');

%We want to inpaint those areas in which mask == 1 (red part of the image)
I_ch1 = I(:,:,1);
I_ch2 = I(:,:,2);
I_ch3 = I(:,:,3);

mask_name = '../Image_to_Restore_mask.png';
% mask_name = '../image6_mask.tif';

I(:,:,1)=inpaint_nn_color(I_ch1, mask_name);
I(:,:,2)=inpaint_nn_color(I_ch2, mask_name);
I(:,:,3)=inpaint_nn_color(I_ch3, mask_name);

subplot(1, 2, 2); imshow(I); title('Inpainting');
