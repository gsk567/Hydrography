function transBoundary = TransformBoundary(objBoundary,scale)

    scaleFactor = scale;
    centerPoint = [mean(objBoundary(:,1)),mean(objBoundary(:,2))];

    polarCoords = zeros(length(objBoundary(:,1)),2);
    for i = 1:1:length(objBoundary(:,1))
        polarCoords(i,1) = sqrt((objBoundary(i,1) - centerPoint(1))^2 + (objBoundary(i,2) - centerPoint(2))^2);
        polarCoords(i,2) = AlphaFromCoords(centerPoint(2),centerPoint(1),objBoundary(i,2),objBoundary(i,1));    
    end

    polarCoords(:,1) = polarCoords(:,1)*scaleFactor;

    ro = 200/pi;
    transBoundary = zeros(length(objBoundary(:,1)),2);
    for i = 1:1:length(objBoundary(:,1))
        transBoundary(i,1) = centerPoint(1) + polarCoords(i,1)*sin(polarCoords(i,2)/ro);
        transBoundary(i,2) = centerPoint(2) + polarCoords(i,1)*cos(polarCoords(i,2)/ro);    
    end

end