-- Last Restore PerDatabase information
SELECT 
	HOST_NAME() AS [HostName],
	BS.database_name AS SourceDatabaseName,
	bs.backup_start_date,
	destination_database_name,
	restore_date,
	RE.user_name AS [Name of performed the restore],
	restore_type = 	CASE 
		WHEN restore_type ='D' THEN  'Database'
		WHEN restore_type ='F' THEN  'File'
		WHEN restore_type ='G' THEN  'Filegroup'
		WHEN restore_type ='I' THEN  'Differential'
		WHEN restore_type ='L' THEN  'Log'
		WHEN restore_type ='V' THEN  'Verifyonly'
		END ,
		RECOVERY = Case
			WHEN recovery = 1 THEN 'RECOVERY' 
			ELSE 'NORECOVERY' END ,
compatibility_level =CASE
    WHEN bs.compatibility_level = 0 THEN 'SQL Server 2005 (9.x)'
    WHEN bs.compatibility_level = 100 THEN 'SQL Server 2008 (10.0.x)'
    WHEN bs.compatibility_level = 110 THEN '110 = SQL Server 2012 (11.x)'
    WHEN bs.compatibility_level = 120 THEN '120 = SQL Server 2014 (12.x)'
    WHEN bs.compatibility_level = 130 THEN '130 = SQL Server 2016 (13.x)'
    WHEN bs.compatibility_level = 140 THEN '140 = SQL Server 2017 (14.x)'
    WHEN bs.compatibility_level = 150 THEN '150 = SQL Server 2019 (15.x)'
    WHEN bs.compatibility_level = 160 THEN '160 = SQL Server 2022 (16.x)'
    ELSE 'Unknown'
END,
	bs.recovery_model ,
	BS.database_version,
	BS.backup_finish_date,
	f.physical_device_name
FROM msdb.dbo.restorehistory AS Re
INNER JOIN msdb.dbo.backupset AS BS 
	ON BS.backup_set_id = RE.backup_set_id
	inner join msdb.dbo.backupmediafamily as f 
		on f.media_set_id = bs.media_set_id;

GO
