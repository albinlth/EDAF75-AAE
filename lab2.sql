
DROP TABLE IF EXISTS theater
CREATE TABLE theater (
    theater_name TEXT PRIMARY KEY
    capacity INT 
)

DROP TABLE IF EXISTS performance
CREATE TABLE performance (
    performance_id TEXT PRIMARY KEY
    performance_date DATE
    start_time TIME

    FOREIGN KEY(IMDB_key) REFERENCES movie(IMDB_key)
    FOREIGN KEY(theater_name) REFERENCES theater(theater_name)     
)

DROP TABLE IF EXISTS movie
CREATE TABLE movie (
    IMDB_key TEXT PRIMARY KEY
    running_time INT
    title TEXT
    production_year INT
)

DROP TABLE IF EXISTS ticket
CREATE TABLE ticket (
    ticket_id lower(hex(randomblob(16))) PRIMARY KEY

    FOREIGN KEY(performance_id) REFERENCES performance(performance_id)
    FOREIGN KEY(username) REFERENCES customer(username)
)

DROP TABLE IF EXISTS customer
CREATE TABLE customer (
    username TEXT PRIMARY KEY
    full_name TEXT
    user_password TEXT
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
