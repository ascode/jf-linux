use mes_reports;

/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/8/13 18:33:24                           */
/*==============================================================*/


drop table if exists TMP_RPT_MES_CAPACITY_LOAD_REPORT_DEMO;

drop table if exists TMP_RPT_MES_CONTROL_REPORT_DEMO;

drop table if exists TMP_RPT_MES_FMD_DATA_AREA;

drop table if exists TMP_RPT_MES_FMD_DATA_MATERIAL;

drop table if exists TMP_RPT_MES_FMD_DATA_PROCESS;

drop table if exists TMP_RPT_MES_FMD_DAT_PERFORMANCE_REPORT_DEMO;

drop table if exists TMP_RPT_MES_FMD_DAT_STATE_VIEW_DEMO;

drop table if exists TMP_RPT_MES_INV_DATA_GRAP_BATCH_TRACK_DEMO;

drop table if exists TMP_RPT_MES_MNF_DATA_DOWN_TIME_ANALYSIS_DEMO;

drop table if exists TMP_RPT_MES_MNF_DATA_STATE_ANALYSIS_DEMO;

drop table if exists TMP_RPT_MES_MNF_DATA_STATE_ANALYSIS_DEMO_01;

drop table if exists TMP_RPT_MES_MNF_EXP_ORDER_RECORD_DEMO;

drop table if exists TMP_RPT_MES_MNF_EXP_POLISH_STATIS_DEMO;

drop table if exists TMP_RPT_MES_MNF_EXP_PRODUCTION_MONITOR_DEMO;

drop table if exists TMP_RPT_MES_OEE_REPORT_DEMO;

drop table if exists TMP_RPT_MES_PRODUCT_PREVIEW_DEMO;

drop table if exists TMP_RPT_MES_QMS_DATA_DEFECT_ANALYSIS_DEMO;

drop table if exists TMP_RPT_MES_SFC_DATA_PROCESS_DEMO;


