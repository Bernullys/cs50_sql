import sqlite3

db_connection = sqlite3.connect("cyberchase.db")
cursor = db_connection.cursor()
cursor.execute(
    '''
        SELECT title FROM episodes
        WHERE season = ?
    ''',(1,))
titles = cursor.fetchall()

for title in titles:
    print(title[0])