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

ALTER TABLE artist
MODIFY COLUMN modifiedDate TIMESTAMP NOT NULL;
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

SET FOREIGN_KEY_CHECKS=0;  
SELECT * FROM album;
TRUNCATE TABLE album ;
SET FOREIGN_KEY_CHECKS=1;  

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

#-------------------------------------------

#ALTER
ALTER TABLE artist
ADD COLUMN createdDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER start_year;
ALTER TABLE artist
ADD COLUMN modifiedDate TIMESTAMP NOT NULL AFTER createdDate;
ALTER TABLE artist
ADD COLUMN createdby VARCHAR(255) NOT NULL AFTER modifiedDate;
ALTER TABLE song
ADD COLUMN createdby VARCHAR(255) NOT NULL AFTER modifiedDate;
ALTER TABLE album
ADD COLUMN description VARCHAR(255) NOT NULL AFTER createdBy;
ALTER TABLE artist
MODIFY COLUMN createdBy VARCHAR(255) NULL;

#CREATE 2 MORE TABLES

CREATE TABLE subscriber(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL,
subscribtionStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
subscribtionEnd TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
addedBy VARCHAR(255) NOT NULL,
album_id INT,
song_id INT,
FOREIGN KEY(album_id) REFERENCES album(id),
FOREIGN KEY(song_id) REFERENCES song(id),
PRIMARY KEY(id)
);

ALTER TABLE subscriber
MODIFY COLUMN addedBy VARCHAR(255) NULL;
ALTER TABLE subscriber
MODIFY COLUMN subscribtionEnd TIMESTAMP NOT NULL;

CREATE TABLE noOrder(
id INT AUTO_INCREMENT NOT NULL,
orderStart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
orderModified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
addedBy VARCHAR(255) NOT NULL,
price BOOLEAN,
subscriber_id INT NOT NULL,
orderNumber INT NOT NULL,
FOREIGN KEY(subscriber_id) REFERENCES subscriber(id),
PRIMARY KEY(id)
);
ALTER TABLE noOrder
MODIFY COLUMN addedBy VARCHAR(255) NULL;

SELECT * FROM album;

#INSERTING DATA
INSERT INTO album (name, release_year, description)
VALUES
('Lover', '2019', 'Seventh studio album by Taylor Swift'),
('After Hours', '2020', 'Fourth studio album by The Weeknd'),
('evermore', '2020', 'Ninth studio album by Taylor Swift'),
('Future Nostalgia', '2020', 'Second studio album by Dua Lipa'),
('folklore', '2020', 'Eighth studio album by Taylor Swift'),
('Positions', '2020', 'Sixth studio album by Ariana Grande'),
('Fine Line', '2019', 'Second studio album by Harry Styles'),
('Chromatica', '2020', 'Sixth studio album by Lady Gaga'),
('Manic', '2020', 'Third studio album by Halsey'),
('Map of the Soul: 7', '2020', 'Fourth studio album by BTS');

INSERT INTO song (name, duration, release_year, album_id)
VALUES
('Lover', '03:41', '2019', 1),
('Blinding Lights', '03:20', '2020', 2),
('willow', '03:34', '2020', 3),
('Levitating', '03:23', '2020', 4),
('cardigan', '04:11', '2020', 5),
('34+35', '02:53', '2020', 6),
('Adore You', '03:27', '2019', 7),
('Rain On Me', '03:02', '2020', 8),
('You should be sad', '03:25', '2020', 9),
('ON', '05:08', '2020', 10);

INSERT INTO artist (name, start_year, album_id)
VALUES
('Taylor Swift', '2004', 1),
('The Weeknd', '2010', 2),
('Taylor Swift', '2004', 3),
('Dua Lipa', '2015', 4),
('Taylor Swift', '2004', 5),
('Ariana Grande', '2008', 6),
('Harry Styles', '2010', 7),
('Lady Gaga', '2001', 8),
('Halsey', '2014', 9),
('BTS', '2013', 10);

INSERT INTO album (name, release_year, description) VALUES
('Rumours', 1977, 'Fleetwood Mac''s best-selling album of all time'),
('Born in the U.S.A.', 1984, 'One of Bruce Springsteen''s most successful albums'),
('Purple Rain', 1984, 'Soundtrack to Prince''s movie of the same name'),
('The Wall', 1979, 'Concept album by Pink Floyd'),
('Appetite for Destruction', 1987, 'Debut studio album by Guns N'' Roses'),
('Thriller', 1982, 'Michael Jackson''s sixth studio album'),
('Back in Black', 1980, 'AC/DC''s seventh studio album'),
('Nevermind', 1991, 'Second studio album by Nirvana'),
('Led Zeppelin IV', 1971, 'Fourth studio album by Led Zeppelin'),
('Abbey Road', 1969, 'The Beatles'' eleventh studio album');

INSERT INTO song (name, duration, release_year, album_id) VALUES
('Go Your Own Way', '03:38', 1977, 1),
('Dancing in the Dark', '04:01', 1984, 2),
('Purple Rain', '08:41', 1984, 3),
('Another Brick in the Wall', '03:21', 1979, 4),
('Sweet Child o'' Mine', '05:55', 1987, 5),
('Thriller', '05:58', 1982, 6),
('Back in Black', '04:15', 1980, 7),
('Smells Like Teen Spirit', '05:01', 1991, 8),
('Stairway to Heaven', '08:02', 1971, 9),
('Here Comes the Sun', '03:06', 1969, 10);

