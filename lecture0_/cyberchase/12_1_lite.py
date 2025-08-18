import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    res = cursor.execute("""
        SELECT COUNT(DISTINCT(title))
        FROM  episodes
    """)


for r in res:
    print(r[0])