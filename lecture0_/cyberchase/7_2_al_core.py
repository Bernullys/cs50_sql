from sqlalchemy import create_engine, MetaData, Table, select

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()

re_db = Table("episodes", metadata, autoload_with=engine)

stmt = select(re_db.c.title, re_db.c.topic).where(re_db.c.topic.like("%fraction%"))

with engine.connect() as conn:
    result = conn.execute(stmt)

for tt in result:
    print(tt[0], "|", tt[1])