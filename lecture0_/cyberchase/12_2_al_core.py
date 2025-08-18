from sqlalchemy import create_engine, Table, MetaData, select, func, distinct

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()

reflected_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(func.count(distinct(reflected_table.c.title)))

with engine.connect() as db_conn:
    res = db_conn.execute(stmt)

for r in res:
    print(r[0])