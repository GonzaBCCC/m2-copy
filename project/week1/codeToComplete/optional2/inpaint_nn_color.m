function I = inpaint_nn_color(I, mask_name)
    
    % Normalize values into [0,1]
    I = I-min(I(:));
    I = I/max(I(:));

    % Load the mask
    % We want to inpaint those areas in which mask == 1
    %   mask(i,j) == 1 means we have lost information in that pixel
    %   mask(i,j) == 0 means we have information in that pixel
    mask = double(imread([mask_name]));

    [ni, nj, nC] = size(mask);
    if nC==3
        mask = mask(:,:,1); %Convert to b/w. If you load a color image you should comment this line
    end
    
    inverse_mask = mask == 0;

    % D = bwdist(BW) computes the Euclidean distance transform of the binary 
    % image BW. For each pixel in BW, the distance transform assigns a number 
    % that is the distance between that pixel and the nearest nonzero pixel of 
    % BW.
    % [D,IDX] = bwdist(BW) also computes the closest-pixel map in the form of 
    % an index array, IDX. (The closest-pixel map is also called the feature 
    % map, feature transform, or nearest-neighbor transform.) IDX has the same 
    % size as BW and D. Each element of IDX contains the linear index of the 
    % nearest nonzero pixel of BW.
    % Font: https://es.mathworks.com/help/images/ref/bwdist.html
    [nn_distances, nn_indexes] = bwdist(inverse_mask, 'euclidean');

    % find(X) returns a vector containing the linear indices of each nonzero element in array X.
    % Font: https://es.mathworks.com/help/matlab/ref/find.html
    [idx_i, idx_j] = find(mask);

    for pos=1:length(idx_i)  % for each unknown pixel (i, j) ...
        i = idx_i(pos);
        j = idx_j(pos);
        I(i, j) = I(nn_indexes(i, j));  % ... assign the value of the nn
    end
    
end