import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    result = cursor.execute(
        """
            SELECT title, topic
            FROM episodes
            WHERE topic LIKE ?
        """,("%fraction%",))
    fractions_epi = result.fetchall()

for f_e in fractions_epi:
    print(f_e[0], "|", f_e[1])