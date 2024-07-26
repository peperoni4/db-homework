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
        'id', d.id,
        'first_name', d.first_name,
        'last_name', d.last_name,
        'photo', (
            SELECT json_build_object(
                'id', pf.id,
                'name', pf.name,
                'mime', pf.mime,
                'key', pf.key,
                'url', pf.url
            )
            FROM file pf
            WHERE pf.id = d.primary_photo_id
        )
    ) AS director,
    (SELECT json_agg(json_build_object(
        'id', a.id,
        'first_name', a.first_name,
        'last_name', a.last_name,
        'photo', (
            SELECT json_build_object(
                'id', af.id,
                'name', af.name,
                'mime', af.mime,
                'key', af.key,
                'url', af.url
            )
            FROM file af
            WHERE af.id = a.primary_photo_id
        )
    ))
    FROM movie_character mc
    JOIN character c ON mc.character_id = c.id
    JOIN person a ON c.actor_id = a.id
    WHERE mc.movie_id = m.id) AS actors,
    (SELECT json_agg(json_build_object(
        'id', g.id,
        'name', g.name
    ))
    FROM movie_genre mg
    JOIN genre g ON mg.genre_id = g.id
    WHERE mg.movie_id = m.id) AS genres
FROM movie m
JOIN file f ON m.poster_id = f.id
JOIN person d ON d.id = m.director_id
WHERE m.id = 1;
