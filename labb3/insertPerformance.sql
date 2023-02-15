INSERT INTO Performance (IMDB_key,theater_name,performance_date, start_time)
VALUES (?,?,?,?);

SELECT performance_id
FROM Performance
WHERE rowid = last_insert_rowid();

