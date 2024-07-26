-- FILE TABLE
CREATE TABLE file (
    id                  serial PRIMARY KEY,
    name                varchar(200) NOT NULL,
    mime                varchar(100) NOT NULL,
    key                 varchar(200) NOT NULL,
    url                 varchar(200) NOT NULL,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp
);

-- USER TABLE
CREATE TABLE users (
    id                  serial PRIMARY KEY,
    username            varchar(100) NOT NULL UNIQUE,
    first_name          varchar(100),
    last_name           varchar(100),
    password            varchar(128) NOT NULL,
    email               varchar(320) NOT NULL UNIQUE,
    file_id             int,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp,

    FOREIGN KEY (file_id) REFERENCES file(id)
);

-- COUNTRY TABLE
CREATE TABLE country (
    id                  serial PRIMARY KEY,
    name                varchar(100) NOT NULL UNIQUE,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp
);

-- GENDER ENUM
CREATE TYPE gender_type AS ENUM ('male', 'female');

-- PERSON TABLE
CREATE TABLE person (
    id                  serial PRIMARY KEY,
    first_name          varchar(100) NOT NULL,
    last_name           varchar(100) NOT NULL,
    biography           text,
    birthdate           date,
    gender              gender_type NOT NULL,
    primary_photo_id    int NOT NULL,
    country_id          int NOT NULL,
    created_at          timestamp,
    updated_at          timestamp,

    FOREIGN KEY (country_id) REFERENCES country(id),
    FOREIGN KEY (primary_photo_id) REFERENCES file(id)
);

-- PERSON_FILE TABLE
CREATE TABLE person_file (
    file_id             int,
    person_id           int,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp,

    PRIMARY KEY (file_id, person_id),
    FOREIGN KEY (file_id) REFERENCES file(id),
    FOREIGN KEY (person_id) REFERENCES person(id)
);

-- MOVIE TABLE
CREATE TABLE movie (
    id                  serial PRIMARY KEY,
    title               varchar(100) NOT NULL,
    description         text,
    release_date        date NOT NULL,
    duration            int,
    budget              numeric(15,2),
    director_id         int NOT NULL,
    country_id          int NOT NULL,
    poster_id           int NOT NULL,
    created_at          timestamp,
    updated_at          timestamp,

    FOREIGN KEY (director_id) REFERENCES person(id),
    FOREIGN KEY (country_id) REFERENCES country(id),
    FOREIGN KEY (poster_id) REFERENCES file(id)
);

-- PERSON_MOVIE TABLE
CREATE TABLE person_movie (
    movie_id            int,
    person_id           int,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp,

    PRIMARY KEY (movie_id, person_id),
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    FOREIGN KEY (person_id) REFERENCES person(id)
);

-- GENRE TABLE
CREATE TABLE genre (
    id                  serial PRIMARY KEY,
    name                varchar(100) NOT NULL UNIQUE,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp
);

-- MOVIE_GENRE TABLE
CREATE TABLE movie_genre (
    movie_id            int,
    genre_id            int,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp,

    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);

-- FAVORITE MOVIES TABLE
CREATE TABLE user_movie (
    user_id             int,
    movie_id            int,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp,

    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

-- ROLE ENUM
CREATE TYPE role_type AS ENUM ('leading', 'supporting', 'background');

-- CHARACTER TABLE
CREATE TABLE character (
    id                  serial PRIMARY KEY,
    name                varchar(100) NOT NULL,
    description         text,
    role                role_type NOT NULL,
    actor_id            int,
    created_at          timestamp,
    updated_at          timestamp,

    FOREIGN KEY (actor_id) REFERENCES person(id)
);

-- MOVIE CHARACTER TABLE
CREATE TABLE movie_character (
    movie_id            int,
    character_id        int,
    created_at          timestamp DEFAULT current_timestamp,
    updated_at          timestamp,

    PRIMARY KEY (movie_id, character_id),
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    FOREIGN KEY (character_id) REFERENCES character(id)
);

-- TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = current_timestamp;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- UPDATE_AT TRIGGER FOR ALL ENTITIES

-- FILE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_file
BEFORE UPDATE ON file
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- USER UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_users
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- MOVIE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_movie
BEFORE UPDATE ON movie
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- PERSON UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_person
BEFORE UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- CHARACTER UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_character
BEFORE UPDATE ON character
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- COUNTRY UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_country
BEFORE UPDATE ON country
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- GENRE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_genre
BEFORE UPDATE ON genre
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- MOVIE_GENRE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_movie_genre
BEFORE UPDATE ON movie_genre
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- MOVIE_CHARACTER UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_movie_character
BEFORE UPDATE ON movie_character
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- USER_MOVIE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_user_movie
BEFORE UPDATE ON user_movie
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- PERSON_FILE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_person_file
BEFORE UPDATE ON person_file
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- PERSON_MOVIE UPDATED_AT TRIGGER
CREATE TRIGGER set_timestamp_person_movie
BEFORE UPDATE ON person_movie
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
