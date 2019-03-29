-- select database
USE `amstestdata`;
-- insert Data

-- Antenna Data
INSERT IGNORE INTO `antenna` (`antennaID`, `antennaName`) 
VALUES 
(1, 'Blade'),
(2, 'Whip'),
(3, 'Modem');

-- SignalType Data
INSERT IGNORE INTO `signal type` (`signalID`,`signalName`, `signalLowerThreshold`,`signalHigherThreshold`)
Values 
(1,'RSSI', 6.0, 12.0),
(2,'RSCP', 15.0, 30.0),
(3,'RSRP', 10.0, 20.0);

-- NetworkData
INSERT IGNORE INTO `network` (`networkID`,`networkName`)
Values 
(1,'Vodafone'),
(2,'Telstra'),
(3,'External');

-- employeeData
INSERT IGNORE INTO `installer` (`employeeID`,`userName`)
Values 
(1,'Eevee'),
(2,'Pikachu'),
(3,'Celebi'),
(4,'Snorlax'),
(5,'Charizard'),
(6,'Mewtwo');

-- root workorder id
INSERT IGNORE INTO `job` (`workOrder`)
Values 
('WO-00251301'),
('WO-00104116'),
('WO-00105349'),
('WO-00110610'),
('WO-00110925'),
('WO-00248593');

-- Accuracy Emitted in meter because all identical and default is set
INSERT IGNORE INTO `meter` (`meterID`,`bluetoothName`, `gpsLong`, `gpsLat`, `serialNumber`, `modemType`, `firmwareVersion`)
Values 
(1,'REAPER', null, null, 'SDS-196B', 'EWM400', 'GAT-17R3'),
(2,'CORSSRAY', 152.752432376289, -27.6047716895375, 'SDS-043C', 'EWM400', 'GAT-17R3'),
(3,'DIXIE', 139.34259429587, -35.6776790181507, 'SDS-061C', 'EWM400', 'GAT-17R3'),
(4,'ASSAM', 152.984367638172, -27.4171041995673, 'SDS-008C', 'EWM1000', 'GAT-17R3'),
(5,'DAIBRAVE', 153.024695282944, -27.1806907654062, 'SDS-049C', 'EWM400', 'GAT-17R3'),
(6,'CARIVOU', 152.971914761231, -27.0792295037818, 'SDS-026C', 'EWM400', 'GAT-17R3');

-- test equipment (duplicates removed)
INSERT IGNORE INTO `test equipment` (`testerID`,`appVersion`, `deviceType`)
Values 
(1,'2.2.5','iPad6,12'),
(2,'2.2.5','iPad Air'),
(3,'2.2.5','iPad7,2');

-- Test Data
INSERT IGNORE INTO `test` (`testID`,`workOrder`, `meterID`, `employeeID`, `testerID`, `date`, `testType`,`antennaTestType`,`batteryLevel`,`bluetoothSignal`, `gen`)
Values 
(1,'WO-00251301', 1, 1, 1, '2019-2-19 13:14', 'Production', 'Blade and/or Whip', 3.92, '[-59.0, -52.0]', 3),
(2,'WO-00104116', 2, 2, 2, '2019-5-1 08:05', 'Production', 'Blade and/or Whip', 3.92, '[-76.0, -72.0, -66.0]', 3),
(3,'WO-00105349', 3, 3, 2, '2019-4-30 14:48', 'Production', 'Blade and/or Whip', 3.88, '[-83.0, -74.0, -79.0]', 3),
(4,'WO-00110610', 4, 4, 1, '2019-4-17 10:41', 'Production', 'Blade and/or Whip', 3.94, '[-91.0, -87.0, -81.0, -70.0, -86.0, -74.0, -76.0]', 3),
(5,'WO-00110925', 5, 5, 3, '2019-4-26 10:31', 'Production', 'Blade and/or Whip', 3.69, '[-76.0, -69.0, -69.0, -76.0, -73.0, -76.0]', 3),
(6,'WO-00248593', 6, 6, 2, '2019-2-19 08:42', 'Production', 'Blade and/or Whip', 3.88, '[-76.0, -85.0]', 3);

-- Result Statements
INSERT IGNORE INTO `results` (`resultID`,`antennaID`, `networkID`, `testID`, `result`, `simCard`, `modemStatus`, `rawArray`,`networkReturn`,`timeOut`)
Values 
-- First Test
(1, 1, 1, 1, 'Fail', '89314404000248157530', 'Registeration Denied', '[]', 'Unknown', 1),
(2, 2, 1, 1, 'Fail', '89314404000248157530', null, '[]', 'Unknown', 0),
(3, 1, 2, 1, 'Pass', '89610180002243817774', 'Registered, home network', '["58_12-6", "61_19-6", "61_30-6", "61_30-6", "62_30-6", "62_32-6", "62_32-6", "61_26-6", "61_26-6", "61_30-6", "61_29-6", "61_21-6", "62_27-6", "62_27-6", "61_31-6"]', 'Telstra Mobile', 0),
(4, 2, 2, 1, 'Fail', '89610180002243817774', null, '[]', 'Unknown', 0),
(5, 3, 3, 1, 'Fail', null, null, '[]', 'Unknown', 0),

