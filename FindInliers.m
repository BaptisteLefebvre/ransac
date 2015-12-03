function [ idx ] = FindInliers( data, F, sigma )
%FINDINLIERS Summary of this function goes here
%   Detailed explanation goes here
    
    K = size(data, 1);
    b = zeros([K, 1]);
    
    for k = 1:K
        pk = [data(k, 1:2) 1]';
        qk = [data(k, 3:4) 1]';
        ep = F * pk;
        ep = ep ./ repmat(sqrt(ep(1, :) .^ 2 + ep(2, :) .^ 2), 3, 1);
        dp = abs(dot(qk, ep));
        eq = F' * qk;
        eq = eq ./ repmat(sqrt(eq(1, :) .^ 2 + eq(2, :) .^ 2), 3, 1);
        dq = abs(dot(eq, pk));
        if dp < sigma && dq < sigma
            b(k, 1) = 1;
        end
    end
    
    idx = find(b);
    
end

