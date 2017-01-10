clear;
clc;

gpsGDir = 'GPS_G.txt';
gpsWDir = 'GPS_W.txt';
echoSDir = 'Echo Sounder.txt';

[gpsGroundData,gpsWaterData,echoSounderData] = DataInput(gpsGDir,gpsWDir,echoSDir);

waterLevel = 781.44;
timeDifference = 1; % GPS - Echo Sounder in seconds
boatDiffA = 1.67; % From backside to foreside
boatDiffB = 0.68; % From right to left

gpsWaterCData = OffsetCorrection(gpsWaterData,boatDiffA,boatDiffB);

[depthsX,depthsY] = CoordinatesInterpolation(timeDifference,echoSounderData,gpsWaterCData);

j = 1;
for i = 1:1:length(depthsX)
    if (~isnan(depthsX(i)))
        depthsCoordinates(j,1) = depthsX(i);
        depthsCoordinates(j,2) = depthsY(i);
        depthsCoordinates(j,3) = waterLevel - echoSounderData(i,2);
        depthsCoordinates(j,4) = echoSounderData(i,2);
        depthsCoordinates(j,5) = echoSounderData(i,1);
        j = j + 1;
    end
end

allCoordinates = [depthsCoordinates(:,1),depthsCoordinates(:,2),depthsCoordinates(:,3);...
    gpsGroundData(:,2),gpsGroundData(:,3),gpsGroundData(:,4)];

AnimationPlot(allCoordinates,depthsCoordinates,waterLevel);  



