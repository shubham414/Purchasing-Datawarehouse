CREATE TABLE "PURCHASINGDW"."DIMPRODUCTSTANDARDCOST_SCD" 
   (	"DIMENSIONTABLE_SK" NUMBER(38,0) NOT NULL ENABLE, 
	"DIMENSION_DURABLE_SK" NUMBER(38,0) NOT NULL ENABLE, 
	"SOR_ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"STANDARDCOST" NUMBER(19,4) NOT NULL ENABLE, 
	"EFFECTIVEDATE" TIMESTAMP (6) NOT NULL ENABLE, 
	"INEFFECTIVEDATE" TIMESTAMP (6), 
	"STATUS" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"JOBID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"CREATEDDATE" TIMESTAMP (6) DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIEDDATE" TIMESTAMP (6) DEFAULT (sysdate), 
	"DIMENSION_NK" NUMBER(38,0) NOT NULL ENABLE, 
	"ROWVERSION" NUMBER(*,0), 
	 CONSTRAINT "PK_STDCOST" PRIMARY KEY ("DIMENSIONTABLE_SK")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "REFDIMPRODUCT131" FOREIGN KEY ("DIMENSION_NK")
	  REFERENCES "PURCHASINGDW"."DIMPRODUCT" ("PRODUCTID_SK") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  
  CREATE TABLE "PURCHASINGDW"."DIMPRODUCTLISTPRICE_SCD" 
   (	"DIMENSIONTABLE_SK" NUMBER(38,0) NOT NULL ENABLE, 
	"DIMENSION_DURABLE_SK" NUMBER(38,0) NOT NULL ENABLE, 
	"SOR_ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"LISTPRICE" NUMBER(19,4) NOT NULL ENABLE, 
	"EFFECTIVEDATE" TIMESTAMP (6) NOT NULL ENABLE, 
	"INEFFECTIVEDATE" TIMESTAMP (6), 
	"STATUS" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"JOBID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"CREATEDDATE" TIMESTAMP (6) DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIEDDATE" TIMESTAMP (6) DEFAULT (sysdate), 
	"DIMENSION_NK" NUMBER(38,0), 
	"ROWVERSION" NUMBER(*,0), 
	 CONSTRAINT "PK_LISTPRICE" PRIMARY KEY ("DIMENSIONTABLE_SK")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "REFDIMPRODUCT129" FOREIGN KEY ("DIMENSION_NK")
	  REFERENCES "PURCHASINGDW"."DIMPRODUCT" ("PRODUCTID_SK") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
