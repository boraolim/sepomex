-- 1643315523-BulkInsertSEPOMEX.sql

-- Author: Olimpo Bonilla Ramírez.
-- Purpose: Objective: Execute the bulk load of the SEPOMEX records from the plain text file of the SEPOMEX website.
-- Date: 2022-01-27.
-- Remarks: For Microsoft SQL Server only (2005 onwards).

USE [MyDataBase]
GO

-- Drop the table if exists.
DROP TABLE [dbo].[CPdescarga];

-- Create the table...
CREATE TABLE [dbo].[CPdescarga]
(
  [d_codigo]         [int]              NULL,
  [d_ASenta]         [varchar] (max)    NULL,
  [d_tipo_ASenta]    [varchar] (max)    NULL,
  [D_mnpio]          [varchar] (max)    NULL,
  [d_estado]         [varchar] (max)    NULL,
  [d_ciudad]         [varchar] (max)    NULL,
  [d_CP]             [varchar] (max)    NULL,
  [c_estado]         [varchar] (max)    NULL,
  [c_oficina]        [varchar] (max)    NULL,
  [c_CP]             [varchar] (max)    NULL,
  [c_tipo_ASenta]    [varchar] (max)    NULL,
  [c_mnpio]          [varchar] (max)    NULL,
  [id_ASenta_cpcons] [varchar] (max)    NULL,
  [d_zona]           [varchar] (max)    NULL,
  [c_cve_ciudad]     [varchar] (max)    NULL
);
GO

-- Truncate the table.
TRUNCATE TABLE [dbo].[CPdescarga];

-- Perform the bulk insert process on the table.
BULK INSERT [dbo].[CPdescarga] FROM 'C:\MySepomexTextPlain.csv'
WITH ( CODEPAGE = '1252', FIRSTROW = 2, FIELDTERMINATOR ='|', ROWTERMINATOR = '0x0a' );

-- Fix the ids of the municipalities and neighborhoods in Mexico City.
UPDATE [dbo].[CPdescarga] SET c_mnpio = '001' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 1000 AND 1999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '002' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 2000 AND 2999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '003' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 3000 AND 3999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '004' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 4000 AND 4999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '005' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 5000 AND 5999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '006' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 6000 AND 6999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '007' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 7000 AND 7999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '008' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 8000 AND 8999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '009' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 9000 AND 9999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '010' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 10000 AND 10999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '011' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 11000 AND 11999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '012' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 12000 AND 12999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '013' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 13000 AND 13999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '014' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 14000 AND 14999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '015' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 15000 AND 15999);
UPDATE [dbo].[CPdescarga] SET c_mnpio = '016' WHERE (CAST(c_estado AS int) = 9) AND (CAST(d_codigo AS int) BETWEEN 16000 AND 16999);


-- Execute the record insert on the target table with this optimized SELECT statement.
--INSERT INTO [MyOtherDataBase].[dbo].[mytable]
SELECT 138 [id_country],
       CAST(t1.c_estado AS int) [Id_estado],
       UPPER(LTRIM(RTRIM(t1.d_estado))) [Estado],
       CAST(t1.c_mnpio AS int) [Id_mnpio],
       UPPER(LTRIM(RTRIM(t1.D_mnpio))) [Municipio],
       UPPER(LTRIM(RTRIM(t1.d_ciudad))) [Ciudad],
       UPPER(LTRIM(RTRIM(t1.d_zona))) [Zona_name],
       CAST(t1.d_codigo AS int) [postal_code],
       CAST(t1.id_ASenta_cpcons AS int) [tipo_ASentamiento_id],
       UPPER(LTRIM(RTRIM(t1.d_ASenta))) [tipo_ASentamiento_name],
       CAST(t1.c_tipo_ASenta AS int) [Id_township_type],
       upper(ltrim(rtrim(t1.d_tipo_ASenta))) [township_type_name],
       1 [C2], 0 [C3], GETUTCDATE() [C4], 0 [C5], null [C6], null [C7], null [C8], null [C9]
  FROM [dbo].[CPdescarga] t1
 ORDER BY CAST(t1.d_codigo AS int) ASC, CAST(t1.c_mnpio AS int) ASC, CAST(t1.id_ASenta_cpcons AS int) ASC;

-- 1643315523-BulkInsertSEPOMEX.sql