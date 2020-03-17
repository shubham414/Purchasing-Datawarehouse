--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      AW_PurchasingDW.DM1
--
-- Date Created : Tuesday, February 25, 2020 23:47:20
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: DimCountry 
--

CREATE TABLE DimCountry(
    CountryCode_SK       VARCHAR2(10)         NOT NULL,
    SOR_ID               VARCHAR2(50)     NOT NULL,
    CountryRegionName    VARCHAR2(100)    NOT NULL,
    JobID                VARCHAR2(50)     NOT NULL,
    CreatedDate          TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_CountryCode PRIMARY KEY (CountryCode_SK)
)
;



-- 
-- TABLE: DimDate 
--

CREATE TABLE DimDate(
    DateKey_SK               NUMBER(19, 0)    NOT NULL,
    SOR_ID                   VARCHAR2(50)     NOT NULL,
    FullDate_AlternateKey    TIMESTAMP(6)     NOT NULL,
    Day                      NUMBER(3, 0)     NOT NULL,
    Week                     NUMBER(38, 0)    NOT NULL,
    Month                    NUMBER(38, 0)    NOT NULL,
    CalendarQuarter          VARCHAR2(10)     NOT NULL,
    CalendarYear             NUMBER(38, 0)    NOT NULL,
    JobID                    VARCHAR2(50)     NOT NULL,
    CreatedDate              TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_DateKey PRIMARY KEY (DateKey_SK)
)
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeID_SK        NUMBER(38, 0)     NOT NULL,
    SOR_ID               VARCHAR2(50),
    NationalIDNumber     NVARCHAR2(15)     NOT NULL,
    PersonType           CHAR(10)          NOT NULL,
    Title                CHAR(10),
    FirstName            VARCHAR2(100)     NOT NULL,
    MiddleName           VARCHAR2(50),
    LastName             VARCHAR2(100)     NOT NULL,
    Suffix               VARCHAR2(10),
    JobTitle             NVARCHAR2(50)     NOT NULL,
    PhoneNumber          VARCHAR2(25),
    PhoneNumberType      VARCHAR2(50),
    EmailAddress         VARCHAR2(50),
    EmailPromotion       NUMBER(38, 0)     NOT NULL,
    AddressLine1         VARCHAR2(60)      NOT NULL,
    AddressLine2         VARCHAR2(60),
    LoginID              NVARCHAR2(256)    NOT NULL,
    OrganizationNode     CHAR(10),
    OrganizationLevel    SMALLINT,
    MaritalStatus        NCHAR(1)          NOT NULL
                         CONSTRAINT CK_E_MaritalStatus CHECK ((upper(MaritalStatus)='S' OR upper(MaritalStatus)='M')),
    Gender               NCHAR(1)          NOT NULL
                         CONSTRAINT CK_E_Gender CHECK ((upper(Gender)='F' OR upper(Gender)='M')),
    SalariedFlag         NUMBER(1, 0)      DEFAULT (1) NOT NULL,
    VacationHours        SMALLINT          DEFAULT ((0)) NOT NULL
                         CONSTRAINT CK_E_VacationHours CHECK ((VacationHours>=(-40) AND VacationHours<=(240))),
    SickLeaveHours       SMALLINT          DEFAULT ((0)) NOT NULL
                         CONSTRAINT CK_E_SickLeaveHours CHECK ((SickLeaveHours>=(0) AND SickLeaveHours<=(120))),
    CurrentFlag          NUMBER(1, 0)      DEFAULT (1) NOT NULL,
    BirthDate            NUMBER(19, 0)     NOT NULL,
    HireDate             NUMBER(19, 0)     NOT NULL,
    JobID                VARCHAR2(50)      NOT NULL,
    CreatedDate          TIMESTAMP(6)      DEFAULT (sysdate) NOT NULL,
    ModifiedDate         TIMESTAMP(6)      DEFAULT (sysdate),
    GeographyKey_SK      NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK_EmployeeID PRIMARY KEY (EmployeeID_SK)
)
;



-- 
-- TABLE: DimGeography 
--

