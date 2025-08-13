import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    result = cursor.execute("""
        SELECT id, title, production_code
        FROM episodes
        ORDER BY production_code, air_date
        """)

for r in result:
    print(f"{r[0]} | {r[1]}  | {r[2]}")