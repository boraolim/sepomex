-- 1643315523-BulkInsertSEPOMEX.sql

-- Author: Olimpo Bonilla Ramírez.
-- Purpose: Objective: Execute the bulk load of the SEPOMEX records from the plain text file of the SEPOMEX website.
-- Date: 2022-01-27.
-- Remarks: For MariaDB or MySQL only.

-- Drop the table if exists.
DROP TABLE IF EXISTS CPdescarga;

-- Create the table...
CREATE TABLE CPdescarga
(
  d_codigo         int              NULL,
  d_ASenta         varchar (512)    NULL,
  d_tipo_ASenta    varchar (512)    NULL,
  D_mnpio          varchar (512)    NULL,
  d_estado         varchar (512)    NULL,
  d_ciudad         varchar (512)    NULL,
  d_CP             varchar (512)    NULL,
  c_estado         varchar (512)    NULL,
  c_oficina        varchar (512)    NULL,
  c_CP             varchar (512)    NULL,
  c_tipo_ASenta    varchar (512)    NULL,
  c_mnpio          varchar (512)    NULL,
  id_ASenta_cpcons varchar (512)    NULL,
  d_zona           varchar (512)    NULL,
  c_cve_ciudad     varchar (512)    NULL
);

-- Truncate the table.
TRUNCATE TABLE CPdescarga;

-- Perform the bulk insert process on the table.
LOAD DATA INFILE 'C:\MySepomexTextPlain.csv'
INTO TABLE CPdescarga
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Fix the ids of the municipalities and neighborhoods in Mexico City.
UPDATE CPdescarga SET c_mnpio = '001' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 1000 AND 1999);
UPDATE CPdescarga SET c_mnpio = '002' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 2000 AND 2999);
UPDATE CPdescarga SET c_mnpio = '003' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 3000 AND 3999);
UPDATE CPdescarga SET c_mnpio = '004' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 4000 AND 4999);
UPDATE CPdescarga SET c_mnpio = '005' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 5000 AND 5999);
UPDATE CPdescarga SET c_mnpio = '006' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 6000 AND 6999);
UPDATE CPdescarga SET c_mnpio = '007' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 7000 AND 7999);
UPDATE CPdescarga SET c_mnpio = '008' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 8000 AND 8999);
UPDATE CPdescarga SET c_mnpio = '009' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 9000 AND 9999);
UPDATE CPdescarga SET c_mnpio = '010' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 10000 AND 10999);
UPDATE CPdescarga SET c_mnpio = '011' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 11000 AND 11999);
UPDATE CPdescarga SET c_mnpio = '012' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 12000 AND 12999);
UPDATE CPdescarga SET c_mnpio = '013' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 13000 AND 13999);
UPDATE CPdescarga SET c_mnpio = '014' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 14000 AND 14999);
UPDATE CPdescarga SET c_mnpio = '015' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 15000 AND 15999);
UPDATE CPdescarga SET c_mnpio = '016' WHERE (CAST(c_estado AS UNSIGNED) = 9) AND (CAST(d_codigo AS UNSIGNED) BETWEEN 16000 AND 16999);

-- Execute the record insert on the target table with this optimized SELECT statement.
--INSERT INTO mytable
SELECT 138 AS id_country,
       CAST(t1.c_estado AS UNSIGNED) AS Id_estado,
       UPPER(TRIM(t1.d_estado)) AS Estado,
       CAST(t1.c_mnpio AS UNSIGNED) AS Id_mnpio,
       UPPER(TRIM(t1.D_mnpio)) AS Municipio,
       UPPER(TRIM(t1.d_ciudad)) AS Ciudad,
       UPPER(TRIM(t1.d_zona)) AS Zona_name,
       CAST(t1.d_codigo AS UNSIGNED) AS postal_code,
       CAST(t1.id_ASenta_cpcons AS UNSIGNED) AS tipo_ASentamiento_id,
       UPPER(TRIM(t1.d_ASenta)) AS tipo_ASentamiento_name,
       CAST(t1.c_tipo_ASenta AS UNSIGNED) AS Id_township_type,
       upper(trim(t1.d_tipo_ASenta)) AS township_type_name,
       1 AS C2, 0 AS C3, current_timestamp() AS C4, 0 AS C5, null AS C6, null AS C7, null AS C8, null AS C9
  FROM CPdescarga t1
 ORDER BY CAST(t1.d_codigo AS UNSIGNED) ASC, CAST(t1.c_mnpio AS UNSIGNED) ASC, CAST(t1.id_ASenta_cpcons AS UNSIGNED) ASC;
 
-- Finally, drop the table if exists.
DROP TABLE CPdescarga;  

-- 1643315523-BulkInsertSEPOMEX.sql