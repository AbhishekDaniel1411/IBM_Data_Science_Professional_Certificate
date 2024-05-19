--1. Display the names of the unique launch sites in the space mission

SELECT distinct("Launch_Site") FROM SpaceX_Table;


--2. Display 5 records where launch sites begin with the string 'CCA'

SELECT
  *
FROM
  SpaceX_Table
WHERE
  "Launch_Site" LIKE 'CCA%' limit 5;


--3. Display the total payload mass carried by boosters launched by NASA (CRS)

SELECT
  SUM("PAYLOAD_MASS__KG_") AS "Total payload mass launched by NASA (CRS)"
FROM
  SpaceX_Table
WHERE
  "Customer" = 'NASA (CRS)';


--4. Display average payload mass carried by booster version F9 v1.1

SELECT
  AVG("PAYLOAD_MASS__KG_") AS "Avg payload mass carried by F9 v1.1 boosters"
FROM
  SpaceX_Table
WHERE
  "Booster_Version" LIKE 'F9 v1.1%';


--5. List the date when the first succesful landing outcome in ground pad was acheived

SELECT DISTINCT("Landing_Outcome") FROM SpaceX_Table;

SELECT
  MIN("Date") AS "Date of First Success"
FROM
  SpaceX_Table
WHERE
  "Landing_Outcome" = 'Success (ground pad)';


--6. List the names of the boosters which have success in drone ship and have payload mass greater than 4000 but less than 6000

SELECT
	DISTINCT("Booster_Version") AS "Booster version",	
	"PAYLOAD_MASS__KG_",
	"Landing_Outcome"
FROM
  SpaceX_Table
WHERE
  "Landing_Outcome" = 'Success (drone ship)' AND "PAYLOAD_MASS__KG_" BETWEEN 4000 AND 6000;


--7. List the total number of successful and failure mission outcomes

SELECT
  "Landing_Outcome",
  COUNT(*) AS "MISSIONS"
FROM
  SpaceX_Table
GROUP BY
  "Landing_Outcome";


--8. List the names of the booster_versions which have carried the maximum payload mass.

SELECT MAX("PAYLOAD_MASS__KG_") FROM SpaceX_Table;

SELECT
  "Booster_Version", "PAYLOAD_MASS__KG_"
FROM
  SpaceX_Table
WHERE
  "PAYLOAD_MASS__KG_" = (SELECT MAX("PAYLOAD_MASS__KG_") FROM SpaceX_Table);


--9.List the records which will display the month names, failure landing_outcomes in drone ship, booster versions, launch_site for the months in year 2015.

SELECT
  DATE_PART('MONTH', "Date"::DATE) AS "Month",
  "Booster_Version",
  "Launch_Site"
FROM
  SpaceX_Table
WHERE
 "Landing_Outcome" = 'Failure (drone ship)' AND DATE_PART('YEAR', "Date":: DATE) ='2015';


--10. Rank the count of landing outcomes (such as Failure (drone ship) or Success (ground pad)) between the date 2010-06-04 and 2017-03-20, in descending order.

SELECT
  "Landing_Outcome",
  COUNT("Landing_Outcome") AS "Count"
FROM
  SpaceX_Table
WHERE
  "Date" BETWEEN '2010-06-04' AND '2017-03-20'
GROUP BY
  "Landing_Outcome"
ORDER BY
  "Count" DESC;

