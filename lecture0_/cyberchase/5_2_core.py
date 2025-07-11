from sqlalchemy import create_engine, select, Table, MetaData

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()
re_db = Table("episodes", metadata, autoload_with=engine)

stmt = select(re_db.c.title).where(re_db.c.air_date == "2004-12-31")

with engine.connect() as db_conn:
    result = db_conn.execute(stmt)

for t in result:
    print(t[0])
