function AnimationPlot(allCoordinates,depthsCoordinates,waterLevel)

    waterLineIndexes = boundary(depthsCoordinates(:,2),depthsCoordinates(:,1),0);
    waterLine = depthsCoordinates(waterLineIndexes,:);
    waterLine = TransformBoundary(waterLine,1.04);

    groundLineIndexes = boundary(allCoordinates(:,2),allCoordinates(:,1),0);
    groundLine = allCoordinates(groundLineIndexes,:);
    groundLine = TransformBoundary(groundLine,1.06);

    figure
    hold on
    set(gcf, 'Units', 'Normalized', 'Outerposition', [0, 0, 1, 1]);
    axis([min(allCoordinates(:,2))-20,max(allCoordinates(:,2))+20,...
        min(allCoordinates(:,1))-20,max(allCoordinates(:,1))+20]);

    fill(groundLine(:,2),groundLine(:,1),[0.60,0.42,0.14]);
    fill(waterLine(:,2),waterLine(:,1),[0.53,0.81,0.98]);

    animLine = animatedline('LineWidth',3,'Color',[0.03,0.47,0.47]);
    boat = scatter(depthsCoordinates(1,2),depthsCoordinates(1,1),100,...
    'filled','o','MarkerEdgeColor','k','MarkerFaceColor','k');

    for i = 1:1:length(depthsCoordinates(:,1))
        addpoints(animLine,depthsCoordinates(i,2),depthsCoordinates(i,1));
        set(boat,'XData',depthsCoordinates(i,2),'YData',depthsCoordinates(i,1));
        cHours = fix(depthsCoordinates(i,5));
        cMinutes = fix((depthsCoordinates(i,5) - cHours)*60);
        cSeconds = fix(((depthsCoordinates(i,5) - cHours)*60 - cMinutes)*60);
        titleString = sprintf('Time: %d:%d:%d,  North: %.3fm,  East: %.3fm,  Depth: %.2fm',...
            cHours,cMinutes,cSeconds,depthsCoordinates(i,1),depthsCoordinates(i,2),depthsCoordinates(i,4));

        title(titleString,'FontSize',20);
        pause(0.05);
        drawnow
    end
    hold off

    plot3(depthsCoordinates(:,2),depthsCoordinates(:,1),ones(length(depthsCoordinates(:,3)),1)*waterLevel,'Color',...
        'r','LineWidth',3);
    hold on
    trianglesD = delaunay(allCoordinates(:,2),allCoordinates(:,1));
    trimesh(trianglesD,allCoordinates(:,2),allCoordinates(:,1),...
        allCoordinates(:,3),'facecolor',[0.62,0.32,0.17],'edgecolor','k');

end

