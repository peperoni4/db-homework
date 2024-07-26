-- 1. list of actors along with the total budget
SELECT p.id, p.first_name, p.last_name, sum(m.budget)
FROM person as p
INNER JOIN person_movie pm
    ON pm.person_id = p.id
INNER JOIN movie m
    ON m.id = pm.movie_id
GROUP BY p.id, p.first_name, p.last_name;
