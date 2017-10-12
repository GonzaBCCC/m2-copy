img1 = inpaint_nn('../image1_toRestore.jpg', '../image1_mask.jpg');
img2 = inpaint_nn('../image2_toRestore.jpg', '../image2_mask.jpg');
img3 = inpaint_nn('../image3_toRestore.jpg', '../image3_mask.jpg');
img4 = inpaint_nn('../image4_toRestore.jpg', '../image4_mask.jpg');
img5 = inpaint_nn('../image5_toRestore.jpg', '../image5_mask.jpg');

figure(1);
subplot(3, 2, 1); imshow(img1); title('Inpainting image 1');
subplot(3, 2, 2); imshow(img2); title('Inpainting image 2');
subplot(3, 2, 3); imshow(img3); title('Inpainting image 3');
subplot(3, 2, 4); imshow(img4); title('Inpainting image 4');
subplot(3, 2, 5); imshow(img5); title('Inpainting image 5');
