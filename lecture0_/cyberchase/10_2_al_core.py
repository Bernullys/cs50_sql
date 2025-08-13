from sqlalchemy import create_engine, Table, MetaData, select, func, desc

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()

reflected_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(reflected_table.c.id, reflected_table.c.title, reflected_table.c.production_code).order_by(reflected_table.c.production_code, reflected_table.c.air_date)

with engine.connect() as db_conn:
    result = db_conn.execute(stmt)

for r in result:
    print(f"{r[0]} | {r[1]}  | {r[2]}")