INSERT INTO artist (name, start_year, album_id) VALUES
('Fleetwood Mac', 1967, 1),
('Bruce Springsteen', 1969, 2),
('Prince', 1976, 3),
('Pink Floyd', 1965, 4),
('Guns N'' Roses', 1985, 5);

SELECT * FROM album;

#NEW TABLES INSERTS
INSERT INTO subscriber (name, subscribtionEnd, album_id, song_id)
VALUES
  ('John', '2023-05-01 12:00:00', 1, 3),
  ('Sarah', '2023-06-15 18:00:00', 2, 5),
  ('Mark', '2023-04-30 23:59:59', 3, 8),
  ('Emily', '2023-07-31 08:30:00', 4, 9),
  ('David', '2023-05-31 00:00:00', 2, 1),
  ('Jessica', '2023-05-01 00:00:00', 1, 4),
  ('Michael', '2023-06-30 14:00:00', 3, 7),
  ('Lisa', '2023-08-31 23:59:59', 4, 2),
  ('Daniel', '2023-06-15 12:00:00', 2, 6),
  ('Amanda', '2023-05-15 09:30:00', 1, 10);

-- Insert 10 records into the noorder table
INSERT INTO noorder (price, subscriber_id, orderNumber)
VALUES
  (9.99, 1, 12345),
  (14.99, 2, 56789),
  (19.99, 3, 24680),
  (29.99, 4, 13579),
  (9.99, 5, 86420),
  (14.99, 6, 97531),
  (19.99, 7, 53147),
  (29.99, 8, 98765);
  
#JOINS
	#Inner join
	#Number of songs for each band
SELECT artist.name as Artist_Name, album.name as Album_Name, COUNT(song.id) as Num_of_Songs
FROM artist
INNER JOIN album
ON artist.album_id = album.id
INNER JOIN song
ON song.album_id = album.id
WHERE song.album_id = album.id
GROUP BY artist.name
ORDER BY album.name ASC;

	#Album and song names with their duration between 2000 and 2010
SELECT album.name, song.name, song.duration
FROM album
INNER JOIN song ON album.id = song.album_id
INNER JOIN artist ON album.id = artist.album_id
WHERE artist.start_year >= 2000 AND album.release_year >= 2010;

	#Length of every album
SELECT album.name as Album_Name, DATE_FORMAT(SEC_TO_TIME(SUM(60 * MINUTE(duration) + SECOND(duration))) ,'%i:%s')  as Album_Duration
FROM album
JOIN song
ON album.id = song.album_id
GROUP BY album.name;

	#Right join
	#All Data
SELECT * FROM artist
JOIN album
ON artist.album_id = album.id 
JOIN song
ON song.album_id = album.id;

	#Songs albums and artists that have the same release year or band starting year
SELECT song.name AS Song, song.release_year AS Song_Released, album.name AS Album, album.release_year AS Album_Released
FROM song
JOIN album ON song.album_id = album.id AND song.release_year = album.release_year
JOIN artist ON album.id = artist.album_id AND artist.start_year < album.release_year
ORDER BY song.id;

	#Left join
	#Number of songs per album 
SELECT album.name as Album, IFNULL(COUNT(song.id), 0) AS Songs, IFNULL(artist.start_year, 0) AS Artist_Start_Year
FROM album
LEFT JOIN song ON album.id = song.album_id
LEFT JOIN artist ON album.id = artist.album_id
GROUP BY album.id;

	#Right join
	#Song and album info
SELECT song.name AS Song_name, song.duration, song.release_year, album.name AS Album_name
FROM song
RIGHT JOIN (
  SELECT id, name
  FROM album
) AS album ON song.album_id = album.id;

	#Full join / Union
    #Subscribers albums and songs and rest of data
SELECT a.name, a.release_year, ar.name, ar.start_year, s.name AS Subscriber, s.subscribtionEnd
FROM album a
LEFT JOIN artist ar ON a.id = ar.album_id
LEFT JOIN subscriber s ON a.id = s.album_id
UNION
SELECT a.name, a.release_year, ar.name, ar.start_year, s.name AS Subscriber, s.subscribtionEnd
FROM subscriber s
LEFT JOIN album a ON a.id = s.album_id
LEFT JOIN artist ar ON ar.album_id = a.id
WHERE a.id IS NULL
UNION
SELECT a.name, a.release_year, ar.name, ar.start_year, s.name AS Subscriber, s.subscribtionEnd
FROM artist ar
LEFT JOIN album a ON a.id = ar.album_id
LEFT JOIN subscriber s ON a.id = s.album_id
WHERE a.id IS NULL AND s.id IS NULL
ORDER BY Subscriber DESC;
    
#TRIGGER
DELIMITER $$
CREATE TRIGGER checkSubscribtion
AFTER UPDATE ON subscriber
FOR EACH ROW
BEGIN
  IF NEW.subscribtionEnd < NOW() THEN
    SELECT s.name AS Subscriber, a.name AS Album, sg.name AS Song, s.subscribtionStart, s.subscribtionEnd, 'Expired' AS Subscriber_Status
    FROM subscriber s
    LEFT JOIN album a ON s.album_id = a.id
    LEFT JOIN song sg ON s.song_id = sg.id
    WHERE s.id = NEW.id;
  END IF;
END;

CREATE TRIGGER onUpdate
BEFORE UPDATE ON artist
FOR EACH ROW
BEGIN
  SET NEW.modifiedDate = NOW();
END;
DELIMITER ;

USE music_library;

SELECT * FROM subscriber;

UPDATE subscriber 
SET addedBy = 'Davor';
