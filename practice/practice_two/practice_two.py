import sqlite3

connecting = sqlite3.connect("./practice_two.db")
cursouring = connecting.cursor()

name = input("Type your name: ")
age = input("Type your age: ")
email = input("Type your email: ")

cursouring.execute("""
INSERT INTO users (name, age, email)
VALUES (?, ?, ?)
""", (name, age, email))

connecting.commit()
connecting.close()