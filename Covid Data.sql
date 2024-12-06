SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 3,4


SELECT *
FROM PortfolioProject..CovidVaccinations
WHERE continent is not null
ORDER BY 3,4


--select data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2


--looking at total cases vs total deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
and location LIKE '%states%'
ORDER BY 1,2


--looking at total cases vs population

SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
WHERE continent is not null
ORDER BY 1,2


--looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentInfected
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY 4 desc


--showing countries with highest death count per population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 2 desc


--LET'S BREAK THINGS DOWN BY CONTINENT


--looking at total cases vs total deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is null
--and location LIKE '%states%'
ORDER BY 1,2


--looking at total cases vs population

SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
WHERE continent is null
ORDER BY 1,2


--looking at continents with highest infection rate compared to population

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentInfected
FROM PortfolioProject..CovidDeaths
WHERE continent is null
GROUP BY location, population
ORDER BY 4 desc


--showing continents with highest death count per population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is null
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY 2 desc


--GLOBAL NUMBERS

SELECT date, SUM(new_cases) as TotalCases, SUM(CAST(new_deaths as int)) as TotalDeaths, SUM((CONVERT(float, new_deaths))) 
/ SUM(NULLIF(CONVERT(float, new_cases), 0)) *100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is null
and location LIKE '%world%'
GROUP BY date
ORDER BY 1,2


SELECT SUM(new_cases) as TotalCases, SUM(CAST(new_deaths as int)) as TotalDeaths, SUM((CONVERT(float, new_deaths))) 
/ SUM(NULLIF(CONVERT(float, new_cases), 0)) *100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is null
and location LIKE '%world%'
--GROUP BY date
ORDER BY 1,2


--looking at total population vs vaccintations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date)
 as RolingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3



--USE CTE

with PopvsVac (continent, location, date, population, new_vaccinations, RolingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date)
 as RolingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3
)
SELECT *, (RolingPeopleVaccinated/population)*100 as PercentVaccinated
FROM PopvsVac


--TEMP TABLE

DROP table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255), 
location nvarchar(255), 
date datetime, 
population numeric, 
new_vaccinations numeric, 
RolingPeopleVaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date)
 as RolingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	and dea.date = vac.date
--WHERE dea.continent is not null
--ORDER BY 2,3

SELECT *, (RolingPeopleVaccinated/population)*100 as PercentVaccinated
FROM #PercentPopulationVaccinated
WHERE continent is not null


--looking at PercentPopulationVaccinated vs new_cases

SELECT dea.location, dea.date, (vac.RolingPeopleVaccinated/vac.population)*100 as PercentPopulationVaccinated, dea.new_cases
FROM PortfolioProject..CovidDeaths dea
JOIN #PercentPopulationVaccinated vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
and dea.location like '%states%' 
ORDER BY 1,2


--looking at PercentPopulationVaccinated vs new_deaths

SELECT dea.location, dea.date, (vac.RolingPeopleVaccinated/vac.population)*100 as PercentPopulationVaccinated, dea.new_deaths
FROM PortfolioProject..CovidDeaths dea
JOIN #PercentPopulationVaccinated vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
and dea.location like '%states%' 
ORDER BY 1,2


--looking at PercentPopulationVaccinated vs new_cases (world)

SELECT dea.location, dea.date, (vac.RolingPeopleVaccinated/vac.population)*100 as PercentPopulationVaccinated, dea.new_cases
FROM PortfolioProject..CovidDeaths dea
JOIN #PercentPopulationVaccinated vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is null
and dea.location like '%world%' 
ORDER BY 1,2


--looking at PercentPopulationVaccinated vs new_deaths (world)

SELECT dea.location, dea.date, (vac.RolingPeopleVaccinated/vac.population)*100 as PercentPopulationVaccinated, dea.new_deaths
FROM PortfolioProject..CovidDeaths dea
JOIN #PercentPopulationVaccinated vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is null
and dea.location like '%world%' 
ORDER BY 1,2



--creating views to store data for later visualizations

use PortfolioProject
go

create view PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date)
 as RolingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3


SELECT * 
FROM PortfolioProject..PercentPopulationVaccinated
ORDER BY 2,3



create view PercPopVacvsNew_cases as
SELECT dea.location, dea.date, (vac.RolingPeopleVaccinated/vac.population)*100 as PercentPopulationVaccinated, dea.new_cases
FROM PortfolioProject..CovidDeaths dea
JOIN PercentPopulationVaccinated vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--and dea.location like '%states%' 
--ORDER BY 1,2


SELECT *
FROM PortfolioProject..PercPopVacvsNew_cases
ORDER BY 1,2



create view PercPopVacvsNew_Deaths as
SELECT dea.location, dea.date, (vac.RolingPeopleVaccinated/vac.population)*100 as PercentPopulationVaccinated, dea.new_deaths
FROM PortfolioProject..CovidDeaths dea
JOIN PercentPopulationVaccinated vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--and dea.location like '%states%' 
--ORDER BY 1,2


SELECT *
FROM PortfolioProject..PercPopVacvsNew_Deaths
ORDER BY 1,2


create view	DeathsPerContinent as
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is null
GROUP BY location
--ORDER BY 2 desc


SELECT *
FROM PortfolioProject..DeathsPerContinent
ORDER BY 2 desc


create view	DeathsPerCountry as
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
--ORDER BY 2 desc


SELECT *
FROM PortfolioProject..DeathsPerCountry
ORDER BY 2 desc