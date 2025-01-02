import sqlite3

# Connect to the database:
connection = sqlite3.connect("./practice_one.db")

# Create a cursor so enable to use SQL code:
cursor = connection.cursor()

# Fetch and print all data from users:
cursor.execute("""
SELECT * FROM users
""")
data_rows = cursor.fetchall()

for row in data_rows:
    print(row)

# close the connection:
connection.close()