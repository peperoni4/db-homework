-- 3. Retrieve a list of all users along with their favorite movbies as array of identifiers
SELECT
    u.id, u.username, array_agg(fav.movie_id)
FROM users as u
INNER JOIN user_movie fav
    ON u.id = fav.user_id
GROUP BY u.id, u.username;
