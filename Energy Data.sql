SELECT *
FROM EnergyPortPro..non_renewable
ORDER BY 2,3


SELECT *
FROM EnergyPortPro..renewable
ORDER BY 2,3


--looking at countries with highest electricity_demand

SELECT country, MAX(electricity_demand) as HighestElectricityDemand
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
GROUP BY country
ORDER BY 2 DESC


--looking at gdp vs electricity_demand

SELECT country, MAX(gdp) as gdp, MAX(electricity_demand) as HighestElectricityDemand
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
GROUP BY country
ORDER BY 3 DESC


--looking at population vs electricity_demand

SELECT country, MAX(population) as population, MAX(electricity_demand) as HighestElectricityDemand
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
GROUP BY country
ORDER BY 3 DESC


--looking at electricity generation vs greenhouse gas emissions

SELECT country, year, electricity_generation, greenhouse_gas_emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
ORDER BY 1,2


--looking at what percent of electricity is generated by fossil fuels

SELECT country, year, electricity_generation, fossil_share_elec as fossil_fuels
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
ORDER BY 1,2


--looking at what percent of electricity is generated by renewables 

SELECT non.country, non.year, non.electricity_generation, ren.renewables_share_elec as renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NOT NULL
--AND non.country LIKE '%states%'
--AND non.country NOT LIKE '%virgin%'
ORDER BY 1,2


--what countries have the highest percent of renewable energy generation in 2022

SELECT country, MAX(renewables_share_elec) as percent_renewable
FROM EnergyPortPro..renewable
WHERE iso_code IS NOT NULL
AND year = '2022'
GROUP BY country
ORDER BY 2 desc


--types of electricity generation per country (percent of total)

SELECT non.country, non.year, non.electricity_generation, non.biofuel_share_elec as biofuel
, non.coal_share_elec as coal, non.gas_share_elec as gas, non.nuclear_share_elec as nuclear
, non.oil_share_elec as oil, ren.solar_share_elec as solar, ren.wind_share_elec as wind
, hydro_share_elec as hydro, ren.other_renewables_share_elec as other_renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NOT NULL
--AND non.country LIKE '%states%'
--AND non.country NOT LIKE '%virgin%'
ORDER BY 1,2


--types of electricity generation per country (terawatt hours)

SELECT non.country, non.year, non.electricity_generation, non.biofuel_electricity as biofuel
, non.coal_electricity as coal, non.gas_electricity as gas, non.nuclear_electricity as nuclear
, non.oil_electricity as oil, ren.solar_electricity as solar, ren.wind_electricity as wind
, hydro_electricity as hydro, ren.other_renewable_electricity as other_renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NOT NULL
--AND non.country LIKE '%states%'
--AND non.country NOT LIKE '%virgin%'
ORDER BY 1,2



--how much greenhouse gas emissions has each country put out total

SELECT country, SUM(greenhouse_gas_emissions) as Total_GHG_Emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
GROUP BY country
ORDER BY 2 desc


--looking at greenhouse gas emissions per country

SELECT country, year, greenhouse_gas_emissions, SUM(greenhouse_gas_emissions) OVER (partition by country order by country, year
) as Total_GHG_Emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
ORDER BY 1,2


--which countries generate the most electricity in 2022

SELECT country, MAX(electricity_generation) as electricity_generation
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
AND year = '2022'
GROUP BY country
ORDER BY 2 desc


--electricity generation vs electricity demand in 2022

SELECT country, MAX(electricity_generation) as electricity_generation, MAX(electricity_demand) as electricity_demand
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
AND year = '2022'
GROUP BY country
ORDER BY 2 desc


--how much electricity has each country generated total

SELECT country, SUM(electricity_generation) as Total_Electricity_Generated
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
GROUP BY country
ORDER BY 2 desc


--WORLD DATA


--how much electricity was generated each year

SELECT non.year, non.electricity_generation
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NULL
AND non.country LIKE '%world%'
ORDER BY 1


--how much electricity was generated by renewables each year

SELECT non.year, ren.renewables_electricity
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NULL
AND non.country LIKE '%world%'
ORDER BY 1


--how much electricity was generated by fossil fuels each year

SELECT non.year, non.fossil_electricity
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NULL
AND non.country LIKE '%world%'
ORDER BY 1


--types of electricity generation in the world (percent of total)

