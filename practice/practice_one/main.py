import sqlite3

# To connect to a database if not exists:
db_connection = sqlite3.connect("practice_one.db")

# Create a cursor object to execute SQL commands:
cursor_commands = db_connection.cursor()

# Create a table if it does't already exist:
cursor_commands.execute(
    """
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    email TEXT NOT NULL
)
""")

# Ask users for inputs:
name = input("Type your name: ")
age = int(input("Type your age: "))
email = input("Type your email: ")

# Insert data into the Table:
cursor_commands.execute(
    """
INSERT INTO users (name, age, email)
VALUES (?, ?, ?)
""", (name, age, email))

# Commit the transaction and close the connection:
db_connection.commit()
db_connection.close()

print("Database saved successfully")
