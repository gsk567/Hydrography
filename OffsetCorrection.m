function gpsWaterCData = OffsetCorrection(gpsWaterData,boatDiffA,boatDiffB)

    for i = 2:1:length(gpsWaterData)
       directions(i-1,1) = (200/pi)*atan2((gpsWaterData(i,2) - gpsWaterData(i-1,2)),...
           (gpsWaterData(i,3) - gpsWaterData(i-1,3)));
    end

    directions = [directions;directions(length(directions))];

    gpsWaterCData = gpsWaterData;
    for i = 1:1:length(directions)
        gpsWaterCData(i,3) = gpsWaterCData(i,3) + boatDiffA*cos(directions(i)/(200/pi)) - ...
            boatDiffB*sin(directions(i)/(200/pi));
        gpsWaterCData(i,2) = gpsWaterCData(i,2) + boatDiffA*sin(directions(i)/(200/pi)) + ...
            boatDiffB*cos(directions(i)/(200/pi));    
    end

end

