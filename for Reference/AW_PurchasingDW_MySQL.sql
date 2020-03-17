--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      AW_PurchasingDW.DM1
--
-- Date Created : Tuesday, February 25, 2020 23:48:39
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: DimCountry 
--

CREATE TABLE DimCountry(
    CountryCode_SK       CHAR(10)        NOT NULL,
    SOR_ID               VARCHAR(50)     NOT NULL,
    CountryRegionName    VARCHAR(100)    NOT NULL,
    JobID                VARCHAR(50)     NOT NULL,
    CreatedDate          DATETIME        DEFAULT (curdate()) NOT NULL,
    ModifiedDate         DATETIME        DEFAULT (curdate()),
    PRIMARY KEY (CountryCode_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimDate 
--

CREATE TABLE DimDate(
    DateKey_SK               BIGINT         NOT NULL,
    SOR_ID                   VARCHAR(50)    NOT NULL,
    FullDate_AlternateKey    DATETIME       NOT NULL,
    Day                      TINYINT        NOT NULL,
    Week                     INT            NOT NULL,
    Month                    INT            NOT NULL,
    CalendarQuarter          VARCHAR(10)    NOT NULL,
    CalendarYear             INT            NOT NULL,
    JobID                    VARCHAR(50)    NOT NULL,
    CreatedDate              DATETIME       DEFAULT (curdate()) NOT NULL,
    ModifiedDate             DATETIME       DEFAULT (curdate()),
    PRIMARY KEY (DateKey_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeID_SK        INT                      NOT NULL,
    SOR_ID               VARCHAR(50),
    NationalIDNumber     NATIONAL VARCHAR(15)     NOT NULL,
    PersonType           CHAR(10)                 NOT NULL,
    Title                CHAR(10),
    FirstName            VARCHAR(100)             NOT NULL,
    MiddleName           VARCHAR(50),
    LastName             VARCHAR(100)             NOT NULL,
    Suffix               VARCHAR(10),
    JobTitle             NATIONAL VARCHAR(50)     NOT NULL,
    PhoneNumber          VARCHAR(25),
    PhoneNumberType      VARCHAR(50),
    EmailAddress         VARCHAR(50),
    EmailPromotion       INT                      NOT NULL,
    AddressLine1         VARCHAR(60)              NOT NULL,
    AddressLine2         VARCHAR(60),
    LoginID              NATIONAL VARCHAR(256)    NOT NULL,
    OrganizationNode     CHAR(10),
    OrganizationLevel    SMALLINT,
    MaritalStatus        NATIONAL CHAR(1)         NOT NULL
                         CHECK ((upper(MaritalStatus)='S' OR upper(MaritalStatus)='M')),
    Gender               NATIONAL CHAR(1)         NOT NULL
                         CHECK ((upper(Gender)='F' OR upper(Gender)='M')),
    SalariedFlag         BIT(1)                   DEFAULT ((1)) NOT NULL,
    VacationHours        SMALLINT                 DEFAULT (0) NOT NULL
                         CHECK ((VacationHours>=(-40) AND VacationHours<=(240))),
    SickLeaveHours       SMALLINT                 DEFAULT (0) NOT NULL
                         CHECK ((SickLeaveHours>=(0) AND SickLeaveHours<=(120))),
    CurrentFlag          BIT(1)                   DEFAULT ((1)) NOT NULL,
    BirthDate            BIGINT                   NOT NULL,
    HireDate             BIGINT                   NOT NULL,
    JobID                VARCHAR(50)              NOT NULL,
    CreatedDate          DATETIME                 DEFAULT (curdate()) NOT NULL,
    ModifiedDate         DATETIME                 DEFAULT (curdate()),
    GeographyKey_SK      INT                      NOT NULL,
    PRIMARY KEY (EmployeeID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimGeography 
--

CREATE TABLE DimGeography(
    GeographyKey_SK      INT                     NOT NULL,
    SOR_ID               VARCHAR(50)             NOT NULL,
    StateProvinceID      INT                     NOT NULL,
    StateProvinceCode    NATIONAL CHAR(3)        NOT NULL,
    StateProvinceName    NATIONAL VARCHAR(50)    NOT NULL,
    City                 NATIONAL VARCHAR(50)    NOT NULL,
    PostalCode           VARCHAR(10)             NOT NULL,
    JobID                VARCHAR(50)             NOT NULL,
    CreatedDate          DATETIME                DEFAULT (curdate()) NOT NULL,
    ModifiedDate         DATETIME                DEFAULT (curdate()),
    CountryCode_SK       CHAR(10)                NOT NULL,
    PRIMARY KEY (GeographyKey_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimLocation 
--

CREATE TABLE DimLocation(
    LocationID_SK    SMALLINT                NOT NULL,
    SOR_ID           VARCHAR(50)             NOT NULL,
    Name             NATIONAL VARCHAR(50)    NOT NULL,
    CostRate         DECIMAL(10, 2)          DEFAULT (0.00) NOT NULL
                     CHECK ((CostRate>=(0.00))),
    Availability     DECIMAL(8, 2)           DEFAULT (0.00) NOT NULL
                     CHECK ((Availability>=(0.00))),
    JobID            VARCHAR(50)             NOT NULL,
    CreatedDate      DATETIME                DEFAULT (curdate()) NOT NULL,
    ModifiedDate     DATETIME                DEFAULT (curdate()),
    PRIMARY KEY (LocationID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProduct 
--

CREATE TABLE DimProduct(
    ProductID_SK             INT                     NOT NULL,
    SOR_ID                   VARCHAR(50)             NOT NULL,
    SubcategoryName          NATIONAL VARCHAR(50),
    CategoryName             NATIONAL VARCHAR(50),
    ModelName                NATIONAL VARCHAR(50),
    ProductName              NATIONAL VARCHAR(50)    NOT NULL,
    ProductNumber            NATIONAL VARCHAR(25)    NOT NULL,
    MakeFlag                 BIT(1)                  DEFAULT ((1)) NOT NULL,
    FinishedGoodsFlag        BIT(1)                  DEFAULT ((1)) NOT NULL,
    Color                    NATIONAL VARCHAR(15),
    SafetyStockLevel         SMALLINT                NOT NULL
                             CHECK ((SafetyStockLevel>(0))),
    ReorderPoint             SMALLINT                NOT NULL
                             CHECK ((ReorderPoint>(0))),
    StandardCost             DECIMAL(19, 4)          NOT NULL
                             CHECK ((StandardCost>=(0.00))),
    ListPrice                DECIMAL(19, 4)          NOT NULL
                             CHECK ((ListPrice>=(0.00))),
    UnitPrice                DECIMAL(19, 4)          NOT NULL,
    Size                     NATIONAL VARCHAR(5),
    SizeUnitMeasureCode      NATIONAL CHAR(3),
    WeightUnitMeasureCode    NATIONAL CHAR(3),
    Weight                   DECIMAL(8, 2)           
                             CHECK ((Weight>(0.00))),
    DaysToManufacture        INT                     NOT NULL
                             CHECK ((DaysToManufacture>=(0))),
    ProductLine              NATIONAL CHAR(2)        
                             CHECK ((upper(ProductLine)='R' OR upper(ProductLine)='M' OR upper(ProductLine)='T' OR upper(ProductLine)='S' OR ProductLine IS NULL)),
    Class                    NATIONAL CHAR(2)        
                             CHECK ((upper(Class)='H' OR upper(Class)='M' OR upper(Class)='L' OR Class IS NULL)),
    Style                    NATIONAL CHAR(2)        
                             CHECK ((upper(Style)='U' OR upper(Style)='M' OR upper(Style)='W' OR Style IS NULL)),
    SellStartDate            BIGINT,
    SellEndDate              BIGINT,
    DiscontinuedDate         BIGINT,
    JobID                    VARCHAR(50)             NOT NULL,
    CreatedDate              DATETIME                DEFAULT (curdate()) NOT NULL,
    ModifiedDate             DATETIME                DEFAULT (curdate()),
    PRIMARY KEY (ProductID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductListPrice_SCD 
--

CREATE TABLE DimProductListPrice_SCD(
    DimensionTable_SK       INT               NOT NULL,
    Dimension_Durable_SK    INT               NULL,
    SOR_ID                  VARCHAR(50)       NOT NULL,
    ListPrice               DECIMAL(19, 4)    NOT NULL,
    EffectiveDate           DATETIME          NOT NULL,
    IneffectiveDate         DATETIME,
    Status                  VARCHAR(20)       NOT NULL,
    Version                 FLOAT(8, 0)       NOT NULL,
    JobID                   VARCHAR(50)       NOT NULL,
    CreatedDate             DATETIME          DEFAULT (curdate()) NOT NULL,
    ModifiedDate            DATETIME          DEFAULT (curdate()),
    Dimension_NK            INT               NOT NULL,
    PRIMARY KEY (DimensionTable_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductStandardCost_SCD 
--

CREATE TABLE DimProductStandardCost_SCD(
    DimensionTable_SK       INT               NOT NULL,
    Dimension_Durable_SK    INT               NOT NULL,
    SOR_ID                  VARCHAR(50)       NOT NULL,
    StandardCost            DECIMAL(19, 4)    NOT NULL,
    EffectiveDate           DATETIME          NOT NULL,
    IneffectiveDate         DATETIME,
    Status                  VARCHAR(20)       NOT NULL,
    Version                 FLOAT(8, 0)       NOT NULL,
    JobID                   VARCHAR(50)       NOT NULL,
    CreatedDate             DATETIME          DEFAULT (curdate()) NOT NULL,
    ModifiedDate            DATETIME          DEFAULT (curdate()),
    Dimension_NK            INT               NOT NULL,
    PRIMARY KEY (DimensionTable_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductVendor 
--

CREATE TABLE DimProductVendor(
    ProductID_SK       INT                 NOT NULL,
    VendorID_SK        INT                 NOT NULL,
    SOR_ID             VARCHAR(50)         NOT NULL,
    AverageLeadTime    INT                 NOT NULL
                       CHECK ((AverageLeadTime>=(1))),
    StandardPrice      DECIMAL(19, 4)      NOT NULL
                       CHECK ((StandardPrice>(0.00))),
    LastReceiptCost    DECIMAL(19, 4)      
                       CHECK ((LastReceiptCost>(0.00))),
    LastReceiptDate    BIGINT,
    MinOrderQty        INT                 NOT NULL
                       CHECK ((MinOrderQty>=(1))),
    MaxOrderQty        INT                 NOT NULL
                       CHECK ((MaxOrderQty>=(1))),
    OnOrderQty         INT                 
                       CHECK ((OnOrderQty>=(0))),
    UnitMeasureCode    NATIONAL CHAR(3)    NOT NULL,
    JobID              VARCHAR(50)         NOT NULL,
    CreatedDate        DATETIME            DEFAULT (curdate()) NOT NULL,
    ModifiedDate       DATETIME            DEFAULT (curdate()),
    PRIMARY KEY (ProductID_SK, VendorID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimScrapReason 
--

CREATE TABLE DimScrapReason(
    ScrapID_SK      INT            NOT NULL,
    SOR_ID          VARCHAR(50)    NOT NULL,
    ScrapReason     VARCHAR(50)    NOT NULL,
    JobID           VARCHAR(50)    NOT NULL,
    CreatedDate     DATETIME       DEFAULT (curdate()) NOT NULL,
    ModifiedDate    DATETIME       DEFAULT (curdate()),
    PRIMARY KEY (ScrapID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimShipMethod 
--

CREATE TABLE DimShipMethod(
    ShipMethodID_SK    INT                     NOT NULL,
    SOR_ID             VARCHAR(50)             NOT NULL,
    Name               NATIONAL VARCHAR(50)    NOT NULL,
    ShipBase           DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                       CHECK ((ShipBase>(0.00))),
    ShipRate           DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                       CHECK ((ShipRate>(0.00))),
    JobID              VARCHAR(50)             NOT NULL,
    CreatedDate        DATETIME                DEFAULT (curdate()) NOT NULL,
    ModifiedDate       DATETIME                DEFAULT (curdate()),
    PRIMARY KEY (ShipMethodID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimVendor 
--

CREATE TABLE DimVendor(
    VendorID_SK              INT                     NOT NULL,
    SOR_ID                   VARCHAR(50)             NOT NULL,
    VendorName               NATIONAL VARCHAR(50)    NOT NULL,
    AccountNumber            NATIONAL VARCHAR(15)    NOT NULL,
    CreditRating             TINYINT                 NOT NULL
                             CHECK ((CreditRating>=(1) AND CreditRating<=(5))),
    PreferredVendorStatus    BIT(1)                  DEFAULT ((1)) NOT NULL,
    ActiveFlag               BIT(1)                  DEFAULT ((1)) NOT NULL,
    AddressType              VARCHAR(50)             NOT NULL,
    AddressLine1             VARCHAR(60)             NOT NULL,
    AddressLine2             VARCHAR(60),
    JobID                    VARCHAR(50)             NOT NULL,
    CreatedDate              DATETIME                DEFAULT (curdate()) NOT NULL,
    ModifiedDate             DATETIME                DEFAULT (curdate()),
    GeographyKey_SK          INT                     NOT NULL,
    PRIMARY KEY (VendorID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimVendorContacts 
--

CREATE TABLE DimVendorContacts(
    VendorContactID_SK    INT            NOT NULL,
    SOR_ID                VARCHAR(50)    NOT NULL,
    ContactType           VARCHAR(50)    NOT NULL,
    Title                 VARCHAR(8),
    FirstName             VARCHAR(50)    NOT NULL,
    MiddleName            VARCHAR(50),
    LastName              VARCHAR(50)    NOT NULL,
    Suffix                VARCHAR(10),
    PhoneNumber           VARCHAR(25),
    PhoneNumberType       VARCHAR(50),
    EmailAddress          VARCHAR(50),
    EmailPromotion        INT            NOT NULL,
    JobID                 VARCHAR(50)    NOT NULL,
    CreatedDate           DATETIME       DEFAULT (curdate()) NOT NULL,
    ModifiedDate          DATETIME       DEFAULT (curdate()),
    VendorID_SK           INT            NOT NULL,
    PRIMARY KEY (VendorContactID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactProductInventory 
--

CREATE TABLE FactProductInventory(
    ProductID_SK     INT                     NOT NULL,
    LocationID_SK    SMALLINT                NOT NULL,
    Shelf            NATIONAL VARCHAR(10)    NOT NULL
                     CHECK ((Shelf like 'A-Za-z' OR Shelf='N/A')),
    Bin              TINYINT                 NOT NULL
                     CHECK ((Bin>=(0) AND Bin<=(100))),
    Quantity         SMALLINT                DEFAULT (0) NOT NULL,
    JobID            VARCHAR(50)             NOT NULL,
    CreatedDate      DATETIME                DEFAULT (curdate()) NOT NULL,
    ModifiedDate     DATETIME                DEFAULT (curdate()),
    PRIMARY KEY (ProductID_SK, LocationID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactPurchaseOrder 
--

CREATE TABLE FactPurchaseOrder(
    PurchaseOrderID_SK          INT               NOT NULL,
    PurchaseOrderDetailID_SK    INT               NOT NULL,
    RevisionNumber              TINYINT           DEFAULT (0) NOT NULL,
    OrderQty                    INT               NOT NULL,
    ReceivedQty                 DECIMAL(8, 2)     NOT NULL,
    StockedQty                  DECIMAL(8, 2)     NOT NULL,
    Status                      TINYINT           DEFAULT (1) NOT NULL
                                CHECK ((Status>=(1) AND Status<=(4))),
    SubTotal                    DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                                CHECK ((SubTotal>=(0.00))),
    TaxAmt                      DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                                CHECK ((TaxAmt>=(0.00))),
    Freight                     DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                                CHECK ((Freight>=(0.00))),
    TotalDue                    DECIMAL(19, 4)    NOT NULL,
    DueDate                     BIGINT            NOT NULL,
    OrderDate                   BIGINT            NOT NULL,
    ShipDate                    BIGINT            NOT NULL,
    JobID                       VARCHAR(50)       NOT NULL,
    CreatedDate                 DATETIME          DEFAULT (curdate()) NOT NULL,
    ModifiedDate                DATETIME          DEFAULT (curdate()) NOT NULL,
    ProductID_SK                INT               NOT NULL,
    ShipMethodID_SK             INT               NOT NULL,
    EmployeeID_SK               INT               NOT NULL,
    VendorID_SK                 INT               NOT NULL,
    PRIMARY KEY (PurchaseOrderID_SK, PurchaseOrderDetailID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactPurchaseOrder_Rejects 
--

CREATE TABLE FactPurchaseOrder_Rejects(
    PurchaseOrderID_SK          INT               NOT NULL,
    PurchaseOrderDetailID_SK    INT               NOT NULL,
    RevisionNumber              TINYINT           DEFAULT (0) NOT NULL,
    OrderQty                    INT               NOT NULL,
    RejectedQty                 DECIMAL(8, 2)     NOT NULL,
    Status                      TINYINT           DEFAULT (1) NOT NULL
                                CHECK ((Status>=(1) AND Status<=(4))),
    SubTotal                    DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                                CHECK ((SubTotal>=(0.00))),
    TaxAmt                      DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                                CHECK ((TaxAmt>=(0.00))),
    Freight                     DECIMAL(19, 4)    DEFAULT (0.00) NOT NULL
                                CHECK ((Freight>=(0.00))),
    TotalDue                    DECIMAL(19, 4)    NOT NULL,
    DueDate                     BIGINT            NOT NULL,
    OrderDate                   BIGINT            NOT NULL,
    ShipDate                    BIGINT            NOT NULL,
    JobID                       VARCHAR(50)       NOT NULL,
    CreatedDate                 DATETIME          DEFAULT (curdate()) NOT NULL,
    ModifiedDate                DATETIME          DEFAULT (curdate()),
    ProductID_SK                INT,
    ShipMethodID_SK             INT,
    EmployeeID_SK               INT,
    VendorID_SK                 INT,
    PRIMARY KEY (PurchaseOrderID_SK, PurchaseOrderDetailID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactSalesTerritory 
--

CREATE TABLE FactSalesTerritory(
    SalesTerritoryID_SK    INT                     NOT NULL,
    SalesTerritoryName     NATIONAL VARCHAR(50)    NOT NULL,
    `Group`                  NATIONAL VARCHAR(50)    NOT NULL,
    SalesYTD               DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                           CHECK ((SalesYTD>=(0.00))),
    SalesLastYear          DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                           CHECK ((SalesLastYear>=(0.00))),
    CostYTD                DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                           CHECK ((CostYTD>=(0.00))),
    CostLastYear           DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL
                           CHECK ((CostLastYear>=(0.00))),
    JobID                  VARCHAR(50)             NOT NULL,
    CreatedDate            DATETIME                DEFAULT curdate() NOT NULL,
    ModifiedDate           DATETIME                DEFAULT (curdate()),
    CountryCode_SK         CHAR(10)                NOT NULL,
    PRIMARY KEY (SalesTerritoryID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactWorkOrder 
--

CREATE TABLE FactWorkOrder(
    WorkOrderID     INT            NOT NULL,
    OrderQty        INT            NOT NULL,
    StockedQty      INT            NOT NULL,
    ScrapedQty      INT            NOT NULL,
    StartDate       BIGINT         NOT NULL,
    EndDate         BIGINT         NOT NULL,
    DueDate         BIGINT         NOT NULL,
    JobID           VARCHAR(50)    NOT NULL,
    CreatedDate     DATETIME       DEFAULT (curdate()) NOT NULL,
    ModifiedDate    DATETIME       DEFAULT (curdate()),
    ProductID_SK    INT            NOT NULL,
    ScrapID_SK      INT,
    PRIMARY KEY (WorkOrderID)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactWorkOrder_Rejects 
--

CREATE TABLE FactWorkOrder_Rejects(
    WorkOrderID     INT            NOT NULL,
    OrderQty        INT            NOT NULL,
    StockedQty      INT            NOT NULL,
    ScrapedQty      INT            NOT NULL,
    StartDate       BIGINT         NOT NULL,
    EndDate         BIGINT         NOT NULL,
    DueDate         BIGINT         NOT NULL,
    JobID           VARCHAR(50)    NOT NULL,
    CreatedDate     DATETIME       DEFAULT (curdate()) NOT NULL,
    ModifiedDate    DATETIME       DEFAULT (curdate()),
    ProductID_SK    INT,
    ScrapID_SK      INT,
    PRIMARY KEY (WorkOrderID)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactWorkOrderRouting 
--

CREATE TABLE FactWorkOrderRouting(
    WorkOrderRoutingID_SK    INT               NOT NULL,
    OperationSequence        INT               NOT NULL,
    ScheduledStartDate       BIGINT            NOT NULL,
    ScheduledEndDate         BIGINT            NOT NULL,
    ActualStartDate          BIGINT            NOT NULL,
    ActualEndDate            BIGINT            NOT NULL,
    ActualResourceHrs        DECIMAL(10, 4)    NOT NULL,
    PlannedCost              DECIMAL(10, 4)    NOT NULL,
    ActualCost               DECIMAL(10, 4)    NOT NULL,
    JobID                    VARCHAR(50)       NOT NULL,
    CreatedDate              DATETIME          DEFAULT (curdate()) NOT NULL,
    ModifiedDate             DATETIME          DEFAULT (curdate()),
    LocationID_SK            SMALLINT          NOT NULL,
    ProductID_SK             INT               NOT NULL,
    WorkOrderID              INT               NOT NULL,
    PRIMARY KEY (WorkOrderRoutingID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactWorkOrderRouting_Rejects 
--

CREATE TABLE FactWorkOrderRouting_Rejects(
    WorkOrderRoutingID_SK    INT               NOT NULL,
    OperationSequence        INT               NOT NULL,
    ScheduledStartDate       BIGINT            NOT NULL,
    ScheduledEndDate         BIGINT            NOT NULL,
    ActualStartDate          BIGINT            NOT NULL,
    ActualEndDate            BIGINT            NOT NULL,
    ActualResourceHrs        DECIMAL(10, 4)    NOT NULL,
    PlannedCost              DECIMAL(10, 4)    NOT NULL,
    ActualCost               DECIMAL(10, 4)    NOT NULL,
    JobID                    VARCHAR(50)       NOT NULL,
    CreatedDate              DATETIME          DEFAULT (curdate()) NOT NULL,
    ModifiedDate             DATETIME          DEFAULT (curdate()),
    LocationID_SK            SMALLINT,
    ProductID_SK             INT,
    WorkOrderID              INT,
    PRIMARY KEY (WorkOrderRoutingID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployee 
--

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimDate66 
    FOREIGN KEY (BirthDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimGeography102 
    FOREIGN KEY (GeographyKey_SK)
    REFERENCES DimGeography(GeographyKey_SK)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimDate103 
    FOREIGN KEY (HireDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimGeography 
--

ALTER TABLE DimGeography ADD CONSTRAINT RefDimCountry83 
    FOREIGN KEY (CountryCode_SK)
    REFERENCES DimCountry(CountryCode_SK)
;


-- 
-- TABLE: DimProduct 
--

ALTER TABLE DimProduct ADD CONSTRAINT RefDimDate67 
    FOREIGN KEY (SellStartDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimDate112 
    FOREIGN KEY (SellEndDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimDate113 
    FOREIGN KEY (DiscontinuedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductListPrice_SCD 
--

ALTER TABLE DimProductListPrice_SCD ADD CONSTRAINT RefDimProduct129 
    FOREIGN KEY (Dimension_NK)
    REFERENCES DimProduct(ProductID_SK)
;


-- 
-- TABLE: DimProductStandardCost_SCD 
--

ALTER TABLE DimProductStandardCost_SCD ADD CONSTRAINT RefDimProduct131 
    FOREIGN KEY (Dimension_NK)
    REFERENCES DimProduct(ProductID_SK)
;


-- 
-- TABLE: DimProductVendor 
--

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimProduct75 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimVendor76 
    FOREIGN KEY (VendorID_SK)
    REFERENCES DimVendor(VendorID_SK)
;

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimDate110 
    FOREIGN KEY (LastReceiptDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimVendor 
--

ALTER TABLE DimVendor ADD CONSTRAINT RefDimGeography61 
    FOREIGN KEY (GeographyKey_SK)
    REFERENCES DimGeography(GeographyKey_SK)
;


-- 
-- TABLE: DimVendorContacts 
--

ALTER TABLE DimVendorContacts ADD CONSTRAINT RefDimVendor81 
    FOREIGN KEY (VendorID_SK)
    REFERENCES DimVendor(VendorID_SK)
;


-- 
-- TABLE: FactProductInventory 
--

ALTER TABLE FactProductInventory ADD CONSTRAINT RefDimProduct58 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactProductInventory ADD CONSTRAINT RefDimLocation79 
    FOREIGN KEY (LocationID_SK)
    REFERENCES DimLocation(LocationID_SK)
;


-- 
-- TABLE: FactPurchaseOrder 
--

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimProduct53 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimEmployee59 
    FOREIGN KEY (EmployeeID_SK)
    REFERENCES DimEmployee(EmployeeID_SK)
;

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimDate68 
    FOREIGN KEY (DueDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimShipMethod78 
    FOREIGN KEY (ShipMethodID_SK)
    REFERENCES DimShipMethod(ShipMethodID_SK)
;

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimVendor100 
    FOREIGN KEY (VendorID_SK)
    REFERENCES DimVendor(VendorID_SK)
;

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimDate104 
    FOREIGN KEY (OrderDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrder ADD CONSTRAINT RefDimDate106 
    FOREIGN KEY (ShipDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactPurchaseOrder_Rejects 
--

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimShipMethod94 
    FOREIGN KEY (ShipMethodID_SK)
    REFERENCES DimShipMethod(ShipMethodID_SK)
;

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimEmployee95 
    FOREIGN KEY (EmployeeID_SK)
    REFERENCES DimEmployee(EmployeeID_SK)
;

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimDate96 
    FOREIGN KEY (DueDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimProduct98 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimVendor99 
    FOREIGN KEY (VendorID_SK)
    REFERENCES DimVendor(VendorID_SK)
;

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimDate107 
    FOREIGN KEY (OrderDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrder_Rejects ADD CONSTRAINT RefDimDate109 
    FOREIGN KEY (ShipDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactSalesTerritory 
--

ALTER TABLE FactSalesTerritory ADD CONSTRAINT RefDimCountry82 
    FOREIGN KEY (CountryCode_SK)
    REFERENCES DimCountry(CountryCode_SK)
;


-- 
-- TABLE: FactWorkOrder 
--

ALTER TABLE FactWorkOrder ADD CONSTRAINT RefDimProduct84 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactWorkOrder ADD CONSTRAINT RefDimScrapReason87 
    FOREIGN KEY (ScrapID_SK)
    REFERENCES DimScrapReason(ScrapID_SK)
;

ALTER TABLE FactWorkOrder ADD CONSTRAINT RefDimDate114 
    FOREIGN KEY (StartDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrder ADD CONSTRAINT RefDimDate115 
    FOREIGN KEY (EndDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrder ADD CONSTRAINT RefDimDate116 
    FOREIGN KEY (DueDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactWorkOrder_Rejects 
--

ALTER TABLE FactWorkOrder_Rejects ADD CONSTRAINT RefDimProduct85 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactWorkOrder_Rejects ADD CONSTRAINT RefDimScrapReason86 
    FOREIGN KEY (ScrapID_SK)
    REFERENCES DimScrapReason(ScrapID_SK)
;

ALTER TABLE FactWorkOrder_Rejects ADD CONSTRAINT RefDimDate117 
    FOREIGN KEY (StartDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrder_Rejects ADD CONSTRAINT RefDimDate118 
    FOREIGN KEY (EndDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrder_Rejects ADD CONSTRAINT RefDimDate119 
    FOREIGN KEY (DueDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactWorkOrderRouting 
--

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefDimLocation88 
    FOREIGN KEY (LocationID_SK)
    REFERENCES DimLocation(LocationID_SK)
;

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefDimProduct89 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefFactWorkOrder90 
    FOREIGN KEY (WorkOrderID)
    REFERENCES FactWorkOrder(WorkOrderID)
;

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefDimDate120 
    FOREIGN KEY (ScheduledStartDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefDimDate121 
    FOREIGN KEY (ScheduledEndDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefDimDate122 
    FOREIGN KEY (ActualStartDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrderRouting ADD CONSTRAINT RefDimDate123 
    FOREIGN KEY (ActualEndDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactWorkOrderRouting_Rejects 
--

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefDimLocation91 
    FOREIGN KEY (LocationID_SK)
    REFERENCES DimLocation(LocationID_SK)
;

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefDimProduct92 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefFactWorkOrder_Rejects93 
    FOREIGN KEY (WorkOrderID)
    REFERENCES FactWorkOrder_Rejects(WorkOrderID)
;

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefDimDate124 
    FOREIGN KEY (ActualEndDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefDimDate125 
    FOREIGN KEY (ScheduledEndDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefDimDate126 
    FOREIGN KEY (ScheduledStartDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactWorkOrderRouting_Rejects ADD CONSTRAINT RefDimDate127 
    FOREIGN KEY (ActualStartDate)
    REFERENCES DimDate(DateKey_SK)
;


CREATE TABLE `dim_sorsystem` (
   `SOR_ID` int(11) NOT NULL PRIMARY KEY,
   `SOR_Name` varchar(100) NOT NULL
 )
 
 CREATE TABLE `dim_RejectCodes` (
   `Reject_ID` int(11) NOT NULL PRIMARY KEY,
   `RejectReason` varchar(100) NOT NULL
 )


INSERT INTO DIM_SORSYSTEM
SELECT 1, 'MySQL-aw2017neu_purchasing'
UNION SELECT 2, 'Oracle-aw2017neu_person'
UNION SELECT 3, 'Oracle-aw2017neu_hr'
UNION SELECT 4, 'SQLServer-AdventureWorks2017'
UNION SELECT 5, 'DimDate.csv'
UNION SELECT 6, 'MySQL-purchasingdw'
UNION SELECT 7, 'Oracle-purchasingdw';


ALTER TABLE dimproductlistprice_scd ADD ListPrice DECIMAL(19,4) NULL;