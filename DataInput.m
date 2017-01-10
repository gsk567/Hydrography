function [gpsGroundData,gpsWaterData,echoSounderData] = DataInput(gpsGDir,gpsWDir,echoSDir)

    gpsGroundDataRaw = textread(gpsGDir, '%s', 'delimiter', '\n');
    gpsWaterDataRaw = textread(gpsWDir, '%s', 'delimiter', '\n');
    echoSounderDataRaw = textread(echoSDir, '%s', 'delimiter', '\n');

    for i = 2:1:length(gpsGroundDataRaw)
        currentLine = strsplit(gpsGroundDataRaw{i},' ');
        gpsGroundData(i-1,1) = str2num(currentLine{1});
        gpsGroundData(i-1,2) = str2num(currentLine{2});
        gpsGroundData(i-1,3) = str2num(currentLine{3});
        gpsGroundData(i-1,4) = str2num(currentLine{4});
    end

    for i = 2:1:length(gpsWaterDataRaw)
        currentLine = strsplit(gpsWaterDataRaw{i},' ');
        currentTimeA = strsplit(currentLine{1},':');
        currentTime = str2num(currentTimeA{1}) + str2num(currentTimeA{2})/60 + ...
            str2num(currentTimeA{3})/3600;
        gpsWaterData(i-1,1) = currentTime;
        gpsWaterData(i-1,2) = str2num(currentLine{2});
        gpsWaterData(i-1,3) = str2num(currentLine{3});
    end
    
    [~,indexes] = unique(gpsWaterData(:,1));
    gpsWaterData = gpsWaterData(indexes,:);

    for i = 2:1:length(echoSounderDataRaw)
        currentLine = strsplit(echoSounderDataRaw{i},' ');
        currentTimeA = strsplit(currentLine{1},':');
        currentTime = str2num(currentTimeA{1}) + str2num(currentTimeA{2})/60 + ...
            str2num(currentTimeA{3})/3600;
        echoSounderData(i-1,1) = currentTime;
        echoSounderData(i-1,2) = str2num(currentLine{2});
    end

end

