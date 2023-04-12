SELECT *
FROM PortfolioProject..[Covid-Deaths]
WHERE continent IS NOT NULL
ORDER BY 3,4



--SELECT *
--FROM PortfolioProject..Covid_vaccinations
--ORDER BY 3,4

--Select Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..[Covid-Deaths]
WHERE continent IS NOT NULL
ORDER BY 1,2


-- LOOKING AT TOTAL CASES VS DEATHS
--shows liklihood of dying if you contract covid in your country 
SELECT Location, date, total_cases, total_deaths,(total_deaths / total_cases)*100 AS DeathPercentage
FROM PortfolioProject..[Covid-Deaths]
WHERE location like '%states%' AND continent IS NOT NULL
ORDER BY 1,2



--convert column datatype into float to be able to make caculations 

ALTER TABLE [Covid-Deaths]
ALTER COLUMN  total_cases float;


--looking at total cases vs population
-- shows what percentage of population got covid 

SELECT Location, date, population,total_cases ,(total_cases / population)*100 AS DeathPercentage
FROM PortfolioProject..[Covid-Deaths]
WHERE location like '%ypt%'
ORDER BY 1,2


--looking at countries highest infection rate compared to population 

SELECT Location,population,MAX(total_cases) AS HighestInfectionCount ,MAX((total_cases / population))*100 AS PercentPopulationInfected
FROM PortfolioProject..[Covid-Deaths]
GROUP BY Location, population
ORDER BY PercentPopulationInfected desc

--LETS BREAK THINGS DOWN BY CONTIENT

SELECT continent, MAX(Total_deaths) as totalDeathCount
FROM PortfolioProject..[Covid-Deaths]
--WHERE continent IS  NULL
GROUP BY continent
ORDER BY totalDeathCount desc



--GLOBAL NUMBERS

SELECT  SUM(new_cases) as Total_Cases, SUM(new_deaths) as Total_Deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..[Covid-Deaths]
--WHERE location like '%ypt%'
WHERE continent IS NOT NULL AND new_cases <> 0 AND new_deaths <> 0
ORDER BY 1,2

--
ALTER TABLE [Covid_vaccinations]
ALTER COLUMN  new_vaccinations int;
--looking at total population vs vaccination 


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM PortfolioProject..[Covid-Deaths] dea
JOIN PortfolioProject..Covid_vaccinations vac
    ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


-- USE CTE 

WITH Popvsvac (Continet, Location, date, population ,new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM PortfolioProject..[Covid-Deaths] dea
JOIN PortfolioProject..Covid_vaccinations vac
    ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM Popvsvac



-- Creating view to store data later for visualization

CREATE VIEW Popvsvac AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM PortfolioProject..[Covid-Deaths] dea
JOIN PortfolioProject..Covid_vaccinations vac
    ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3


SELECT * 
FROM Popvsvac