function [ result ] = DjBwd( I, hj )
% Compute the backward finite differences with respect to the
% j coordinate only for the 2:end columns. The first column is not replaced

    if (~exist('hj', 'var'))
        hj=1;
    end;

    result=I;
    result(:,end)= -result(:,end-1);
    result(:, 2:end-1) = (I(: ,2:end-1)-I(: ,1:end-2))./hj; 
    
end

