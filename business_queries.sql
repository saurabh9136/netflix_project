-- Netflix Project

SELECT * FROM netflix;

-- 1. Count the number of Movies vs TV Shows
SELECT
	type,
	COUNT(*) AS shows
FROM netflix
GROUP BY type

-- 2. Find the most common rating for movies and TV shows
SELECT * FROM
(
SELECT
	type,
	rating,
	COUNT(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM netflix
GROUP BY 1,2
)
WHERE ranking = 1;

--3. List all movies released in a specific year (e.g., 2020)
	SELECT *
	FROM netflix
	WHERE  type = 'Movie' AND release_year = 2020
		
--4. Find the top 5 countries with the most content on Netflix
	SELECT 
		UNNEST(STRING_TO_ARRAY(country, ',')) AS new_country,
		COUNT(show_id) AS contents
	FROM netflix
	GROUP BY 1
	ORDER BY contents DESC
	LIMIT 5
	
--5. Identify the longest movie or TV show duration
	SELECT *
		FROM netflix
		WHERE type = 'Movie'
		AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) =
    (SELECT MAX(CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER)) FROM netflix WHERE type = 'Movie');

--6. Find content added in the last 5 years
SELECT
	*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD/YYYY') >= CURRENT_DATE - INTERVAL '5 years';

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
	SELECT * FROM netflix
	WHERE director ILIKE '%Rajiv Chilaka%'
	
--8. List all TV shows with more than 5 seasons
SELECT * FROM netflix
WHERE 
	type = 'TV Show' 
	AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 5
	
--9. Count the number of content items in each genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
	COUNT(show_id) as items
FROM netflix
GROUP BY 1
ORDER BY items DESC

--10. Find each year and the average number of content release by india
-- on netflix return top 5 years with highest avg content release.
SELECT * FROM netflix

SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
	count(*),
	ROUND((COUNT(*)::numeric / (SELECT COUNT(*) FROM netflix WHERE country ILIKE '%India%')::numeric * 100),2) AS avg_content
FROM netflix 
where
	 country ILIKE '%India%'
GROUP BY  1


--11. List all movies that are documentaries
SELECT * FROM netflix
WHERE 	
type = 'Movie' 
AND listed_in ILIKE '%Documentaries%'


--12. Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT * FROM netflix WHERE
casts ILIKE '%Salman Khan%'
AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India
SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
	COUNT(*) AS toatal_count
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in
-- the description field. Label content containing these keywords as 'Bad' and all other
-- content as 'Good'. Count how many items fall into each category.

SELECT 
	*,
	CASE 
		WHEN description ILIKE '%kill%' OR description ILIKE '%violence%'
		THEN 'Bad Film'
	ELSE 'Good Film'
	END AS category
FROM netflix;