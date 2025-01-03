import sqlite3

# Connect to the database:
connection = sqlite3.connect("./practice_one.db")

# Create a cursor so enable to use SQL code:
cursor = connection.cursor()

# Fetch and print all data from users: (we can also use fetchone or fetch(n) where n is an integer)
cursor.execute("""
SELECT * FROM users
""")
data_rows = cursor.fetchall()

for row in data_rows:
    print(row)

# Also if we want to use a WHERE condition in our query we have to use this sintax:
cursor.execute("""
SELECT * FROM users WHERE email=?
""", ('bernardoantoniod@gmail.com',)) # IMPORTANT: If this is only a value we have to put a , because it has to be a tuple.
ber_email = cursor.fetchone()
print(ber_email)

# close the connection:
connection.close()