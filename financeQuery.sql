CREATE DATABASE financeMK;
USE financeMK;

GO
CREATE SCHEMA staging;

/*--------------------analytics Table-----------------------*/

GO
SELECT * FROM staging.analytics;

SELECT Naziv_na_budgetski_korisnik, COUNT(*)
FROM staging.analytics
GROUP BY Naziv_na_budgetski_korisnik
HAVING COUNT(*) > 1;


SELECT COUNT(godina) FROM staging.analytics;

/*--------------------Deleting Duplicate Rows-----------------------*/

WITH cte AS (
   SELECT Razdel_na_budgetski_korisnik,Naziv_na_budgetski_korisnik,Broj_na_smetka,Konto,Broj_na_programa,Naziv_na_programa, ROW_NUMBER() OVER (
       PARTITION BY Razdel_na_budgetski_korisnik,Naziv_na_budgetski_korisnik,Broj_na_smetka,Konto,Broj_na_programa,Naziv_na_programa
       ORDER BY (SELECT 0)
   ) AS rowNum
   FROM staging.analytics
)
DELETE FROM cte
WHERE rowNum > 1;

/*--------------------Check and Delete negative values in Realiziran Budget-----------------------*/

SELECT Realiziran_budget FROM staging.analytics WHERE Realiziran_budget < 0;

DELETE FROM staging.analytics WHERE  Realiziran_budget < 0;


/*--------------------Check and Delete Razdel na budgetski korisnik values that start with 1-----------------------*/

SELECT Razdel_na_budgetski_korisnik FROM staging.analytics
WHERE LEFT(CAST(Razdel_na_budgetski_korisnik AS VARCHAR), 1) = '1';

DELETE FROM staging.analytics
WHERE LEFT(CAST(Razdel_na_budgetski_korisnik AS VARCHAR), 1) = '1';

/*--------------------Check and Delete Razdel NULL values in RKB na budgetski korisnik-----------------------*/

SELECT COUNT(*) as noNull FROM staging.analytics
WHERE ISNUMERIC(RKB_na_budgetski_korisnik) = 0 OR RKB_na_budgetski_korisnik IS NULL;

DELETE FROM staging.analytics
WHERE ISNUMERIC(RKB_na_budgetski_korisnik) = 0 OR RKB_na_budgetski_korisnik IS NULL;

SELECT RKB_na_budgetski_korisnik FROM staging.analytics


/*--------------------Check codes with different amounts of digits excluding zeros -----------------------*/

SELECT LEN(CAST(RKB_na_budgetski_korisnik AS varchar(5))) AS numDigits FROM staging.analytics;
SELECT RKB_na_budgetski_korisnik FROM staging.analytics;

SELECT LEN(SUBSTRING(RKB_na_budgetski_korisnik, PATINDEX('%[^0]%', RKB_na_budgetski_korisnik ), LEN(RKB_na_budgetski_korisnik))) AS Digits, COUNT(*) AS 'Amount of records'
FROM staging.analytics
GROUP BY LEN(SUBSTRING(RKB_na_budgetski_korisnik, PATINDEX('%[^0]%', RKB_na_budgetski_korisnik ), LEN(RKB_na_budgetski_korisnik)))
ORDER BY Digits;


/*--------------------transactions Table-----------------------*/

SELECT * FROM staging.transactions;