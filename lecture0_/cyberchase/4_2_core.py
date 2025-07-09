from sqlalchemy import create_engine, select, Table, MetaData

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()

reflected_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(reflected_table.c.title).where(reflected_table.c.topic == None)

with engine.connect() as session:
    result = session.execute(stmt)

for r in result:
    print(r[0])