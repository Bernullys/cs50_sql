import sqlite3

while True:

    connecting = sqlite3.connect("./p_four.db")
    cursouring = connecting.cursor()

    voltage = float(input("Type voltage: "))
    current = float(input("Type current: "))
    frecuency = float(input("Type frecuency: "))
    power = float(input("Type power: "))
    energy = float(input("Type energy: "))


    cursouring.execute("""
    INSERT INTO electric_parameters (Voltage, Current, Frecuency, Power, Energy)
    VALUES (?, ?, ?, ?, ?)
    """, (voltage, current, frecuency, power, energy))

    connecting.commit()
    connecting.close()