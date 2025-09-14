CREATE TABLE movie_db.publication (name VARCHAR(255) PRIMARY KEY, avatar VARCHAR(21));
CREATE TABLE movie_db.reviewer (name VARCHAR(255) PRIMARY KEY, avatar VARCHAR(255), publication VARCHAR(255), FOREIGN KEY (publication) REFERENCES publication(name) ON DELETE CASCADE);
CREATE TABLE movie_db.moviereview (title VARCHAR(255) PRIMARY KEY, `release` VARCHAR(255), score INTEGER, reviewer VARCHAR(255), FOREIGN KEY (reviewer) REFERENCES reviewer(name) ON DELETE CASCADE);

INSERT INTO movie_db.publication (name, avatar) VALUES ('The Daily Reviewer', 'glyphicon-eye-open');
INSERT INTO movie_db.publication (name, avatar) VALUES ('International Movie Critic', 'glyphicon-fire');
INSERT INTO movie_db.publication (name, avatar) VALUES ('MoviesNow', 'glyphicon-time');
INSERT INTO movie_db.publication (name, avatar) VALUES ('MyNextReview', 'glyphicon-record');
INSERT INTO movie_db.publication (name, avatar) VALUES ('Movies n\' Games', 'glyphicon-heart-empty');
INSERT INTO movie_db.publication (name, avatar) VALUES ('TheOne', 'glyphicon-globe');
INSERT INTO movie_db.publication (name, avatar) VALUES ('ComicBookHero.com', 'glyphicon-flash');

INSERT INTO movie_db.reviewer (name, avatar, publication)
VALUES 
  ('Robert Smith',  'https://i.pravatar.cc/128?img=1', 'The Daily Reviewer'),
  ('Chris Harris',  'https://i.pravatar.cc/128?img=2', 'International Movie Critic'),
  ('Janet Garcia',  'https://i.pravatar.cc/128?img=3', 'MoviesNow'),
  ('Andrew West',   'https://i.pravatar.cc/128?img=4', 'MyNextReview'),
  ('Mindy Lee',     'https://i.pravatar.cc/128?img=17', 'Movies n\' Games'),
  ('Martin Thomas', 'https://i.pravatar.cc/128?img=18', 'TheOne'),
  ('Anthony Miller','https://i.pravatar.cc/128?img=7', 'ComicBookHero.com');


INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('Deadpool', '2016', 11, 'Robert Smith');
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('Thor: Ragnarok', '2017', 7, 'Chris Harris');
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('It', '2017', 8, 'Janet Garcia');
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('Dunkirk', '2017', 8, 'Andrew West');
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('Logan', '2017', 8, 'Mindy Lee');
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('Batman V Superman', '2016', 6, 'Martin Thomas');
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer) VALUES ('Mad Max: Fury Road', '2015', 6, 'Anthony Miller');