CREATE TABLE DimGeography(
    GeographyKey_SK      NUMBER(38, 0)    NOT NULL,
    SOR_ID               VARCHAR2(50)     NOT NULL,
    StateProvinceID      NUMBER(38, 0)    NOT NULL,
    StateProvinceCode    NCHAR(3)         NOT NULL,
    StateProvinceName    NVARCHAR2(50)    NOT NULL,
    City                 NVARCHAR2(50)    NOT NULL,
    PostalCode           VARCHAR2(10)     NOT NULL,
    JobID                VARCHAR2(50)     NOT NULL,
    CreatedDate          TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate         TIMESTAMP(6)     DEFAULT (sysdate),
    CountryCode_SK       VARCHAR2(10)         NOT NULL,
    CONSTRAINT PK_GoegraphyKey PRIMARY KEY (GeographyKey_SK)
)
;



-- 
-- TABLE: DimLocation 
--

CREATE TABLE DimLocation(
    LocationID_SK    SMALLINT         NOT NULL,
    SOR_ID           VARCHAR2(50)     NOT NULL,
    Name             NVARCHAR2(50)    NOT NULL,
    CostRate         NUMBER(10, 2)    DEFAULT (0.00) NOT NULL
                     CONSTRAINT CK_Location_CostRate CHECK ((CostRate>=(0.00))),
    Availability     NUMBER(8, 2)     DEFAULT (0.00) NOT NULL
                     CONSTRAINT CK_Location_Availability CHECK ((Availability>=(0.00))),
    JobID            VARCHAR2(50)     NOT NULL,
    CreatedDate      TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_LocationID PRIMARY KEY (LocationID_SK)
)
;



-- 
-- TABLE: DimProduct 
--

CREATE TABLE DimProduct(
    ProductID_SK             NUMBER(38, 0)    NOT NULL,
    SOR_ID                   VARCHAR2(50)     NOT NULL,
    SubcategoryName          NVARCHAR2(50),
    CategoryName             NVARCHAR2(50),
    ModelName                NVARCHAR2(50),
    ProductName              NVARCHAR2(50)    NOT NULL,
    ProductNumber            NVARCHAR2(25)    NOT NULL,
    MakeFlag                 NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    FinishedGoodsFlag        NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    Color                    NVARCHAR2(15),
    SafetyStockLevel         SMALLINT         NOT NULL
                             CONSTRAINT CK_Product_SafetyStockLevel CHECK ((SafetyStockLevel>(0))),
    ReorderPoint             SMALLINT         NOT NULL
                             CONSTRAINT CK_Product_ReorderPoint CHECK ((ReorderPoint>(0))),
    StandardCost             NUMBER(19, 4)    NOT NULL
                             CONSTRAINT CK_Product_StandardCost CHECK ((StandardCost>=(0.00))),
    ListPrice                NUMBER(19, 4)    NOT NULL
                             CONSTRAINT CK_Product_ListPrice CHECK ((ListPrice>=(0.00))),
    UnitPrice                NUMBER(19, 4)    NOT NULL,
    "Size"                     NVARCHAR2(5),
    SizeUnitMeasureCode      NCHAR(3),
    WeightUnitMeasureCode    NCHAR(3),
    Weight                   NUMBER(8, 2)     
                             CONSTRAINT CK_Product_Weight CHECK ((Weight>(0.00))),
    DaysToManufacture        NUMBER(38, 0)    NOT NULL
                             CONSTRAINT CK_Product_DaysToManufacture CHECK ((DaysToManufacture>=(0))),
    ProductLine              NCHAR(2)         
                             CONSTRAINT CK_Product_ProductLine CHECK ((upper(ProductLine)='R' OR upper(ProductLine)='M' OR upper(ProductLine)='T' OR upper(ProductLine)='S' OR ProductLine IS NULL)),
    "Class"                    NCHAR(2)         
                             CONSTRAINT CK_Product_Class CHECK ((upper("Class" )='H' OR upper("Class" )='M' OR upper("Class" )='L' OR "Class"  IS NULL)),
    "Style"                    NCHAR(2)         
                             CONSTRAINT CK_Product_Style CHECK ((upper("Style")='U' OR upper("Style")='M' OR upper("Style")='W' OR "Style" IS NULL)),
    SellStartDate            NUMBER(19, 0),
    SellEndDate              NUMBER(19, 0),
    DiscontinuedDate         NUMBER(19, 0),
    JobID                    VARCHAR2(50)     NOT NULL,
    CreatedDate              TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_ProductID PRIMARY KEY (ProductID_SK)
)
;



