-- 4. Select directors along with the average budget of the movies they have directed
SELECT m.director_id, (p.first_name || ' ' || p.last_name) as DirectorName, AVG(m.budget) as AverageBudget
FROM movie as m
INNER JOIN person as p
    ON m.director_id = p.id
GROUP BY m.director_id, DirectorName;