-- Second Test
(6, 1, 1, 2, 'Pass', '89314404000248186935', 'Registered, Roaming', '["39_33-1", "39_33-1", "39_37-1", "99_99-0", "99_99-0", "99_99-0", "99_99-0", "99_99-0", "40_18-4", "40_18-4", "40_18-4", "39_29-4", "39_23-4", "39_23-4", "40_29-4"]', 'vodafone AU', 0),
(7, 2, 1, 2, 'Fail', '89314404000248186935', null, '[]', 'Unknown', 0),
(8, 1, 2, 2, 'Pass', '89610180002249048341', 'Registered, home network', '["41_33-2", "41_33-2", "41_33-2", "99_99-0", "99_99-0", "99_99-0", "28_6-4", "29_6-4", "29_6-4", "28_4-4", "28_7-4", "27_2-4", "28_6-4", "29_11-4", "29_11-4", "28_7-4"]', 'Telstra Mobile', 0),
(9, 2, 2, 2, 'Fail', '89610180002249048341', null, '[]', 'Unknown', 0),
(10, 3, 3, 2, 'Fail', null, null, '[]', 'Unknown', 0),

-- Third Test
(11, 1, 1, 3, 'Fail', '89314404000266650267', 'Not Registered, searching for network', '[]', 'unknown', 1),
(12, 2, 1, 3, 'Fail', '89314404000266650267', null, '[]', 'Unknown', 0),
(13, 1, 2, 3, 'Pass', '89610180002249046930', 'Registered, home network', '["28_31-2", "26_27-2", "26_27-2", "26_25-2", "26_25-2", "26_25-2", "25_27-2", "25_27-2", "28_31-2", "28_31-2", "28_31-2", "30_29-2", "30_29-2", "25_25-2", "25_25-2", "25_25-2", "26_29-2", "26_29-2", "26_29-2", "28_29-2", "28_29-2", "28_29-2", "28_29-2", "28_29-2", "29_31-2", "29_31-2", "28_31-2", "28_31-2", "28_31-2", "29_31-2"]', 'Telstra Mobile', 0),
(14, 2, 2, 3, 'Fail', '89610180002249046930', null, '[]', 'Unknown', 0),
(15, 3, 3, 3, 'Fail', null, null, '[]', 'Unknown', 0),

-- fourth Test
(16, 1, 1, 4, 'Fail', null, null, '[]', 'Unknown', 0),
(17, 2, 1, 4, 'Fail', null, null, '[]', 'Unknown', 0),
(18, 1, 2, 4, 'Fail', null, null, '[]', 'Unknown', 0),
(19, 2, 2, 4, 'Fail', null, null, '[]', 'Unknown', 0),
(20, 3, 3, 4, 'Pass', 89314404000266723023, 'Registered, Roaming', '["9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I", "9_99-I"]', 'vodafone AU', 0),

-- 5th Test
(21, 1, 1, 5, 'Pass', 89314404000248233075, 'Registered, Roaming', '["42_43-1", "42_43-1", "99_99-0", "99_99-0", "99_99-0", "99_99-0", "99_99-0", "41_17-4", "41_17-4", "43_22-4", "45_24-4", "45_26-4", "45_23-4", "45_24-4", "45_24-4"]', 'vodafone AU', 0),
(22, 2, 1, 5, 'Fail', 89314404000248233075, null, '[]', 'Unknown', 0),
(23, 1, 2, 5, 'Pass', 89610180002249047685, 'Registered, home network', '["41_37-2", "41_39-2", "99_99-0", "99_99-0", "99_99-0", "37_22-4", "40_21-4", "43_26-4", "39_23-4", "38_9-4", "38_9-4", "38_7-4", "42_26-4", "37_26-4", "40_26-4", "39_26-4"]', 'Telstra Mobile', 0),
(24, 2, 2, 5, 'Fail', 89610180002249047685, null, '[]', 'Unknown', 0),
(25, 3, 3, 5, 'Fail', null, null, '[]', 'Unknown', 0),
-- 6th Test
(26, 1, 1, 6, 'Fail', 89314404000281178914, 'Registeration Denied', '[]', 'Unknown', 1),
(27, 2, 1, 6, 'Fail', 89314404000281178914, null, '[]', 'Unknown', 0),
(28, 1, 2, 6, 'Pass', 89610180002249045296, 'Registered, home network', '["43_19-6", "43_19-6", "47_23-6", "47_23-6", "47_18-6", "47_18-6", "46_19-6", "46_19-6", "46_19-6", "44_12-6", "47_26-6", "47_23-6", "47_25-6", "47_28-6", "47_28-6"]', 'Telstra Mobile', 0),
(29, 2, 2, 6, 'Fail', 89610180002249045296, null, '[]', 'Unknown', 0),
(30, 3, 3, 6, 'Fail', null, null, '[]', 'Unknown', 0);

