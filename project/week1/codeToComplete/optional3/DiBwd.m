function [ result ] = DiBwd( I, hi )
% Compute the backward finite differences with respect to the
% i coordinate only for the 2:end rows. The first row is not replaced

    if (~exist('hi', 'var'))
        hi=1;
    end;

    result=I;
    result(end,:)= -result(end-1,:);
    result(2:end-1, :) = (I(2:end-1, :)-I(1:end-2, :))./hi;
    
    
end
