import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    stmt = cursor.execute("""
        SELECT COUNT(episode_in_season)
        FROM episodes
        WHERE air_date BETWEEN ? AND ?
        """,("2002-01-01", "2007-12-31"))
    result = stmt.fetchall()

for r in result:
    print(r[0])