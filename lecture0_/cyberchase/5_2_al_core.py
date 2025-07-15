from sqlalchemy import create_engine, Table, MetaData, select

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()
re_db = Table("episodes", metadata, autoload_with=engine)

stmt = select(re_db.c.title).where(re_db.c.air_date == "2004-12-31")

with engine.connect() as db_connect:
    result = db_connect.execute(stmt)

for r in result:
    print(r[0])