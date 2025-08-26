import sqlite3

with sqlite3.connect("cyberchase.db") as db_conn:
    cursor = db_conn.cursor()
    stmt = cursor.execute("""
        SELECT title, topic, air_date
        FROM episodes
        WHERE air_date LIKE ? OR ?
    
    """,("%-12-31", "%-12-25"))
    #res_all = stmt.fetchall()
    res_one = stmt.fetchone()

print(res_one)
for ro in res_one:
    print(ro)

# print(res_all)
# for ra in res_all:
#     print(ra)