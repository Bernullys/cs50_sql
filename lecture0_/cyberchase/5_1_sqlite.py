import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    result = cursor.execute(
        '''
            SELECT title
            FROM episodes
            WHERE air_date = ?
        ''', ("2004-12-31",)
    )

for d in result:
    print(d[0])