-- 
-- TABLE: DimProductListPrice_SCD 
--

CREATE TABLE DimProductListPrice_SCD(
    DimensionTable_SK       NUMBER(38, 0)    NOT NULL,
    Dimension_Durable_SK    NUMBER(38, 0)    NOT NULL,
    SOR_ID                  VARCHAR2(50)     NOT NULL,
    ListPrice               NUMBER(19, 4)    NOT NULL,
    EffectiveDate           TIMESTAMP(6)     NOT NULL,
    IneffectiveDate         TIMESTAMP(6),
    Status                  VARCHAR2(20)     NOT NULL,
    Version                 BINARY_FLOAT     NOT NULL,
    JobID                   VARCHAR2(50)     NOT NULL,
    CreatedDate             TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate            TIMESTAMP(6)     DEFAULT (sysdate),
    Dimension_NK            NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_ListPrice PRIMARY KEY (DimensionTable_SK)
)
;



-- 
-- TABLE: DimProductStandardCost_SCD 
--

CREATE TABLE DimProductStandardCost_SCD(
    DimensionTable_SK       NUMBER(38, 0)    NOT NULL,
    Dimension_Durable_SK    NUMBER(38, 0)    NOT NULL,
    SOR_ID                  VARCHAR2(50)     NOT NULL,
    StandardCost            NUMBER(19, 4)    NOT NULL,
    EffectiveDate           TIMESTAMP(6)     NOT NULL,
    IneffectiveDate         TIMESTAMP(6),
    Status                  VARCHAR2(20)     NOT NULL,
    Version                 BINARY_FLOAT     NOT NULL,
    JobID                   VARCHAR2(50)     NOT NULL,
    CreatedDate             TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate            TIMESTAMP(6)     DEFAULT (sysdate),
    Dimension_NK            NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_StdCost PRIMARY KEY (DimensionTable_SK)
)
;



-- 
-- TABLE: DimProductVendor 
--

CREATE TABLE DimProductVendor(
    ProductID_SK       NUMBER(38, 0)    NOT NULL,
    VendorID_SK        NUMBER(38, 0)    NOT NULL,
    SOR_ID             VARCHAR2(50)     NOT NULL,
    AverageLeadTime    NUMBER(38, 0)    NOT NULL
                       CONSTRAINT CK_PV_AverageLeadTime CHECK ((AverageLeadTime>=(1))),
    StandardPrice      NUMBER(19, 4)    NOT NULL
                       CONSTRAINT CK_PV_StandardPrice CHECK ((StandardPrice>(0.00))),
    LastReceiptCost    NUMBER(19, 4)    
                       CONSTRAINT CK_PV_LastReceiptCost CHECK ((LastReceiptCost>(0.00))),
    LastReceiptDate    NUMBER(19, 0),
    MinOrderQty        NUMBER(38, 0)    NOT NULL
                       CONSTRAINT CK_PV_MinOrderQty CHECK ((MinOrderQty>=(1))),
    MaxOrderQty        NUMBER(38, 0)    NOT NULL
                       CONSTRAINT CK_PV_MaxOrderQty CHECK ((MaxOrderQty>=(1))),
    OnOrderQty         NUMBER(38, 0)    
                       CONSTRAINT CK_PV_OnOrderQty CHECK ((OnOrderQty>=(0))),
    UnitMeasureCode    NCHAR(3)         NOT NULL,
    JobID              VARCHAR2(50)     NOT NULL,
    CreatedDate        TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate       TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_ProductVendor PRIMARY KEY (ProductID_SK, VendorID_SK)
)
;



-- 
-- TABLE: DimScrapReason 
--

CREATE TABLE DimScrapReason(
    ScrapID_SK      NUMBER(38, 0)    NOT NULL,
    SOR_ID          VARCHAR2(50)     NOT NULL,
    ScrapReason     VARCHAR2(50)     NOT NULL,
    JobID           VARCHAR2(50)     NOT NULL,
    CreatedDate     TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_ScrapID PRIMARY KEY (ScrapID_SK)
)
;



