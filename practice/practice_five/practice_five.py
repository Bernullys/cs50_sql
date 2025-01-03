import sqlite3
from practice_three.workers import Workers

worker_1 = Workers("Bernardo", 37, "b.davila", "Chief")

# Create table
def create_workers_table():
    connecting = sqlite3.connect("inste_workers.db")
    coursouring = connecting.cursor()
    coursouring.execute("""
    CREATE TABLE IF NOT EXISTS workers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        email TEXT NOT NULL UNIQUE,
        charge TEXT NOT NULL
    )""")
    connecting.commit()
    connecting.close()

# Insert data
def insert_worker(workers): # This parameter has to be an entity of a Workers class
    connecting = sqlite3.connect("inste_workers.db")
    coursouring = connecting.cursor()
    coursouring.execute("""
    INSERT INTO workers (name, age, email, charge)
    VALUES(?, ?, ?, ?)    
    """, (workers.name, workers.age, workers.email, workers.charge))
    connecting.commit()
    connecting.close()

# Select worker by charge
def select_worker(charge):
    connecting = sqlite3.connect("inste_workers.db")
    coursouring = connecting.cursor()
    coursouring.execute("""
    SELECT * FROM workers WHERE charge=?
    """, (charge,))
    worker = coursouring.fetchone()
    connecting.close()
    return worker

# Updata worker charge by name
def update_worker(name, charge):
    connecting = sqlite3.connect("inste_workers.db")
    coursouring = connecting.cursor()
    coursouring.execute("""
    UPDATE workers SET charge=? WHERE name=?
    """, (charge, name))
    connecting.commit()
    connecting.close()

# Deleting worker by name
def deleting_worker(name):
    connecting = sqlite3.connect("inste_workers.db")
    coursouring = connecting.cursor()
    coursouring.execute("""
    DELETE FROM workers WHERE name=?
    """, (name,))
    connecting.commit()
    connecting.close()

# Select all data
def select_all():
    connecting = sqlite3.connect("inste_workers.db")
    cursouring = connecting.cursor()
    cursouring.execute("""
    SELECT * FROM workers
    """)
    workers_data = cursouring.fetchall()
    connecting.close()
    return workers_data