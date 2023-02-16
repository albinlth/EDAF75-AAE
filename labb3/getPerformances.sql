SELECT performance_id, performance_date, start_time,title,production_year,theater_name, capacity-count(ticket_id) as remaining_seats
FROM Performance
LEFT JOIN ticket using (performance_id)
JOIN theater using (theater_name)
JOIN Movie using (IMDB_KEY)
GROUP BY (performance_id)