SELECT non.country, non.year, non.electricity_generation, non.biofuel_share_elec as biofuel
, non.coal_share_elec as coal, non.gas_share_elec as gas, non.nuclear_share_elec as nuclear
, non.oil_share_elec as oil, ren.solar_share_elec as solar, ren.wind_share_elec as wind
, hydro_share_elec as hydro, ren.other_renewables_share_elec as other_renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NULL
AND non.country LIKE '%world%'
ORDER BY 1,2


--types of electricity generation in the world (terawatt hours)

SELECT non.country, non.year, non.electricity_generation, non.biofuel_electricity as biofuel
, non.coal_electricity as coal, non.gas_electricity as gas, non.nuclear_electricity as nuclear
, non.oil_electricity as oil, ren.solar_electricity as solar, ren.wind_electricity as wind
, hydro_electricity as hydro, ren.other_renewable_electricity as other_renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NULL
AND non.country LIKE '%world%'
ORDER BY 1,2


--looking at world population vs electricity demand

SELECT country, year, population, electricity_demand
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NULL
AND country LIKE '%world%'
ORDER BY 2


--looking at greenhouse gas emissions in the world

SELECT year, greenhouse_gas_emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NULL
AND country LIKE '%world%'
ORDER BY 1


--looking at what percent of electricity in the world is generated by fossil fuels

SELECT country, year, electricity_generation, fossil_share_elec as percent_fossil
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NULL
AND country LIKE '%world%'
ORDER BY 2


--looking at what percent of electricity in the world is generated by renewables 

SELECT non.country, non.year, non.electricity_generation, ren.renewables_share_elec as percent_renewable
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NULL
AND non.country LIKE '%world%'
ORDER BY 2


--looking at total electricity generation vs total ghg emissions

SELECT SUM(electricity_generation) as Total_Electricity_Generation, SUM(greenhouse_gas_emissions) as Total_GHG_Emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NULL
AND country LIKE '%world%'
GROUP BY country


--views

use EnergyPortPro
go

CREATE VIEW ElectricityGenerationPerCountry_twh as
SELECT non.country, non.year, non.electricity_generation, non.biofuel_electricity as biofuel
, non.coal_electricity as coal, non.gas_electricity as gas, non.nuclear_electricity as nuclear
, non.oil_electricity as oil, ren.solar_electricity as solar, ren.wind_electricity as wind
, hydro_electricity as hydro, ren.other_renewable_electricity as other_renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NOT NULL
--AND non.country LIKE '%states%'
--AND non.country NOT LIKE '%virgin%'
--ORDER BY 1,2


CREATE VIEW ElectricityGenerationPerCountry_perc as
SELECT non.country, non.year, non.electricity_generation, non.biofuel_share_elec as biofuel
, non.coal_share_elec as coal, non.gas_share_elec as gas, non.nuclear_share_elec as nuclear
, non.oil_share_elec as oil, ren.solar_share_elec as solar, ren.wind_share_elec as wind
, hydro_share_elec as hydro, ren.other_renewables_share_elec as other_renewables
FROM EnergyPortPro..non_renewable non
JOIN EnergyPortPro..renewable ren
	ON non.country = ren.country 
	and non.year = ren.year
WHERE non.iso_code IS NOT NULL
--AND non.country LIKE '%states%'
--AND non.country NOT LIKE '%virgin%'
--ORDER BY 1,2



CREATE VIEW CountryElectricityGeneration as
SELECT country, MAX(electricity_generation) as electricity_generation
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
AND year = '2022'
GROUP BY country
--ORDER BY 2 desc


CREATE VIEW TotalGHGEmissions as
SELECT country, SUM(greenhouse_gas_emissions) as Total_GHG_Emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
GROUP BY country
--ORDER BY 2 desc


CREATE VIEW RollingGHGEmissions as
SELECT country, year, greenhouse_gas_emissions, SUM(greenhouse_gas_emissions) OVER (partition by country order by country, year
) as Total_GHG_Emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
--ORDER BY 1,2


CREATE VIEW ElectGenVSGHGEmissions as
SELECT country, year, electricity_generation, greenhouse_gas_emissions
FROM EnergyPortPro..non_renewable
WHERE iso_code IS NOT NULL
--AND country LIKE '%states%'
--AND country NOT LIKE '%virgin%'
--ORDER BY 1,2



