/*WITH remaining_seats AS (
    (
    SELECT capacity
    FROM Theater
    WHERE Theater.theater_name = Performance.theater_name
    )
    -
    (
    SELECT count() 
    FROM Ticket 
    WHERE Ticket.performance_id = Performance.performance_id
    )
)*/

SELECT p.performance_id, p.performance_date, p.start_time, m.title, m.production_year, p.theater_name, test AS remaining_seats
FROM Performance AS p
LEFT OUTER JOIN movie AS m
USING (IMDB_key)
LEFT OUTER JOIN Theater AS t
USING (theater_name)
LEFT OUTER JOIN (
    SELECT performance_id, count() as test
    FROM ticket
    GROUP BY performance_id 
    )
    USING (performance_id)