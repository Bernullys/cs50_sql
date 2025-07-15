import sqlite3

with sqlite3.connect("cyberchase.db") as db_connect:
    cursor = db_connect.cursor()
    result = cursor.execute(
        '''
            SELECT title
            FROM episodes
            WHERE air_date = ?
        ''', ("2004-12-31",))

for r in result:
    print(r[0])