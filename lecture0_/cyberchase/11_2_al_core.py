from sqlalchemy import create_engine, Table, MetaData, select, desc

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()

reflected_db_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(reflected_db_table.c.title).filter(reflected_db_table.c.season == 5).order_by(desc(reflected_db_table.c.title))

with engine.connect() as db_conn:
    result = db_conn.execute(stmt)

for r in result:
    print(r[0])
