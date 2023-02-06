
DROP TABLE IF EXISTS theater
CREATE TABLE theater (
    theater_name TEXT
    capacity INT

    PRIMARY KEY (theater_name) 
)

DROP TABLE IF EXISTS performance
CREATE TABLE performance (
    performance_id TEXT
    start_time DATETIME

    FOREIGN KEY(IMDB_key) REFERENCES movie(IMDB_key)
    FOREIGN KEY(theater_name) REFERENCES theater(theater_name)
    PRIMARY KEY(performance_id)
     
)

DROP TABLE IF EXISTS movie
CREATE TABLE movie (
    IMDB_key TEXT
    running_time INT
    title TEXT
    production_year INT

    PRIMARY KEY(IMDB_key)
)

DROP TABLE IF EXISTS ticket
CREATE TABLE ticket (
    ticket_id randomblob(16)
    FOREIGN KEY(performance_id) REFERENCES performance(performance_id)
    FOREIGN KEY(username) REFERENCES customer(username)
)

DROP TABLE IF EXISTS customer
CREATE TABLE customer (
    username TEXT
    full_name TEXT
    user_password TEXT

    PRIMARY KEY(username)
)

INSERT INTO Theater (theater_name, capacity)
VALUES 
    ('Sparta',90),
    ('Västgöta Nation',25),
    ('Lunds bio',300);


INSERT INTO Movie (IMDB_key,running_time,title,production_year)
VALUES
    ('abcd123','90','Need for speed','2020'),
    ('efgh456','120','Avatar: The last airbender','2004'),
    ('ijkl789','116','Grabben i graven bredvid','2002'),
    ('mnop123','123','Alla vägar bär till rom','2002');

INSERT INTO Performance (performance_date,performance_time,IMDB_key,theater_name)
VALUES
    ('2022–02-01','19:00','abcd123','Sparta'),
    ('2022–02-01','19:30','abcd123','Sparta'),
    ('2022–02-01','20:00','abcd123','Sparta'),
    ('2022–02-01','20:30','abcd123','Sparta'),
    ('2022–03-06','19:00','efgh456','Västgöta Nation'),
    ('2022–03-06','19:30','efgh456','Västgöta Nation'),
    ('2022–03-06','20:00','efgh456','Västgöta Nation'),
    ('2022–03-06','20:30','efgh456','Västgöta Nation'),
    ('2022–03-06','19:00','ijkl789','Lunds Bio'),
    ('2022–03-06','19:30','ijkl789','Lunds Bio'),
    ('2022–03-06','20:00','ijkl789','Lunds Bio'),
    ('2022–03-06','20:30','ijkl789','Lunds Bio');
