

PRAGMA foreign_keys=OFF;
DROP TABLE IF EXISTS theater;
DROP TABLE IF EXISTS performance;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS customer;
PRAGMA foreign_keys=ON;


CREATE TABLE Theater (
    theater_name TEXT PRIMARY KEY,
    capacity INT 
);

CREATE TABLE Movie (
    IMDB_key TEXT PRIMARY KEY,
    running_time INT,
    title TEXT,
    production_year INT
);

CREATE TABLE Customer (
    username TEXT PRIMARY KEY,
    full_name TEXT,
    user_password TEXT
);


CREATE TABLE Performance (
    performance_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    performance_date DATE,
    start_time TIME,
    IMDB_KEY TEXT,
    theater_name TEXT,

    FOREIGN KEY (IMDB_key) REFERENCES Movie(IMDB_key),
    FOREIGN KEY (theater_name) REFERENCES Theater(theater_name)
);

CREATE TRIGGER performance_check
    BEFORE INSERT ON Performance
BEGIN
    SELECT
        CASE
            WHEN(
            (SELECT count()
            FROM movie
            WHERE movie.IMDB_key = NEW.IMDB_key
            ) < 1

            OR

            (SELECT count()
            FROM Theater
            WHERE Theater.theater_name = NEW.Theater_name
            ) < 1
            ) 
            THEN RAISE (ABORT, 'No such movie or theater!')
        END;
END;


CREATE TABLE Ticket (
    ticket_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    performance_id TEXT,
    username TEXT,
    FOREIGN KEY (performance_id) REFERENCES Performance(performance_id),
    FOREIGN KEY (username) REFERENCES Customer(username)
 
);

CREATE TRIGGER ticket_check
    BEFORE INSERT ON Ticket
BEGIN
    SELECT
        CASE
            WHEN NEW.username IS NULL
            THEN RAISE (ABORT, 'Wrong user credentials')
            WHEN (SELECT count() FROM Ticket WHERE Ticket.performance_id = NEW.performance_id) = (SELECT capacity FROM Theater WHERE Theater.theater_name = (SELECT theater_name FROM Performance WHERE Performance.performance_id = NEW.performance_id))
            THEN RAISE (ABORT, 'Sold out')
             
        END;
END;

INSERT INTO Theater (theater_name, capacity)
VALUES 
    ('Kino',10),
    ('Regal',16),
    ('Skandia',100);


/*

INSERT INTO Movie (IMDB_key,running_time,title,production_year)
VALUES
    ('abcd123','abcd123','Need for speed',2020),
    ('efgh456','efgh456','Avatar: The last airbender',2004),
    ('ijkl789','116','Grabben i graven bredvid',2002),
    ('mnop123','ijkl789','Alla vägar bär till rom',2002);


INSERT INTO Performance (performance_date,start_time,IMDB_key,theater_name)
VALUES
    ('2022-02-01','19:00','abcd123','Kino'), 
    ('2022-02-01','19:30','abcd123','Kino'),
    ('2022-02-01','20:00','abcd123','Kino'),
    ('2022-02-01','20:30','abcd123','Kino'),
    ('2022-03-06','19:00','efgh456','Regal'),
    ('2022-03-06','19:30','efgh456','Regal'),
    ('2022-03-06','20:00','efgh456','Regal'),
    ('2022-03-06','20:30','efgh456','Regal'),
    ('2022-03-06','19:00','ijkl789','Skandia'),
    ('2022-03-06','19:30','ijkl789','Skandia'),
    ('2022-03-06','20:00','ijkl789','Skandia'),
    ('2022-03-06','20:30','ijkl789','Skandia');

INSERT INTO customer (username,full_name,user_password)
VALUES
    ("user1","user username","password"),
    ("user2","user2 username2","h4ck3r"),
    ("user3","user3 username3 lastname3","1337");

INSERT INTO Ticket (performance_id,username)
VALUES
    (1,"user1"),
    (1,"user3"),
    (2,"user2"),
    (4,"user3"),
    (4,"user2"),
    (4,"user1");

*/