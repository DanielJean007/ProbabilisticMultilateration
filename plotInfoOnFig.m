function surfacePlotted =  plotInfoOnFig(Distro, plotPart)

    figure;
    hold on;
    grid on;
    
    surfacePlotted = surfc(Distro.surfaceX, Distro.surfaceY, plotPart);
    
    colorbar;
%     lgd = legend([query, optimum, origin],'Location','southoutside','Orientation','horizontal');
%     lgd.Interpreter = 'latex';
    set(gca,'FontSize',35, 'Box', 'on', 'linewidth', 1.5);
    view(3);
end