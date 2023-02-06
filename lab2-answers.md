4.
    a)  Which relations have natural keys?
        Performance-Movie:
        Performance-Theater:
        Customer-ticket:username

    b)  Is there a risk that any of the natural keys will ever change?
        Theater:name could change
        Custmer: username could change.

    c) Are there any weak entity sets?
        Performance & ticket

    d) In which relations do you want to use an invented key. Why?
        On the weak ones, this because we want to be able to independently be identified. The existing attributes does not support this soleley.

6.
    a) There are at least two ways of keeping track of the number of seats available for each performance – describe them both,     with their upsides and downsides (write your answer in lab2-answers.md).
        Either we can just save the availability as an integer, and for every purchased ticket de decrement the number of free seats.
        Another solution is to backtrack, and iterate, through the history of purchases. Thereby, knowing how many seats that are left.
        
