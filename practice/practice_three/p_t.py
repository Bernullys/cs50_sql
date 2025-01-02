import sqlite3
from workers import Workers

connecting = sqlite3.connect("p_t.db")
cursouring = connecting.cursor()
cursouring.execute("""
CREATE TABLE workers (
    name TEXT,
    age INTEGER,
    email TEXT,
    charge TEXT)
""")


worker_1 = Workers("Bernardo", 37, "b.davila@instelecsa.cl", "EEC")
worker_2 = Workers("Jano", 27, "a.rubio@instelecsa.cl", "ProjectC")
worker_3 = Workers("Lucho", 28, "ing.soporte@instelecsa.cl", "SoporteChief")
worker_4 = Workers("Mathias", 30, "m.crisotomo@instelecsa.cl", "Project1")

cursouring.execute("""
INSERT INTO workers
VALUES (?, ?, ?, ?)
""", (worker_1.name, worker_1.age, worker_1.email, worker_1.charge))

connecting.commit()
connecting.close()