-- 
-- TABLE: DimShipMethod 
--

CREATE TABLE DimShipMethod(
    ShipMethodID_SK    NUMBER(38, 0)    NOT NULL,
    SOR_ID             VARCHAR2(50)     NOT NULL,
    Name               NVARCHAR2(50)    NOT NULL,
    ShipBase           NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                       CONSTRAINT CK_ShipMethod_ShipBase CHECK ((ShipBase>(0.00))),
    ShipRate           NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                       CONSTRAINT CK_ShipMethod_ShipRate CHECK ((ShipRate>(0.00))),
    JobID              VARCHAR2(50)     NOT NULL,
    CreatedDate        TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate       TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_ShipMethodID PRIMARY KEY (ShipMethodID_SK)
)
;



-- 
-- TABLE: DimVendor 
--

CREATE TABLE DimVendor(
    VendorID_SK              NUMBER(38, 0)    NOT NULL,
    SOR_ID                   VARCHAR2(50)     NOT NULL,
    VendorName               NVARCHAR2(50)    NOT NULL,
    AccountNumber            NVARCHAR2(15)    NOT NULL,
    CreditRating             NUMBER(3, 0)     NOT NULL
                             CONSTRAINT CK_Vendor_CreditRating CHECK ((CreditRating>=(1) AND CreditRating<=(5))),
    PreferredVendorStatus    NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    ActiveFlag               NUMBER(1, 0)     DEFAULT (1) NOT NULL,
    AddressType              VARCHAR2(50)     NOT NULL,
    AddressLine1             VARCHAR2(60)     NOT NULL,
    AddressLine2             VARCHAR2(60),
    JobID                    VARCHAR2(50)     NOT NULL,
    CreatedDate              TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (sysdate),
    GeographyKey_SK          NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_VendorID PRIMARY KEY (VendorID_SK)
)
;



-- 
-- TABLE: DimVendorContacts 
--

CREATE TABLE DimVendorContacts(
    VendorContactID_SK    NUMBER(38, 0)    NOT NULL,
    SOR_ID                VARCHAR2(50)     NOT NULL,
    ContactType           VARCHAR2(50)     NOT NULL,
    Title                 VARCHAR2(8),
    FirstName             VARCHAR2(50)     NOT NULL,
    MiddleName            VARCHAR2(50),
    LastName              VARCHAR2(50)     NOT NULL,
    Suffix                VARCHAR2(10),
    PhoneNumber           VARCHAR2(25),
    PhoneNumberType       VARCHAR2(50),
    EmailAddress          VARCHAR2(50),
    EmailPromotion        NUMBER(38, 0)    NOT NULL,
    JobID                 VARCHAR2(50)     NOT NULL,
    CreatedDate           TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate          TIMESTAMP(6)     DEFAULT (sysdate),
    VendorID_SK           NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_VendorContactID PRIMARY KEY (VendorContactID_SK)
)
;



-- 
-- TABLE: FactProductInventory 
--

CREATE TABLE FactProductInventory(
    ProductID_SK     NUMBER(38, 0)    NOT NULL,
    LocationID_SK    SMALLINT         NOT NULL,
    Shelf            NVARCHAR2(10)    NOT NULL
                     CONSTRAINT CK_PI_Shelf CHECK ((Shelf like 'A-Za-z' OR Shelf='N/A')),
    Bin              NUMBER(3, 0)     NOT NULL
                     CONSTRAINT CK_PI_Bin CHECK ((Bin>=(0) AND Bin<=(100))),
    Quantity         SMALLINT         DEFAULT ((0)) NOT NULL,
    JobID            VARCHAR2(50)     NOT NULL,
    CreatedDate      TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate     TIMESTAMP(6)     DEFAULT (sysdate),
    CONSTRAINT PK_ProdInventory PRIMARY KEY (ProductID_SK, LocationID_SK)
)
;



-- 
-- TABLE: FactPurchaseOrder 
--

