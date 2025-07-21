from sqlalchemy import create_engine, Table, MetaData, select, and_

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()
rf_db = Table("episodes", metadata, autoload_with=engine)

stmt = select(rf_db.c.title).where(
    and_(
        rf_db.c.season == 6,
        rf_db.c.air_date.like("2007-%")
    )
)

with engine.connect() as db_conn:
    result = db_conn.execute(stmt)

for r in result:
    print(r[0])