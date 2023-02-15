SELECT *, count() , capacity - count() as "free seats"
FROM Performance
JOIN Theater
    USING (theater_name)
JOIN TICKET
    USING (performance_id)
GROUP BY performance_id
