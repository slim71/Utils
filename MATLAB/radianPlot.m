function radianPlot(xs, gap, ys)
% If you had so many points to plot it would crash your program. 
% Therefore, you should add some restriction in the begining of the function.

    axisX = xs(1):gap:xs(end);

    plot(xs, ys)
    set(gca, 'XTick')
    % how to have it 'elegantly'?
    set(gca, 'XTickLabel', string(sym(axisX)))

    grid on
end