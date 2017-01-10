function [depthsX,depthsY] = CoordinatesInterpolation(timeDifference,echoSounderData,gpsWaterCData)

    timeCorrection = timeDifference/3600;
    echoSounderCorrectedData = echoSounderData;
    echoSounderCorrectedData = echoSounderCorrectedData(:,1) + timeCorrection;

    depthsY = interp1(gpsWaterCData(:,1),gpsWaterCData(:,3),...
        echoSounderCorrectedData(:,1),'linear');

    depthsX = interp1(gpsWaterCData(:,1),gpsWaterCData(:,2),...
        echoSounderCorrectedData(:,1),'linear');

end

