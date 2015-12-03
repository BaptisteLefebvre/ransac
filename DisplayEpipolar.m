function [  ] = DisplayEpipolar( gca, h1, h2, x, y, F_best )
%DISPLAYEPIPOLAR Summary of this function goes here
%   Detailed explanation goes here
    
    if gca == h1
        plot(h1, x, y, 'ro', 'MarkerFaceColor', 'r');
        p = [x, y, 1]';
        ep = F_best * p; 
        PlotLine(h2, ep, 'r-');
    end
    if gca == h2
        plot(h2, x, y, 'bo', 'MarkerFaceColor', 'b');
        q = [x, y, 1]';
        eq = F_best' * q;
        PlotLine(h1, eq, 'b-');
    end
    
end

