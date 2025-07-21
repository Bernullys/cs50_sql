import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    result = cursor.execute(
        """
            SELECT title
            FROM episodes
            WHERE season = ? AND air_date LIKE ?
        """,(6,"2007-__-__")
    )
    titles = result.fetchall()

print(titles)