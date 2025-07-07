from sqlalchemy import create_engine, MetaData, Table, select

engine = create_engine("sqlite:///cyberchase.db", echo=True)
metadata = MetaData()

re_episodes_db = Table("episodes", metadata, autoload_with=engine)

stmt = select(re_episodes_db.c.production_code).where(re_episodes_db.c.title == "Hackerized!")

with engine.connect() as re_db_conn:
    answer = re_db_conn.execute(stmt)

for a in answer:
    print(a[0])