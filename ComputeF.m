function [ F ] = ComputeF( data, idx, Tp, Tq )
%COMPUTEF Summary of this function goes here
%   Detailed explanation goes here
    
    K = size(idx, 1);
    assert(7 < size(idx, 1));
    
    A = zeros(max(9, K), 9);
    for k = 1:K
        pk = Tp * [data(idx(k), 1:2) 1]';
        qk = Tq * [data(idx(k), 3:4) 1]';
        a = pk * qk';
        A(k, :) = a(:);
    end
    
    [~, ~, V] = svd(A);
    f = V(:, end);
    F = reshape(f, [3, 3])';
    
    [U, S, V] = svd(F);
    S(3, 3) = 0;
    %S = S / S(1, 1);
    F = U * S * V';
    F = Tq' * F * Tp;
    
end

