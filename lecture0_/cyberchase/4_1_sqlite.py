import sqlite3

with sqlite3.connect("cyberchase.db") as db_connection:
    cursor = db_connection.cursor()
    result = cursor.execute(
        '''
            SELECT title
            FROM episodes
            WHERE topic IS NULL
        '''
    )

for r in result:
    print(r[0])