/*==============================================================*/
/* Table: TMP_RPT_MES_CAPACITY_LOAD_REPORT_DEMO                 */
/*==============================================================*/
create table TMP_RPT_MES_CAPACITY_LOAD_REPORT_DEMO
(
   ID                   int not null auto_increment,
   ProDate              date,
   UsableHours          float,
   ActualHours          float,
   primary key (ID)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_CONTROL_REPORT_DEMO                       */
/*==============================================================*/
create table TMP_RPT_MES_CONTROL_REPORT_DEMO
(
   No                   national varchar(50) not null,
   ExperiDate           date,
   SingleValue          decimal(18,6),
   AverageValue         decimal(18,6),
   MiniValue            decimal(18,6),
   `MaxValue`          decimal(18,6),
   `Range`                decimal(18,6),
   StandardDropValue    decimal(18,6),
   SRelativeValue       decimal(18,6),
   primary key (No)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_FMD_DATA_AREA                             */
/*==============================================================*/
create table TMP_RPT_MES_FMD_DATA_AREA
(
   AreaNo               national varchar(50) not null,
   AreaName             national varchar(100),
   AreaType             int,
   AreaCategory         int,
   ParentArea           national varchar(20),
   LocationNo           national varchar(20),
   WorkCenterNo         national varchar(20),
   WorkCalName          national varchar(20),
   DCSlnNo              national varchar(20),
   Remark               national varchar(500),
   DataStatus           int,
   AbandonStatus        bool,
   Creator              national varchar(50),
   CreateTime           datetime,
   Updator              national varchar(50),
   UpdateTime           datetime,
   Submitter            national varchar(50),
   SubmitTime           datetime,
   Approver             national varchar(50),
   ApproveTime          datetime,
   Abandoner            national varchar(50),
   AbandonTime          datetime,
   Factory              national varchar(50),
   ErpCode              national varchar(50),
   IsDelete             int
);

/*==============================================================*/
/* Table: TMP_RPT_MES_FMD_DATA_MATERIAL                         */
/*==============================================================*/
create table TMP_RPT_MES_FMD_DATA_MATERIAL
(
   MaterialNo           national varchar(100) not null,
   MaterialName         national varchar(255),
   MaterialSource       int,
   MaterialType         national varchar(50),
   IsMainProduct        bool,
   IsByProduct          bool,
   UnitNo               national varchar(20),
   GaugeDesc            national varchar(500),
   StockNo              national varchar(20),
   StockPlaceNo         national varchar(20),
   ManageByLot          bool,
   ManageBySn           bool,
   PicDocumentNo        national varchar(100),
   Remark               national varchar(50),
   DataStatus           int,
   AbandonStatus        bool,
   Creator              national varchar(50),
   CreateTime           datetime,
   Updator              national varchar(50),
   UpdateTime           datetime,
   Submitter            national varchar(50),
   SubmitTime           datetime,
   Approver             national varchar(50),
   ApproveTime          datetime,
   Abandoner            national varchar(50),
   AbandonTime          datetime,
   PackModel            national varchar(50),
   MaterialFactor       national varchar(50),
   NetQty               decimal,
   NetUnit              national varchar(50),
   Fmodel               national varchar(50),
   FISKFPeriod          bool,
   FKFPeriod            int,
   ItemStyle            national varchar(50),
   UpBazaarDay          int,
   Factory              national varchar(50),
   ErpMaterialType      national varchar(100),
   Slaking              int,
   MustSlaking          int,
   SlakingStock         national varchar(50),
   IsStockManager       int,
   shortMaterialName    national varchar(50),
   MaterialFactorQty    decimal(18,3),
   MaterialFactorUnit   national varchar(50),
   ItemClass            int,
   BLArea               national varchar(100),
   ItemControl          int,
   IsDelete             int,
   MaterialShortName    national varchar(500),
   IsCheckMes           bool,
   UnfixedQty           bool,
   IsFilterWater        bool
);

/*==============================================================*/
/* Table: TMP_RPT_MES_FMD_DATA_PROCESS                          */
/*==============================================================*/
create table TMP_RPT_MES_FMD_DATA_PROCESS
(
   ProcessNo            national varchar(20) not null,
   ProcessName          national varchar(100),
   ProcessType          int,
   ProcessFamily        int,
   ErpReportProcess     national varchar(100),
   ProcessImageSlnNo    national varchar(20),
   IsAllowMerge         bool,
   Remark               national varchar(500),
   DataStatus           int,
   AbandonStatus        bool,
   Creator              national varchar(50),
   CreateTime           datetime,
   Updator              national varchar(50),
   UpdateTime           datetime,
   Submitter            national varchar(50),
   SubmitTime           datetime,
   Approver             national varchar(50),
   ApproveTime          datetime,
   Abandoner            national varchar(50),
   AbandonTime          datetime,
   Factory              national varchar(50),
   ErpCode              national varchar(50),
   IsDelete             int,
   QCPassControl        bool
);

/*==============================================================*/
/* Table: TMP_RPT_MES_FMD_DAT_PERFORMANCE_REPORT_DEMO           */
/*==============================================================*/
create table TMP_RPT_MES_FMD_DAT_PERFORMANCE_REPORT_DEMO
(
   GUID                 national varchar(50) not null,
   WORK_AREA            national varchar(50),
   PASS_QTY             decimal(18,3),
   FAIL_QTY             decimal(18,3),
   REWORK_QTY           decimal(18,3),
   UNFINISHED_QTY       decimal(18,3),
   UNIT                 national varchar(50),
   TARGET_TIME          time,
   PRODUCT_TIME         time,
   STOP_TIME            time,
   CYCLE                int,
   PRODUCTION_RATE      decimal(18,3),
   TASK_RATE            decimal(18,3),
   TECHNIQUE_RATE       decimal(18,3),
   AREA_NAME            national varchar(100),
   AREA_TYPE            int,
   YEAR                 int,
   WEEK_COUNT           int,
   MONTH                int,
   SHIFT_DATE           date,
   SHIFT                int
);

/*==============================================================*/
/* Table: TMP_RPT_MES_FMD_DAT_STATE_VIEW_DEMO                   */
/*==============================================================*/
create table TMP_RPT_MES_FMD_DAT_STATE_VIEW_DEMO
(
   ID                   national varchar(50) not null,
   WORK_PLACE           national varchar(50),
   `GROUP`                national varchar(50),
   DURATION             int,
   DURATION_PERCENTAGE  decimal(18,3),
   PRODUCE              int,
   PRODUCE_PERCENTAGE   decimal(18,3),
   QUANTITY             int,
   QUANTITY_PERCENTAGE  decimal(18,3),
   PRD_COLUMN1          national varchar(50),
   PRD_COLUMN2          national varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_INV_DATA_GRAP_BATCH_TRACK_DEMO            */
/*==============================================================*/
create table TMP_RPT_MES_INV_DATA_GRAP_BATCH_TRACK_DEMO
(
   ID                   national varchar(50) not null,
   TheOrder             national varchar(50),
   WorkPlace            national varchar(50),
   Name                 national varchar(50),
   EnterTheBatch        national varchar(50),
   LoginDate            datetime,
   OutputBatches        national varchar(50),
   TheCancellationDate  datetime,
   BatchNumber          national varchar(50),
   InternalBatchNumber  national varchar(50),
   Material             national varchar(50),
   MaterialName         national varchar(50),
   BatchState           national varchar(50),
   MaterialType         national varchar(50),
   Personal             national varchar(50),
   StateChanges         datetime,
   Number               national varchar(50),
   ManufacturingTime    datetime,
   NumberRemaining      decimal(18,3),
   AvailabilityDate     datetime,
   Unit                 national varchar(50),
   MaturityDate         datetime,
   Prd_Column1          national varchar(50),
   Prd_Column2          national varchar(50),
   Prd_Column3          national varchar(50),
   Prd_Column4          national varchar(50),
   Prd_Column5          national varchar(50),
   ParentID             national varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_MNF_DATA_DOWN_TIME_ANALYSIS_DEMO          */
/*==============================================================*/
create table TMP_RPT_MES_MNF_DATA_DOWN_TIME_ANALYSIS_DEMO
(
   NO                   int not null,
   CATEGRAY             int,
   STATUS               int,
   STATETEXT            national varchar(50),
   STATETYPE            national varchar(50),
   STATETYPENAME        national varchar(100),
   DURATION             time,
   AMOUNT               int,
   primary key (NO)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_MNF_DATA_STATE_ANALYSIS_DEMO              */
/*==============================================================*/
create table TMP_RPT_MES_MNF_DATA_STATE_ANALYSIS_DEMO
(
   NO                   national varchar(50) not null,
   STATETEXT            national varchar(50),
   `GROUP`                national varchar(50),
   `2015/1/17`          time,
   `2015/1/16`          time,
   `2015/1/15`          time,
   `2015/1/14`          time,
   `2015/1/13`          time,
   `2015/1/12`          time,
   `2015/1/11`          time,
   `2015/1/10`          time,
   `2015/1/9`           time,
   `2015/1/8`           time,
   `2015/1/7`           time,
   `2015/1/6`           time,
   `2015/1/5`           time,
   primary key (NO)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_MNF_DATA_STATE_ANALYSIS_DEMO_01           */
/*==============================================================*/
create table TMP_RPT_MES_MNF_DATA_STATE_ANALYSIS_DEMO_01
(
   NO                   national varchar(50) not null,
   STATETEXT            national varchar(50),
   `GROUP`                national varchar(50),
   ACTION_DATE          date,
   ACTION_TIME          time,
   ACTION_PERIOD        int
);

/*==============================================================*/
/* Table: TMP_RPT_MES_MNF_EXP_ORDER_RECORD_DEMO                 */
/*==============================================================*/
create table TMP_RPT_MES_MNF_EXP_ORDER_RECORD_DEMO
(
   guid                 national varchar(50) not null,
   ShiftDate            datetime,
   Shift                int,
   OrderNo              national varchar(50),
   Process              national varchar(50),
   Product              national varchar(50),
   TargetTime           time,
   ProductTime          time,
   StopTime             time,
   WorkArea             national varchar(50),
   PassQty              decimal(18,3),
   FailQty              decimal(18,3),
   Unit                 national varchar(50),
   ReworkQty            decimal(18,3),
   UnfinishedQty        decimal(18,3)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_MNF_EXP_POLISH_STATIS_DEMO                */
/*==============================================================*/
create table TMP_RPT_MES_MNF_EXP_POLISH_STATIS_DEMO
(
   Guid                 national varchar(50) not null,
   WorkStation          national varchar(50),
   OrderNo              national varchar(50),
   Process              national varchar(50),
   Product              national varchar(50),
   Reason               national varchar(50),
   ProducePolishReason  national varchar(50),
   PolishQty            decimal(18,3),
   Unit                 national varchar(50),
   PolishRate           decimal(18,3)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_MNF_EXP_PRODUCTION_MONITOR_DEMO           */
/*==============================================================*/
create table TMP_RPT_MES_MNF_EXP_PRODUCTION_MONITOR_DEMO
(
   Guid                 national varchar(50) not null,
   DGroup               national varchar(50),
   WorkStation          national varchar(50),
   Time1                time,
   Time2                time,
   Time3                time,
   Time4                time
);

/*==============================================================*/
/* Table: TMP_RPT_MES_OEE_REPORT_DEMO                           */
/*==============================================================*/
create table TMP_RPT_MES_OEE_REPORT_DEMO
(
   Id                   int not null,
   WorkPlace            national varchar(50),
   ShortName            national varchar(50),
   GroupName            national varchar(50),
   PlanTime             national varchar(50),
   ProductTime          national varchar(50),
   FactTime             national varchar(50),
   PassTime             national varchar(50),
   OEE                  decimal(18,2),
   Usability            decimal(18,2),
   Efficiency           decimal(18,2),
   Quality              decimal(18,2),
   primary key (Id)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_PRODUCT_PREVIEW_DEMO                      */
/*==============================================================*/
create table TMP_RPT_MES_PRODUCT_PREVIEW_DEMO
(
   MATERIALS            national varchar(50),
   MATERIALS_NAME       national varchar(50),
   MATERIALS_TYPE       national varchar(50),
   BATCH_STATUS         national varchar(50),
   REMAINING_QUANTITY   decimal(18,4),
   UNIT                 national varchar(50),
   MATERIAL_BUFFER      national varchar(50),
   NAME                 national varchar(50),
   COST_CENTER          national varchar(50),
   COMPANY              national varchar(50),
   STORAGE_LOCATION     national varchar(50),
   ID                   int not null auto_increment,
   key one_pk (ID)
);

/*==============================================================*/
/* Table: TMP_RPT_MES_QMS_DATA_DEFECT_ANALYSIS_DEMO             */
/*==============================================================*/
create table TMP_RPT_MES_QMS_DATA_DEFECT_ANALYSIS_DEMO
(
   ID                   national varchar(50) not null,
   FaultName            national varchar(50),
   Prd_Column1          int,
   Prd_Column2          int,
   Prd_Column3          int,
   Prd_Column4          int,
   Prd_Column5          int,
   Prd_Column6          int,
   AllResultsNum        int
);

/*==============================================================*/
/* Table: TMP_RPT_MES_SFC_DATA_PROCESS_DEMO                     */
/*==============================================================*/
create table TMP_RPT_MES_SFC_DATA_PROCESS_DEMO
(
   guid                 national varchar(50) not null,
   Status               national varchar(50),
   StartUpStatus        datetime,
   OrderNo              national varchar(50),
   Process              national varchar(50),
   Product              national varchar(50),
   Prior                int,
   OrderStartTime       datetime,
   OrderEndTime         datetime,
   ProduceStartTime     datetime,
   ProduceEndTime       datetime,
   StopStartTime        datetime,
   StopEndTime          datetime
);
