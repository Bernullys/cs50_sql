import sqlite3

db_connection = sqlite3.connect("molds.db")
db_manipulation = db_connection.cursor()


ref = {
    "CC-L": "Unión Cable-Cable TEE Horizontal",
    "CC-TH": "Unión en T",
    "CC-X": "Unión en X",
    "CC-XS": "Unión en X, cables pasantes"
}

sections = {
    "6": "A",
    "4": "B",
    "3": "C",
    "2": "D",
    "1": "E",
    "1/0": "F",
    "2/0": "G",
    "3/0": "H",
    "4/0": "I",
    "250": "J",
    "300": "K",
    "350": "L",
    "500": "M",
    "1/8": "N",
    "3/16": "O",
    "1/4": "P",
    "3/8": "Q",
    "1/2": "R",
    "5/8": "S",
    "3/4": "T",
    "1": "U",
    "2": "V",
    "3": "X",
    "4": "Y"
}

mold = input("Ingrese el molde que desea buscar: ")
principal_cable_section = input("Ingrese la sección del cable principal: ")
secondary_cable_section = input("Ingrese la sección del cable secundario: ")

try:
    for key, value in ref.items():
        if value == mold:
            db_manipulation.execute("""
                SELECT mold_type, principal_cable_code, secondary_cable_code, charge, disc
                FROM molds_table WHERE mold_description = ? AND principal_cable_section = ? AND secondary_cable_section = ?
            """, (mold, principal_cable_section, secondary_cable_section))

            mold_data = db_manipulation.fetchone()
            print(f" Modelo: {mold_data[0]}-{mold_data[1]}{mold_data[2]}, Carga: {mold_data[3]}, Disco: {mold_data[4]}")
            break
    else:
        print(f"No se encontró el molde '{mold}', asegurese de que está escrito correctamente.")
except:
    print(f"No se encontró el molde '{mold}', asegurese de que está escrito correctamente.")


db_connection.close()

