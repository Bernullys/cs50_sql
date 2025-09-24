import sqlite3

with sqlite3.connect("views.db") as db_conn:
    cursor_db = db_conn.cursor()
    cursor_db.execute("""
            SELECT japanese_title, english_title
            FROM views
        """)
    titles = cursor_db.fetchall()

for title in titles:
    print(title[0], title[1])