from sqlalchemy import create_engine, Table, MetaData, select, func

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()
refleted_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(func.count(refleted_table.c.episode_in_season)).where(refleted_table.c.air_date.between("2002-01-01", "2007-12-31"))

with engine.connect() as db_conn:
    result = db_conn.execute(stmt)

for r in result:
    print(r[0])