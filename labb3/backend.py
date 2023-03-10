#Has to be python 3.7

from bottle import run, get, post, request, response
import sqlite3
import json

db = sqlite3.connect("EDAF75-AAE/labb3/movies.sqlite")


@get('/ping')
def ping():
    response.status =200
    return 'pong'

@post('/reset')
def reset():
    #Reset query.
    fd = open('EDAF75-AAE/labb3/reset.sql', 'r')
    sqlFile = fd.read()
    fd.close()
    
    c = db.cursor()
    c.executescript(sqlFile)

    found = c.fetchall()

    db.commit()


@post('/users')
def users():
    #return user
    fd = open('EDAF75-AAE/labb3/insertCustomer.sql', 'r')
    sqlFile = fd.read()
    fd.close()

    user = request.json
    username = user['username']
    fullName = user['fullName']
    pwd = user['pwd']
    c = db.cursor()
    try: 
        c.execute(sqlFile, [username, fullName, pwd])
        found = c.fetchone()
        db.commit()
        return "/users/"+username

    except Exception as e:
        response.status = 400
        print(e)
        return ""

@post('/movies')
def movies():
    #return movie
    fd = open('EDAF75-AAE/labb3/insertMovie.sql', 'r') 
    sqlFile = fd.read()
    fd.close()

    movie = request.json
    imdbkey = movie['imdbKey']
    title = movie['title']
    year = movie['year']
    c = db.cursor()

    try:
        c.execute(sqlFile, [imdbkey, title, year])
        found = c.fetchone()
        db.commit()
        response.status = 201
        return "/movies/" + imdbkey
    except:
        response.status = 400
        return ""

@post('/performances')
def performance():
    #return performance
    fd = open('EDAF75-AAE/labb3/insertPerformance.sql', 'r') 
    sqlFile = fd.read().split(';')
    fd.close()

    performance = request.json
    imdbkey = performance['imdbKey']
    theater = performance['theater']
    date = performance['date']
    time = performance['time']

    try:
        c = db.cursor()
        c.execute(sqlFile[0], [imdbkey, theater, date, time])
        db.commit()

        c.execute(sqlFile[1])

        found = c.fetchone()
        response.status = 201
        return "/performances/" +str(found[0])
    except:
        response.status = 400
        return "No such movie or theater"

@get('/movies')
def returnMovies():
    fd = open('EDAF75-AAE/labb3/getMovies.sql', 'r') 
    sqlFile = fd.read()
    fd.close()
    params = []
    if request.query.title:
        sqlFile += " AND title = ?"
        params.append(request.query.title)
    if request.query.year:
        sqlFile += " AND production_year = ?"
        params.append(request.query.year)

    sqlFile += ";"
    c = db.cursor()
    c.execute(sqlFile,params)

    
    found = [{"imdbKey":IMDB_key, "title":title, "year":production_year}
        for IMDB_key, title, production_year in c]
    return {"data":found}

@get('/movies/<IMDB_key>')
def getMovieFromIMDB(IMDB_key):
    fd = open('EDAF75-AAE/labb3/getMovies.sql', 'r') 
    sqlFile = fd.read()
    fd.close()

    sqlFile += "AND IMDB_key=?"
    sqlFile += ";"
    c = db.cursor()
    c.execute(sqlFile,[IMDB_key])

    found = [{"imdbKey":IMDB_key, "title":title, "year":production_year}
        for IMDB_key, title, production_year in c]
    return {"data":found}


@get('/performance')
def returnPerformances():
    fd = open('EDAF75-AAE/labb3/getPerformances.sql', 'r') 
    sqlFile = fd.read()
    fd.close()

    sqlFile += ";"
    c = db.cursor()
    c.execute(sqlFile)
    
    found = [{"performanceId":performance_id,
            "date": performance_date,
            "startTime": start_time,
            "title": title,
            "year": production_year,
            "theater": theater_name,
            "remaingingSeats" : remaining_seats,
            }
        for performance_id, performance_date, start_time,title,production_year,theater_name,remaining_seats in c]
    return {"data":found}

@post('/tickets')
def tickets():
    fd = open('EDAF75-AAE/labb3/registerTicket.sql', 'r')
    sqlFile = fd.read().split(';')
    fd.close()

    user = request.json
    username = user['username']
    pwd = user['pwd']
    performanceId = user['performanceId']
    c = db.cursor()

    try:
        c.execute(sqlFile[0],[performanceId,username,pwd])
        db.commit()
        c.execute(sqlFile[1])
        ticketid ,= c.fetchone()
        response.status = 201
        return "/tickets/"+ticketid
    except Exception as e:
        if (str(e) == "Sold out"):
            response.status =400
            return "Sold out"
        elif (str(e) == "Wrong user credentials"):
            response.status =401
            return "Wrong user credentials"
        else:
            response.status = 400
            return "Error"




run(host='localhost', port=7007)