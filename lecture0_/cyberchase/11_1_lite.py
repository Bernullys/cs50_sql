import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    result = cursor.execute("""
        SELECT title
        FROM episodes
        WHERE season = 5
        ORDER BY title DESC
""")

for r in result:
    print(r[0])