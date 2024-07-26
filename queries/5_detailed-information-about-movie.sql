-- 5. Select detailed information about movies that meet criteria below
SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object(
        'id', f.id,
        'name', f.name,
        'mime', f.mime,
        'key', f.key,
        'url', f.url,
        'created_at', f.created_at,
        'updated_at', f.updated_at
    ) AS poster,
    json_build_object(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name
    ) AS director
FROM movie as m
INNER JOIN file as f
    ON m.poster_id = f.id
INNER JOIN person as p
    ON p.id = m.director_id
INNER JOIN movie_genre as mg
    ON m.id = mg.movie_id
INNER JOIN genre as g
    ON g.id = mg.genre_id
WHERE m.country_id = 3 and
    DATE_PART('year', m.release_date) >= 2022 and
    (m.duration > 60 * 2 + 15) and
    g.name IN ('Action', 'Drama')
GROUP BY
    m.id, m.title, m.release_date, m.duration, m.description,
    f.id, f.name, f.mime, f.key, f.url, f.created_at, f.updated_at,
    p.id, p.first_name, p.last_name;
