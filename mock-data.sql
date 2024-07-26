-- Insert mock data into the country table
INSERT INTO country (name, created_at, updated_at) VALUES
('United States', current_timestamp, current_timestamp),
('United Kingdom', current_timestamp, current_timestamp),
('Canada', current_timestamp, current_timestamp);

-- Insert mock data into the file table
INSERT INTO file (name, mime, key, url, created_at, updated_at) VALUES
('poster1.jpg', 'image/jpeg', 'poster1', 'http://example.com/poster1.jpg', current_timestamp, current_timestamp),
('poster2.jpg', 'image/jpeg', 'poster2', 'http://example.com/poster2.jpg', current_timestamp, current_timestamp),
('photo1.jpg', 'image/jpeg', 'photo1', 'http://example.com/photo1.jpg', current_timestamp, current_timestamp);

-- Insert mock data into the users table
INSERT INTO users (username, first_name, last_name, password, email, file_id, created_at, updated_at) VALUES
('john_doe', 'John', 'Doe', 'password123', 'john.doe@example.com', 1, current_timestamp, current_timestamp),
('jane_smith', 'Jane', 'Smith', 'password456', 'jane.smith@example.com', 2, current_timestamp, current_timestamp);

-- Insert mock data into the person table
INSERT INTO person (first_name, last_name, biography, birthdate, gender, primary_photo_id, country_id, created_at, updated_at) VALUES
('Steven', 'Spielberg', 'Famous director known for E.T. and Jurassic Park.', '1946-12-18', 'male', 3, 1, current_timestamp, current_timestamp),
('Emma', 'Watson', 'Actress known for Hermione Granger in Harry Potter.', '1990-04-15', 'female', 2, 2, current_timestamp, current_timestamp);

-- Insert mock data into the person_file table
INSERT INTO person_file (file_id, person_id, created_at, updated_at) VALUES
(3, 1, current_timestamp, current_timestamp);

-- Insert mock data into the movie table
INSERT INTO movie (title, description, release_date, duration, budget, director_id, country_id, poster_id, created_at, updated_at) VALUES
('Jurassic Park', 'Dinosaurs are brought back to life on a remote island.', '1993-06-11', 127, 63000000, 1, 1, 1, current_timestamp, current_timestamp),
('Harry Potter and the Sorcerer''s Stone', 'A young wizard attends a magical school.', '2001-11-16', 152, 125000000, 2, 2, 2, current_timestamp, current_timestamp);

-- Insert mock data into the person_movie table
INSERT INTO person_movie (movie_id, person_id, created_at, updated_at) VALUES
(1, 1, current_timestamp, current_timestamp),
(2, 2, current_timestamp, current_timestamp);

-- Insert mock data into the genre table
INSERT INTO genre (name, created_at, updated_at) VALUES
('Action', current_timestamp, current_timestamp),
('Drama', current_timestamp, current_timestamp),
('Adventure', current_timestamp, current_timestamp);

-- Insert mock data into the movie_genre table
INSERT INTO movie_genre (movie_id, genre_id, created_at, updated_at) VALUES
(1, 1, current_timestamp, current_timestamp),
(2, 2, current_timestamp, current_timestamp);

-- Insert mock data into the user_movie table
INSERT INTO user_movie (user_id, movie_id, created_at, updated_at) VALUES
(1, 1, current_timestamp, current_timestamp),
(2, 2, current_timestamp, current_timestamp);

-- Insert mock data into the character table
INSERT INTO character (name, description, role, actor_id, created_at, updated_at) VALUES
('Dr. Alan Grant', 'Paleontologist and main character in Jurassic Park.', 'leading', 1, current_timestamp, current_timestamp),
('Hermione Granger', 'Bright and talented witch at Hogwarts.', 'leading', 2, current_timestamp, current_timestamp);

-- Insert mock data into the movie_character table
INSERT INTO movie_character (movie_id, character_id, created_at, updated_at) VALUES
(1, 1, current_timestamp, current_timestamp),
(2, 2, current_timestamp, current_timestamp);