CREATE TABLE FactPurchaseOrder(
    PurchaseOrderID_SK          NUMBER(38, 0)    NOT NULL,
    PurchaseOrderDetailID_SK    NUMBER(38, 0)    NOT NULL,
    RevisionNumber              NUMBER(3, 0)     DEFAULT (0) NOT NULL,
    OrderQty                    NUMBER(38, 0)    NOT NULL,
    ReceivedQty                 NUMBER(8, 2)     NOT NULL,
    StockedQty                  NUMBER(8, 2)     NOT NULL,
    Status                      NUMBER(3, 0)     DEFAULT (1) NOT NULL
                                CONSTRAINT CK_POH_Status CHECK ((Status>=(1) AND Status<=(4))),
    SubTotal                    NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                                CONSTRAINT CK_POH_SubTotal CHECK ((SubTotal>=(0.00))),
    TaxAmt                      NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                                CONSTRAINT CK_POH_TaxAmt CHECK ((TaxAmt>=(0.00))),
    Freight                     NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                                CONSTRAINT CK_POH_Freight CHECK ((Freight>=(0.00))),
    TotalDue                    NUMBER(19, 4)    NOT NULL,
    DueDate                     NUMBER(19, 0)    NOT NULL,
    OrderDate                   NUMBER(19, 0)    NOT NULL,
    ShipDate                    NUMBER(19, 0)    NOT NULL,
    JobID                       VARCHAR2(50)     NOT NULL,
    CreatedDate                 TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate                TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ProductID_SK                NUMBER(38, 0)    NOT NULL,
    ShipMethodID_SK             NUMBER(38, 0)    NOT NULL,
    EmployeeID_SK               NUMBER(38, 0)    NOT NULL,
    VendorID_SK                 NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_PurchaseOrderID PRIMARY KEY (PurchaseOrderID_SK, PurchaseOrderDetailID_SK)
)
;



-- 
-- TABLE: FactPurchaseOrder_Rejects 
--

CREATE TABLE FactPurchaseOrder_Rejects(
    PurchaseOrderID_SK          NUMBER(38, 0)    NOT NULL,
    PurchaseOrderDetailID_SK    NUMBER(38, 0)    NOT NULL,
    RevisionNumber              NUMBER(3, 0)     DEFAULT (0) NOT NULL,
    OrderQty                    NUMBER(38, 0)    NOT NULL,
    RejectedQty                 NUMBER(8, 2)     NOT NULL,
    Status                      NUMBER(3, 0)     DEFAULT (1) NOT NULL
                                CONSTRAINT CK_POHR_Status CHECK ((Status>=(1) AND Status<=(4))),
    SubTotal                    NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                                CONSTRAINT CK_POHR_SubTotal CHECK ((SubTotal>=(0.00))),
    TaxAmt                      NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                                CONSTRAINT CK_POHR_TaxAmt CHECK ((TaxAmt>=(0.00))),
    Freight                     NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                                CONSTRAINT CK_POHR_Freight CHECK ((Freight>=(0.00))),
    TotalDue                    NUMBER(19, 4)    NOT NULL,
    DueDate                     NUMBER(19, 0)    NOT NULL,
    OrderDate                   NUMBER(19, 0)    NOT NULL,
    ShipDate                    NUMBER(19, 0)    NOT NULL,
    JobID                       VARCHAR2(50)     NOT NULL,
    CreatedDate                 TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate                TIMESTAMP(6)     DEFAULT (sysdate),
    ProductID_SK                NUMBER(38, 0),
    ShipMethodID_SK             NUMBER(38, 0),
    EmployeeID_SK               NUMBER(38, 0),
    VendorID_SK                 NUMBER(38, 0),
    CONSTRAINT PK_PurchaseOrderID_R PRIMARY KEY (PurchaseOrderID_SK, PurchaseOrderDetailID_SK)
)
;



-- 
-- TABLE: FactSalesTerritory 
--

