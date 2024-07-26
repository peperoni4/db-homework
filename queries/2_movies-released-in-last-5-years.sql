-- 2. Movies released in the last 5 years with the number of actors who appeared in each movie
SELECT m.id, m.title, COUNT(pm.person_id)
FROM movie as m
INNER JOIN person_movie pm
    ON m.id = pm.movie_id
WHERE m.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY m.id, m.title;
