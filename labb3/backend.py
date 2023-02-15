#Has to be python 3.7

from bottle import run, get, post, request, response
import sqlite3

db = sqlite3.connect("EDAF75-AAE/labb3/movies.sqlite")


@get('/ping')
def ping():
    response.status =200
    return 'pong'

@get('/reset')
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
    user = request.json
    username = user['username']
    fullName = user['fullName']
    pwd = user['pwd']
    return Null
    
    
run(host='localhost', port=7007)