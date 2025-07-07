from sqlalchemy import create_engine, MetaData, Table, select

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()

episodes_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(episodes_table.c.title).where(episodes_table.c.season == 1)

with engine.connect() as conn:
    result = conn.execute(stmt)

for row in result:
    print(row.title)