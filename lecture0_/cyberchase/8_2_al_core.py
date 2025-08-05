from sqlalchemy import create_engine, Table, MetaData, select, func

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()

re_table = Table("episodes", metadata, autoload_with=engine)

stmt = select(func.count(re_table.c.episode_in_season)).where(re_table.c.air_date.between("2018-01-01", "2023-12-31"))
    
with engine.connect() as db_conn:
    res =  db_conn.execute(stmt)

for r in res:
    print(r[0])