-- insert signal results
INSERT IGNORE INTO `signal results` (`signalresultsID`,`signalID`, `resultID`, `signalStrength`)
Values 
-- Test1-1 vodafone Blade
(1, 1, 1, 0.0),
(2, 2, 1, 0.0),
(3, 3, 1, 0.0),
-- Test1-2 vodafone whip
(4, 1, 2, 0.0),
(5, 2, 2, 0.0),
(6, 3, 2, 0.0),
-- Test1-3 Telstra Blade
(7, 1, 3, 0.0),
(8, 2, 3, 0.0),
(9, 3, 3, 61.1333333333333),
-- Test1-4 Telstra Whip
(10, 1, 4, 0.0),
(11, 2, 4, 0.0),
(12, 3, 4, 0.0),
-- Test1-5 External Modem
(13, 1, 5, 0.0),
(14, 2, 5, 0.0),
(15, 3, 5, 0.0),

-- ##########################################

-- Test2-1 vodafone Blade
(16, 1, 6, 0.0),
(17, 2, 6, 14.625),
(18, 3, 6, 23.0833333333333),
-- Test2-2 vodafone whip
(19, 1, 7, 0.0),
(20, 2, 7, 0.0),
(21, 3, 7, 0.0),
-- Test2-3 Telstra Blade
(22, 1, 8, 0.0),
(23, 2, 8, 20.5),
(24, 3, 8, 21.7692307692308),
-- Test2-4 Telstra Whip
(25, 1, 9, 0.0),
(26, 2, 9, 0.0),
(27, 3, 9, 0.0),
-- Test2-5 External Modem
(28, 1, 10, 0.0),
(29, 2, 10, 0.0),
(30, 3, 10, 0.0),

-- ##################################################################

-- Test3-1 vodafone Blade
(31, 1, 11, 0.0),
(32, 2, 11, 0.0),
(33, 3, 11, 0.0),
-- Test3-2 vodafone whip
(34, 1, 12, 0.0),
(35, 2, 12, 0.0),
(36, 3, 12, 0.0),
-- Test3-3 Telstra Blade
(37, 1, 13, 0.0),
(38, 2, 13, 27.2),
(39, 3, 13, 0.0),
-- Test3-4 Telstra Whip
(40, 1, 14, 0.0),
(41, 2, 14, 0.0),
(42, 3, 14, 0.0),
-- Test3-5 External Modem
(43, 1, 15, 0.0),
(44, 2, 15, 0.0),
(45, 3, 15, 0.0),

-- ##########################################

-- Test4-1 vodafone Blade
(46, 1, 16, 0.0),
(47, 2, 16, 0.0),
(48, 3, 16, 0.0),
-- Test4-2 vodafone whip
(49, 1, 17, 0.0),
(50, 2, 17, 0.0),
(51, 3, 17, 0.0),
-- Test4-3 Telstra Blade
(52, 1, 18, 0.0),
(53, 2, 18, 0.0),
(54, 3, 18, 0.0),
-- Test4-4 Telstra Whip
(55, 1, 19, 0.0),
(56, 2, 19, 0.0),
(57, 3, 19, 0.0),
-- Test4-5 External Modem
(58, 1, 20, 9.0),
(59, 2, 20, 0.0),
(60, 3, 20, 0.0),

-- ###################################################################
-- Test5-1 vodafone Blade
(61, 1, 21, 0.0),
(62, 2, 21, 12.0),
(63, 3, 21, 26.9230769230769),
-- Test5-2 vodafone whip
(64, 1, 22, 0.0),
(65, 2, 22, 0.0),
(66, 3, 22, 0.0),
-- Test5-3 Telstra Blade
(67, 1, 23, 0.0),
(68, 2, 23, 16.4),
(69, 3, 23, 30.7857142857143),
-- Test5-4 Telstra Whip
(70, 1, 24, 0.0),
(71, 2, 24, 0.0),
(72, 3, 24, 0.0),
-- Test5-5 External Modem
(73, 1, 25, 0.0),
(74, 2, 25, 0.0),
(75, 3, 25, 0.0),

-- ##########################################

-- Test6-1 vodafone Blade
(76, 1, 26, 0.0),
(77, 2, 26, 0.0),
(78, 3, 26, 0.0),
-- Test6-2 vodafone whip
(79, 1, 27, 0.0),
(80, 2, 27, 0.0),
(81, 3, 27, 0.0),
-- Test6-3 Telstra Blade
(82, 1, 28, 0.0),
(83, 2, 28, 0.0),
(84, 3, 28, 46.0666666666667),
-- Test6-4 Telstra Whip
(85, 1, 29, 0.0),
(86, 2, 29, 0.0),
(87, 3, 29, 0.0),
-- Test6-5 External Modem
(88, 1, 30, 0.0),
(89, 2, 30, 0.0),
(90, 3, 30, 0.0);


-- Testing statements
-- Values Exist
 SELECT * FROM `signal results`;
-- Foreign Key Tests
/*SELECT test.*, meter.bluetoothName
FROM test
INNER JOIN meter ON meter.meterID = test.meterID; */
