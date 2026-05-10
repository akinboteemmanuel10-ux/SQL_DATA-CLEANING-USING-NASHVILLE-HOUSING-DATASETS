-- DATA CLEANING PROJECT
-- CREATING TABLE AND INSERTING
-- 1. REMOVE DUPLICATE
-- 2. STANDARDIZE DATA TYPE
-- 3. NULL OR BLANK
-- 4. REMOVING OF COLUMN
-- 5. RENAMING COLUMN NAME


-- DATASETS OVERVIEW
select
* from qmbdb.`nashville housing data`;

-- CREATING ANOTHER TABLE FOR DATA CLEANING
Create table qmbdb.raw_vile
like qmbdb.`nashville housing data`;


-- NEW TABLE CREATED FOR CLEANING 
select * from qmbdb.raw_vile;

-- USING THE INSERT FUNTION TO GENERATE DATASETS TO NEW TABLE
Insert qmbdb.raw_vile
select * from
qmbdb.`nashville housing data`;

-- USING THE ROW_NUMBER()FUNCTION TO CHECK THE ROW NUMBER
SELECT * ,
row_number() OVER(partition by ï»¿UniqueID,ParcelID,LandUse,PropertyAddress,
SaleDate,SalePrice,LegalReference,SoldAsVacant,OwnerName,OwnerAddress,
Acreage,TaxDistrict,LandValue,BuildingValue,TotalValue,YearBuilt,Bedrooms,FullBath,
HalfBath)as row_num
from qmbdb.raw_vile;

-- CHECKING IF THERE ARE ANY DUPLICATES USING THE "WITH DUPLICATE_CTE"
with duplicate_cte as 
(SELECT * ,
row_number() OVER(partition by ï»¿UniqueID,ParcelID,LandUse,PropertyAddress,
SaleDate,SalePrice,LegalReference,SoldAsVacant,OwnerName,OwnerAddress,
Acreage,TaxDistrict,LandValue,BuildingValue,TotalValue,YearBuilt,Bedrooms,FullBath,
HalfBath)as row_num
from qmbdb.raw_vile)
select * 
from duplicate_cte
where row_num > 1;


CREATE TABLE qmbdb.`raw_vile2` (
  `ï»¿UniqueID` int DEFAULT NULL,
  `ParcelID` text,
  `LandUse` text,
  `PropertyAddress` text,
  `SaleDate` text,
  `SalePrice` int DEFAULT NULL,
  `LegalReference` text,
  `SoldAsVacant` text,
  `OwnerName` text,
  `OwnerAddress` text,
  `Acreage` double DEFAULT NULL,
  `TaxDistrict` text,
  `LandValue` int DEFAULT NULL,
  `BuildingValue` int DEFAULT NULL,
  `TotalValue` int DEFAULT NULL,
  `YearBuilt` int DEFAULT NULL,
  `Bedrooms` int DEFAULT NULL,
  `FullBath` int DEFAULT NULL,
  `HalfBath` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- UPDATING CHANAGES IN DUPLICATED VALUE
select *
from qmbdb.raw_vile2;

insert into qmbdb.raw_vile2
SELECT * ,
row_number() OVER(partition by ï»¿UniqueID,ParcelID,LandUse,PropertyAddress,
SaleDate,SalePrice,LegalReference,SoldAsVacant,OwnerName,OwnerAddress,
Acreage,TaxDistrict,LandValue,BuildingValue,TotalValue,YearBuilt,Bedrooms,FullBath,
HalfBath)as row_num
from qmbdb.raw_vile;

select *
from qmbdb.raw_vile2;


-- STANDARDIZE TYPE FOR OWNERNAME(TRIM)
select ownername,trim(ownername)
from qmbdb.raw_vile2;

-- UPDATED OWNERNAME
update qmbdb.raw_vile2
set ownername = trim(ownername);

-- STANDARDIZE TYPE FOR TAXDISTRICT(TRIM)
select TaxDistrict,trim(taxdistrict)
from qmbdb.raw_vile2;

-- UPDATE STANDARDIZED TAXDISTRICT
update qmbdb.raw_vile2
set taxdistrict = trim(taxdistrict);


-- STANDARDIZE TYPE FOR PROPERTYADDRESSTRIM)
Select propertyAddress, trim(propertyAddress)
from qmbdb.raw_vile;

-- UPDATE STANDARDIZED PROPERTYADDRESS

Update qmbdb.raw_vile2
set propertyAddress =trim(propertyAddress);


-- REMOVING BLANKS AND NULL

select *
from qmbdb.raw_vile
where propertyaddress is null
or propertyaddress =' ';

-- removing of unknown symbol on uniqueID, and Adjusting of column items

-- Changed the irrelevent symbols added to the "uniqueID"
 ALTER TABLE qmbdb.raw_vile
CHANGE COLUMN `ï»¿UniqueID` `UniqueID` INT;

-- Added underscore to the column name

alter table qmbdb.raw_vile2
change column `UniqueID` `Unique_ID` int;


Alter table qmbdb.raw_vile2
change column parcelID parcel_ID text;


Alter table qmbdb.raw_vile2
change column Landuse land_use text;


Alter table qmbdb.raw_vile2
change column propertyaddress Property_Address text;


Alter table qmbdb.raw_vile2
change column saledate Sales_Date text;


alter table qmbdb.raw_vile2
change column saleprice Sales_Price int;


alter table qmbdb.raw_vile2
change column legalreference Legal_Reference text;

alter table qmbdb.raw_vile2
change column soldasvacant Sold_As_Vacant text;

alter table qmbdb.raw_vile2
change column Ownername Owner_Name text;

alter table qmbdb.raw_vile2
change column OwnerAddress Owner_Address text;

alter table qmbdb.raw_vile2
change column Taxdistrict Tax_District text;

alter table qmbdb.raw_vile2
change column landvalue Land_Value text;

alter table qmbdb.raw_vile2
change column buildingvalue Building_Value text;

alter table qmbdb.raw_vile2
change column totalvalue Total_Value text;

alter table qmbdb.raw_vile2
change column Yearbuilt Year_built text;

alter table qmbdb.raw_vile2
change column fullbath Full_Bath text;

alter table qmbdb.raw_vile2
change column Halfbath Half_Bath text;
