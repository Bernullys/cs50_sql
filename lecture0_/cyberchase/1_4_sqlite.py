import sqlite3

db_connection = sqlite3.connect("cyberchase.db")

with db_connection as connected_db:
    cursor = connected_db.cursor()
    titles = cursor.execute(
        '''
            SELECT title
            FROM episodes
            WHERE season = ?
        ''',(1,))

for title in titles:
    print(title[0])