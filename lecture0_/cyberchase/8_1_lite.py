import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor_db = db_conn.cursor()
    stmt = cursor_db.execute("""
        SELECT COUNT(episode_in_season)
        FROM episodes
        WHERE air_date BETWEEN ? AND ?
    """,("2018-01-01", "2023-12-31"))
    res = stmt.fetchall()

print(res)