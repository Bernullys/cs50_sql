import sqlite3

with sqlite3.connect("cyberchase.db") as db_connection:
    cursor = db_connection.cursor()
    cursor.execute(
        '''
        SELECT season, title
        FROM episodes
        WHERE episode_in_season = ? 
        ''',(1,))
    result = cursor.fetchall()

for r in result:
    print(r[0], r[1])