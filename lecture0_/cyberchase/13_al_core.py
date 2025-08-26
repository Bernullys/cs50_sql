from sqlalchemy import create_engine, Table, MetaData, select, or_, cast, String, func

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()
reflected_table = Table("episodes", metadata, autoload_with=engine)

air_date_cast = cast(reflected_table.c.air_date, String)

stmt = select(reflected_table.c.title, reflected_table.c.topic, air_date_cast).where(func.strftime("%m-%d", air_date_cast).in_(["12-31", "12-25"]))

with engine.connect() as db_conn:
    res = db_conn.execute(stmt)

    for r in res:
        print(r)