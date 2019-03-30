
-- Query number 9 Counting  
use amstestdata;

SELECT `meter`.meterID, `meter`.bluetoothName, `test`.testID,`test`.testerID, `test equipment`.testerID, `test equipment`.deviceType
FROM `meter`
LEFT JOIN test on `meter`.meterID = test.meterID
LEFT JOIN `test equipment` on `test`.testerID = `test equipment`.testerID
WHERE `meter`.gpsLat is null or `meter`.gpsLong is null
ORDER BY `test equipment`.deviceType