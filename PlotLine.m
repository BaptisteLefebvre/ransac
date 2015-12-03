function [  ] = PlotLine( h, l, style )
%PLOTLINE Summary of this function goes here
%   Detailed explanation goes here
    
    if l(2, 1) == 0
        x = - l(3, 1) / l(1, 1);
        plot(h, [x, x], [0 400], stlye);
    else
        x1 = 0;
        y1 = - (l(1, 1) * x1 + l(3, 1) * 1) / l(2, 1);
        x2 = 650;
        y2 = - (l(1, 1) * x2 + l(3, 1) * 1) / l(2, 1);
        plot(h, [x1, x2], [y1, y2], style);
    end
    
end

