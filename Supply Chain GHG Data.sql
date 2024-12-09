SELECT *
FROM SupplyChainGHG..SupplyChainGHG
ORDER BY 2


--select data for use

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG


--what produces the most kg CO2/USD

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
ORDER BY 4 desc


--total kg CO2/USD

SELECT SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG


--average kg CO2/USD

SELECT AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG


--kg CO2/USD produced by farming

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%farming%'
ORDER BY 4 desc


--kg CO2/USD produced by mining

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%mining%'
ORDER BY 4 desc


--kg CO2/USD produced by waste

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%waste%'
ORDER BY 4 desc


--kg CO2/USD produced by manufacturing

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%manufacturing%'
ORDER BY 4 desc


--kg CO2/USD produced by milling

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%mill%'
ORDER BY 4 desc


--kg CO2/USD produced by production

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%production%'
ORDER BY 4 desc


--kg CO2/USD produced by transportation

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%transport%'
ORDER BY 4 desc


--kg CO2/USD produced by other

SELECT [2017 NAICS Title], [Supply Chain Emission Factors without Margins], [Margins of Supply Chain Emission Factors]
,[Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] NOT LIKE '%farming%'
AND [2017 NAICS Title] NOT LIKE '%mining%' 
AND [2017 NAICS Title] NOT LIKE '%waste%' 
AND [2017 NAICS Title] NOT LIKE '%manufacturing%'
AND [2017 NAICS Title] NOT LIKE '%mill%'
AND [2017 NAICS Title] NOT LIKE '%production%'
AND [2017 NAICS Title] NOT LIKE '%transport%'
ORDER BY 4 desc


--view of total kg of CO2/USD from each category

CREATE VIEW TotalCO2FromEach as
SELECT 'All' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
UNION
SELECT 'Farming' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%farming%'
UNION
SELECT 'Mining' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%mining%'
UNION
SELECT 'Waste' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%waste%'
UNION
SELECT 'Manufacturing' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%manufacturing%'
UNION
SELECT 'Milling' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%mill%'
UNION
SELECT 'Production' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%production%'
UNION
SELECT 'Transportation' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%transport%'
UNION
SELECT 'Other' as title, SUM([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, SUM([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, SUM([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] NOT LIKE '%farming%'
AND [2017 NAICS Title] NOT LIKE '%mining%' 
AND [2017 NAICS Title] NOT LIKE '%waste%' 
AND [2017 NAICS Title] NOT LIKE '%manufacturing%'
AND [2017 NAICS Title] NOT LIKE '%mill%'
AND [2017 NAICS Title] NOT LIKE '%production%'
AND [2017 NAICS Title] NOT LIKE '%transport%'
--ORDER BY 4 DESC

SELECT * 
FROM SupplyChainGHG..TotalCO2FromEach


--average kg of CO2/USD from each category

CREATE VIEW AverageCO2FromEach as
SELECT 'All' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
UNION
SELECT 'Farming' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%farming%'
UNION
SELECT 'Mining' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%mining%'
UNION
SELECT 'Waste' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%waste%'
UNION
SELECT 'Manufacturing' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%manufacturing%'
UNION
SELECT 'Milling' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%mill%'
UNION
SELECT 'Production' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%production%'
UNION
SELECT 'Transport' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] LIKE '%transport%'
UNION
SELECT 'Other' as title, AVG([Supply Chain Emission Factors without Margins]) as [Supply Chain Emission Factors without Margins]
, AVG([Margins of Supply Chain Emission Factors]) as [Margins of Supply Chain Emission Factors]
, AVG([Supply Chain Emission Factors with Margins]) as [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..SupplyChainGHG
WHERE [2017 NAICS Title] NOT LIKE '%farming%'
AND [2017 NAICS Title] NOT LIKE '%mining%' 
AND [2017 NAICS Title] NOT LIKE '%waste%' 
AND [2017 NAICS Title] NOT LIKE '%manufacturing%'
AND [2017 NAICS Title] NOT LIKE '%mill%'
AND [2017 NAICS Title] NOT LIKE '%production%'
AND [2017 NAICS Title] NOT LIKE '%transport%'
--ORDER BY 4 DESC

SELECT *
FROM SupplyChainGHG..AverageCO2FromEach


--total and average kg of CO2/USD with margins

SELECT tot.[Supply Chain Emission Factors with Margins] as 'Total kg of CO2/USD'
, avg.[Supply Chain Emission Factors with Margins] as 'Average kg of CO2/USD'
FROM SupplyChainGHG..TotalCO2FromEach as tot
JOIN SupplyChainGHG..AverageCO2FromEach as avg
on tot.title = avg.title
WHERE tot.title LIKE '%all%'



--total kg of CO2/USD with margins from each category

SELECT title, [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..TotalCO2FromEach
WHERE title NOT LIKE '%all%'
ORDER BY 2 desc


--average kg of CO2/USD with margins from each category

SELECT title, [Supply Chain Emission Factors with Margins]
FROM SupplyChainGHG..AverageCO2FromEach
WHERE title NOT LIKE '%all%'
ORDER BY 2 desc