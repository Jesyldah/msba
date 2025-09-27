SET search_path TO boston;

--- 1. Which districts report the highest number of crime incidents?
SELECT d.district_code, d.district_name, COUNT(*) AS total_crimes
FROM incident i
JOIN district d ON i.district_code = d.district_code
GROUP BY d.district_name, d.district_code
ORDER BY total_crimes DESC;

--- 2. Top Crime-Prone Streets
SELECT l.street, COUNT(*) AS crime_count
FROM incident i
JOIN location l ON i.location_id = l.location_id
GROUP BY l.street
ORDER BY crime_count DESC
LIMIT 10;

--- 3. Which districts experience the most shooting incidents?
SELECT d.district_code, COUNT(*) AS shootings
FROM incident i
JOIN district d ON i.district_code = d.district_code
WHERE i.shooting = 1
GROUP BY d.district_code
ORDER BY shootings DESC;

--- 4. Which day of the week sees the most crime?
SELECT trim(day_of_week) as day, COUNT(*) AS total_crimes
FROM incident
GROUP BY day
ORDER BY total_crimes DESC;

--- 5. Which season has the highest number of crimes in Boston?
SELECT season_of_the_year as season,SUM(total_crimes) AS total_crimes 
from
(SELECT 
    CASE 
        WHEN i.month BETWEEN 3 AND 5 THEN 'Spring'
        WHEN i.month BETWEEN 6 AND 8 THEN 'Summer'
        WHEN i.month BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Winter'
    END AS season_of_the_year,
    COUNT(*) AS total_crimes
FROM boston.incident i
GROUP BY month
ORDER BY total_crimes DESC)
GROUP BY season
ORDER BY total_crimes DESC;

--- 6. How has overall crime volume changed year over year?
SELECT year, COUNT(*) AS total_incidents
FROM incident
GROUP BY year
ORDER BY year;

--- 7. At what hours do most crimes occur?
SELECT 
    CASE 
        WHEN i.hour BETWEEN 6 AND 11 THEN 'Morning'
        WHEN i.hour BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN i.hour BETWEEN 18 AND 23 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,
    COUNT(*) AS total_crimes
FROM incident i
GROUP BY time_of_day
ORDER BY total_crimes DESC;

--- 8. Which streets have recurring incidents of the same crime type?
SELECT street, offense_description, COUNT(*) AS occurrences
FROM incident
JOIN offense USING(offense_code)
JOIN location USING(location_id)
GROUP BY street, offense_description
HAVING COUNT(*) > 5
ORDER BY occurrences DESC;

--- 9. What are the most frequently reported offense types?
SELECT offense_description, COUNT(*) AS frequency
FROM incident
JOIN offense USING(offense_code)
GROUP BY offense_description
ORDER BY frequency DESC
limit 10;

--- 10. Annual Trends in Shooting Incidents
SELECT year, COUNT(*) AS total
FROM incident
WHERE 
incident.shooting = 1
GROUP BY year
ORDER BY year;