CREATE TABLE FactSalesTerritory(
    SalesTerritoryID_SK    NUMBER(38, 0)    NOT NULL,
    SalesTerritoryName     NVARCHAR2(50)    NOT NULL,
    "Group"                  NVARCHAR2(50)    NOT NULL,
    SalesYTD               NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                           CONSTRAINT CK_ST_SalesYTD CHECK ((SalesYTD>=(0.00))),
    SalesLastYear          NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                           CONSTRAINT CK_ST_SalesLastYear CHECK ((SalesLastYear>=(0.00))),
    CostYTD                NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                           CONSTRAINT CK_ST_CostYTD CHECK ((CostYTD>=(0.00))),
    CostLastYear           NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                           CONSTRAINT CK_ST_CostLastYear CHECK ((CostLastYear>=(0.00))),
    JobID                  VARCHAR2(50)     NOT NULL,
    CreatedDate            TIMESTAMP(6)     DEFAULT sysdate NOT NULL,
    ModifiedDate           TIMESTAMP(6)     DEFAULT (sysdate),
    CountryCode_SK         VARCHAR2(10)         NOT NULL,
    CONSTRAINT PK_TerritoryID PRIMARY KEY (SalesTerritoryID_SK)
)
;



-- 
-- TABLE: FactWorkOrder 
--

CREATE TABLE FactWorkOrder(
    WorkOrderID     NUMBER(38, 0)    NOT NULL,
    OrderQty        NUMBER(38, 0)    NOT NULL,
    StockedQty      NUMBER(38, 0)    NOT NULL,
    ScrapedQty      NUMBER(38, 0)    NOT NULL,
    StartDate       NUMBER(19, 0)    NOT NULL,
    EndDate         NUMBER(19, 0)    NOT NULL,
    DueDate         NUMBER(19, 0)    NOT NULL,
    JobID           VARCHAR2(50)     NOT NULL,
    CreatedDate     TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (sysdate),
    ProductID_SK    NUMBER(38, 0)    NOT NULL,
    ScrapID_SK      NUMBER(38, 0),
    CONSTRAINT PK_WorkOrderID PRIMARY KEY (WorkOrderID)
)
;



-- 
-- TABLE: FactWorkOrder_Rejects 
--

CREATE TABLE FactWorkOrder_Rejects(
    WorkOrderID     NUMBER(38, 0)    NOT NULL,
    OrderQty        NUMBER(38, 0)    NOT NULL,
    StockedQty      NUMBER(38, 0)    NOT NULL,
    ScrapedQty      NUMBER(38, 0)    NOT NULL,
    StartDate       NUMBER(19, 0)    NOT NULL,
    EndDate         NUMBER(19, 0)    NOT NULL,
    DueDate         NUMBER(19, 0)    NOT NULL,
    JobID           VARCHAR2(50)     NOT NULL,
    CreatedDate     TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate    TIMESTAMP(6)     DEFAULT (sysdate),
    ProductID_SK    NUMBER(38, 0),
    ScrapID_SK      NUMBER(38, 0),
    CONSTRAINT PK_WorkOrderID_R PRIMARY KEY (WorkOrderID)
)
;



-- 
-- TABLE: FactWorkOrderRouting 
--

CREATE TABLE FactWorkOrderRouting(
    WorkOrderRoutingID_SK    NUMBER(38, 0)    NOT NULL,
    OperationSequence        NUMBER(38, 0)    NOT NULL,
    ScheduledStartDate       NUMBER(19, 0)    NOT NULL,
    ScheduledEndDate         NUMBER(19, 0)    NOT NULL,
    ActualStartDate          NUMBER(19, 0)    NOT NULL,
    ActualEndDate            NUMBER(19, 0)    NOT NULL,
    ActualResourceHrs        NUMBER(10, 4)    NOT NULL,
    PlannedCost              NUMBER(10, 4)    NOT NULL,
    ActualCost               NUMBER(10, 4)    NOT NULL,
    JobID                    VARCHAR2(50)     NOT NULL,
    CreatedDate              TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (sysdate),
    LocationID_SK            SMALLINT         NOT NULL,
    ProductID_SK             NUMBER(38, 0)    NOT NULL,
    WorkOrderID              NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_WorkOrderRoutingID PRIMARY KEY (WorkOrderRoutingID_SK)
)
;



-- 
-- TABLE: FactWorkOrderRouting_Rejects 
--

