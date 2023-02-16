INSERT INTO Ticket (performance_id,username)
VALUES (?,(
    SELECT username
    FROM Customer
    WHERE (username=?) and (user_password=?)
));

SELECT ticket_id
FROM Ticket
WHERE rowid = last_insert_rowid()