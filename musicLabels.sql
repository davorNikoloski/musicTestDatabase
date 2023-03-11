CREATE DATABASE music_library;
USE music_library;

#CREATING TABLES
CREATE TABLE album(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL,
release_year INT,
PRIMARY KEY(id)
);

CREATE TABLE song(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL,
release_date DATE,
album_id INT NOT NULL,
FOREIGN KEY(album_id) REFERENCES album(id),
PRIMARY KEY(id)
);

ALTER TABLE song
MODIFY COLUMN album_id INT NULL;

CREATE TABLE artist(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL,
start_date DATE,
album_id INT NOT NULL,
FOREIGN KEY(album_id) REFERENCES album(id),
PRIMARY KEY(id)
);
SHOW TABLES;

ALTER TABLE song
ADD COLUMN duration TIME AFTER name;

SELECT * FROM song;
#FILLING TABLES
ALTER TABLE artist
CHANGE start_date start_year INT;

INSERT INTO album(name, release_year)
VALUES('The Dark Side of the Moon', 1973),
('Random Access Memories', 2013),
("Sgt. Pepper's Lonely Hearts Club Band", 1967);
SELECT * FROM album;

INSERT INTO song(name, duration, release_year, album_id)
VALUES('Breathe', TIME('00:02:49'), 1973, 1),
('Time', TIME('00:06:53'), 1974, 1);
SELECT * FROM song;

INSERT INTO song(name, duration, release_year, album_id)
VALUES('Money', TIME('0:6:12'), 1973, 1),
('Us and Them', TIME('0:7:49'), 1974, 1),
('Brain Damage', TIME('0:3:46'), 1972, 1),
('Contact', TIME('0:6:21'), 2013, 2),
('Instant Crush', TIME('0:5:37'), 2013, 2),
('Give Life Back to Music', TIME('0:4:34'), 2014, 2),
('Touch', TIME('0:8:19'), 2013, 2),
('Lucy in the Sky with Diamonds', TIME('0:3:27'), 1967, 3),
('A Day in the Life', TIME('0:5:38'), 1967, 3),
('Fixing a Hole', TIME('0:2:36'), 1967, 2);
INSERT INTO song(name, duration, release_year)
VALUES('Strawberry Fields Forever', TIME('0:4:7'), 1967);
SELECT * FROM song;
UPDATE song SET album_id = 3 WHERE name = 'Fixing a Hole';

INSERT INTO artist(name, start_year, album_id)
VALUES('The Beatles', 1960, 3),
('Daft Punk', 1993, 2),
('Pink Floyd', 1964, 1);
SELECT * FROM artist;

#JOINS
	#Number of songs for each band
SELECT artist.name as Artist_Name, album.name as Album_Name, COUNT(song.id) as Num_of_Songs
FROM artist
INNER JOIN album
ON artist.album_id = album.id
INNER JOIN song
ON song.album_id = album.id
WHERE song.album_id = album.id
GROUP BY artist.name;

	#Length of every album
SELECT album.name as Album_Name, DATE_FORMAT(SEC_TO_TIME(SUM(60 * MINUTE(duration) + SECOND(duration))) ,'%i:%s')  as Album_Duration
FROM album
JOIN song
ON album.id = song.album_id
GROUP BY album.name;

	#All data
SELECT * FROM artist
JOIN album
ON artist.album_id = album.id
JOIN song
ON song.album_id = album.id
;