CREATE TABLE FactWorkOrderRouting_Rejects(
    WorkOrderRoutingID_SK    NUMBER(38, 0)    NOT NULL,
    OperationSequence        NUMBER(38, 0)    NOT NULL,
    ScheduledStartDate       NUMBER(19, 0)    NOT NULL,
    ScheduledEndDate         NUMBER(19, 0)    NOT NULL,
    ActualStartDate          NUMBER(19, 0)    NOT NULL,
    ActualEndDate            NUMBER(19, 0)    NOT NULL,
    ActualResourceHrs        NUMBER(10, 4)    NOT NULL,
    PlannedCost              NUMBER(10, 4)    NOT NULL,
    ActualCost               NUMBER(10, 4)    NOT NULL,
    JobID                    VARCHAR2(50)     NOT NULL,
    CreatedDate              TIMESTAMP(6)     DEFAULT (sysdate) NOT NULL,
    ModifiedDate             TIMESTAMP(6)     DEFAULT (sysdate),
    LocationID_SK            SMALLINT,
    ProductID_SK             NUMBER(38, 0),
    WorkOrderID              NUMBER(38, 0),
    CONSTRAINT PK_WorkOrderRouting_R PRIMARY KEY (WorkOrderRoutingID_SK)
)
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

CREATE TABLE dim_sorsystem (
   SOR_ID int NOT NULL PRIMARY KEY,
   SOR_Name varchar(100) NOT NULL
 );
 
 CREATE TABLE dim_RejectCodes (
   Reject_ID int NOT NULL PRIMARY KEY,
   RejectReason varchar(100) NOT NULL
 );


INSERT INTO DIM_SORSYSTEM VALUES(1, 'MySQL-aw2017neu_purchasing');
INSERT INTO DIM_SORSYSTEM VALUES(2, 'Oracle-aw2017neu_person');
INSERT INTO DIM_SORSYSTEM VALUES( 3, 'Oracle-aw2017neu_hr');
INSERT INTO DIM_SORSYSTEM VALUES( 4, 'SQLServer-AdventureWorks2017');
INSERT INTO DIM_SORSYSTEM VALUES(5, 'DimDate.csv');
INSERT INTO DIM_SORSYSTEM VALUES( 6, 'MySQL-purchasingdw');
INSERT INTO DIM_SORSYSTEM VALUES( 7, 'Oracle-purchasingdw');


CREATE SEQUENCE geo_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
 
ALTER TABLE DIMPRODUCT
ADD ProductStyle VARCHAR(5);

ALTER TABLE DIMPRODUCT
DROP COLUMN "Style";

ALTER TABLE DIMPRODUCT
ADD ProductClass VARCHAR(5);

ALTER TABLE DIMPRODUCT
DROP COLUMN "Class";

ALTER TABLE DIMPRODUCT
DROP CONSTRAINT RefDimDate112;

--ALTER TABLE DIMPRODUCT
--DROP COLUMN SellEndDate;
--
--
--ALTER TABLE DIMPRODUCT
--ADD SellEndDate NUMBER(19, 0) NULL;
--
--ALTER TABLE DimProduct ADD CONSTRAINT RefDimDate112 
--    FOREIGN KEY (SellEndDate)
--    REFERENCES DimDate(DateKey_SK);
    
ALTER TABLE factproductinventory
DROP CONSTRAINT CK_PI_Shelf;

ALTER TABLE FACTWORKORDER
DROP CONSTRAINT RefDimProduct84;

ALTER TABLE FACTWORKORDER_REJECTS
DROP CONSTRAINT RefDimProduct85;

ALTER TABLE FactWorkOrderRouting_Rejects drop CONSTRAINT RefDimProduct92;
ALTER TABLE FactWorkOrderRouting drop CONSTRAINT RefDimProduct89 ;

CREATE SEQUENCE vencon_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE routing_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE routingreject_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
ALTER TABLE FactPurchaseOrder_Rejects DROP CONSTRAINT RefDimVendor99 ;
ALTER TABLE FactPurchaseOrder_Rejects DROP CONSTRAINT REFDIMPRODUCT98;
ALTER TABLE FactPurchaseOrder_Rejects DROP CONSTRAINT REFDIMEMPLOYEE95;
ALTER TABLE FactPurchaseOrder_Rejects DROP CONSTRAINT REFDIMSHIPMETHOD94;