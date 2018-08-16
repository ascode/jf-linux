---新


SELECT * ,
        (CASE
    WHEN a.tjxcount is NULL THEN
    CONVERT(DECIMAL(18,2),isnull(a.QtyTime,0))
    WHEN isnull(a.tjxcount,0) = 0 THEN
    0
    ELSE CONVERT(DECIMAL(18,2),a.QtyTime/isnull(a.tjxcount,0))END)as SpendTime
FROM 
    (SELECT a.id,
        ISNULL(a.SchedulNO,
        '') ViewID,ISNULL(a.ShopOrder,'') DetailID,ISNULL(a.SchedulNum,0) LinkID,ISNULL(Stop.Station,'') ObjectID, Stop.ShopOrder,Stop.SchedulNO,Stop.SchedulNum, Stop.Station,Station.StationName, Stop.ProductLine,PLine.AreaName ProductLineName, Stop.num,
        CASE
        WHEN Stop.StopTime IS NULL THEN
        ''
        WHEN Stop.StopTime='' THEN
        ''
        ELSE CONVERT(VARCHAR(19),Stop.StopTime,120)
        END StopTime,
        CASE
        WHEN Stop.StartTime IS NULL THEN
        ''
        WHEN Stop.StartTime='' THEN
        ''
        ELSE CONVERT(VARCHAR(19),Stop.StartTime,120)
        END StartTime, Stop.Content, Stop.Operator,SUserTwo.Dir OperatorName, Stop.Device,Eqp.EquipmentName DeviceName, ISNULL(Stop.relationDevice,'') relationDevice, '' FContentCode,'' FContentName, --Stop.FContentCode,Stop.FContentName,
        CASE
        WHEN ISNULL(Stop.[Content],'')='' THEN
        ''
        ELSE Stop.updator
        END updator ,CASE
        WHEN ISNULL(Stop.[Content],'')='' THEN
        ''
        ELSE SUser.Dir
        END UpdatorName ,CASE
        WHEN Stop.StopTime IS NULL THEN
        ''
        WHEN Stop.StopTime='' THEN
        ''
        ELSE CONVERT(VARCHAR(19),Stop.StopTime,120)
        END OrderSort ,Stop.QtyTime ,
        (SELECT COUNT(ParentID)tjxcount
        FROM SfcGreSiltingStopDetailLog AS d
        WHERE d.ParentID=a.ID
        GROUP BY  ParentID) AS tjxcount
        FROM ProExpSchedulPlanDetail a
        LEFT JOIN ProGreProdSchedulOnline b
            ON a.id=b.SchedulPlanDetail
                AND b.ReqQty>0
        LEFT JOIN ProGreProdSchedulOnlineLog c
            ON a.ID=c.SchedulPlanDetail
                AND c.ReqQty>0
        LEFT JOIN 
            (SELECT a.ID,
        a.num,
        a.Content,
        a.SchedulNO,
        a.ShopOrder,
        a.ProductLine,
        a.SchedulNum,
        a.StopTime,
        a.StartTime,
        a.Station,
        a.Device,
        a.Updator,
        a.Operator,
         (CONVERT(DECIMAL(18,
        2),
        DATEDIFF(Second,
        a.StopTime,
        a.StartTime))/60) AS QtyTime,
         --c.StoppageGroupCode,
        c.StoppageGroupName,
        c.FContentCode,
        c.FContentName,
        c.StandardTime,
        c.TimeUnit,
         a.relationDevice
            FROM SfcGreSiltingStopLog a --LEFT
            JOIN SfcGreSiltingStopDetailLog b
                ON a.ID =b.ParentID --
            LEFT JOIN ( --SELECT a.Fcode AS StoppageGroupCode,
        a.Fname AS StoppageGroupName,
         -- b.ProductLine,
        b.StandardTime,
        b.TimeUnit --,
        '' FContentCode--,c.Fcode AS FContentCode --,'' FContentName--,c.Fname AS FContentName --
            FROM ProDatStoppageGroup a --
            LEFT JOIN ProDatProductLineStoppage b
                ON a.Fcode = b.StoppageGroup -- --INNER
            JOIN ProDatStoppage c
                ON b.StoppageCode = c.Fcode -- )c
                ON a.ProductLine = c.ProductLine
                    AND b.FContentCode = c.FContentCode
            WHERE a.SchedulNO is NOT null
                    AND a.SchedulNO <> ''
                    AND isnull(datediff(MINUTE,a.StopTime,a.StartTime),0) > 0 )Stop
                ON (b.SchedulNO = Stop.SchedulNo
                    AND b.SchedulNum = Stop.SchedulNum
                    AND b.ShopOrder = Stop.shopOrder
                    AND b.ProductLine = Stop.ProductLine)
                    OR (c.SchedulNO = Stop.SchedulNo
                    AND c.SchedulNum = Stop.SchedulNum
                    AND c.ShopOrder = Stop.shopOrder
                    AND c.ProductLine = Stop.ProductLine)
            LEFT JOIN dbo.FmdDatArea PLine
                ON PLine.AreaNo=Stop.ProductLine
            LEFT JOIN dbo.ProDatFlowPrdLineStation Station
                ON stop.ProductLine=Station.ProductLine
                    AND stop.Station=Station.StationCode
            LEFT JOIN dbo.FmdDatEquipment Eqp
                ON stop.Device=Eqp.EquipmentNo
            LEFT JOIN dbo.SysDatUser SUser
                ON SUser.FName=Stop.Updator
                    AND SUser.DataStatus='30'
            LEFT JOIN dbo.SysDatUser SUserTwo
                ON SUserTwo.FName=Stop.Operator
                    AND SUserTwo.DataStatus='30'
            WHERE LEN(stop.StopTime)>0
                    AND LEN(stop.StartTime)>0
                    AND LEN(Stop.ID)>0
                    AND DATEDIFF(Minute ,stop.StopTime ,Stop.StartTime)>0 ) AS a 