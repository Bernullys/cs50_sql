import sqlite3

with sqlite3.connect("cyberchase.db") as db_connection:
    db_cursor = db_connection.cursor()
    db_cursor.execute(
        '''
            SELECT production_code
            FROM episodes
            WHERE title = ?
        ''',("Hackerized!",)
        )
    answer = db_cursor.fetchone()

print(answer[0])