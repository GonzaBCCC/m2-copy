function [ result ] = G11DiFwd( I, hi )    
% Compute the Forward finite differences with respect to the
% i coordinate only for the 1:end-1 rows. The last row is set to zero
    
    if (~exist('hi', 'var'))
        hi=1;
    end;

    result=I;
    
    result(1:end-1, :) = (I(2:end, :)-I(1:end-1, :))./hi; %
    result(end,:) = 0;
    
end
