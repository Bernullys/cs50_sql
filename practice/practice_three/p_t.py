import sqlite3
from workers import Workers

connecting = sqlite3.connect("p_t.db")
cursouring = connecting.cursor()
cursouring.execute("""
CREATE TABLE IF NOT EXISTS workers (
    name TEXT,
    age INTEGER,
    email TEXT,
    charge TEXT)
""")


worker_1 = Workers("Bernardo", 37, "b.davila@instelecsa.cl", "EEC")
worker_2 = Workers("Jano", 27, "a.rubio@instelecsa.cl", "ProjectC")
worker_3 = Workers("Lucho", 28, "ing.soporte@instelecsa.cl", "SoporteChief")
worker_4 = Workers("Mathias", 30, "m.crisotomo@instelecsa.cl", "Project1")

all_workers = [worker_1, worker_2, worker_3, worker_4]
all_workers_list_of_tuples = [
    (worker_1.name, worker_1.age, worker_1.email, worker_1.charge),
    (worker_2.name, worker_2.age, worker_2.email, worker_2.charge),
    (worker_3.name, worker_3.age, worker_3.email, worker_3.charge),
    (worker_4.name, worker_4.age, worker_4.email, worker_4.charge)
]


for worker in all_workers:
    cursouring.execute("""
    INSERT INTO workers (name, age, email, charge)
    VALUES (?, ?, ?, ?)
    """, (worker.name, worker.age, worker.email, worker.charge))

# Another way to inset a list is with executemany:
cursouring.executemany("""
INSERT INTO workers (name, age, email, charge)
VALUES (?, ?, ?, ?)
""", (all_workers_list_of_tuples))

connecting.commit()
connecting.close()