from sqlalchemy import create_engine, select, MetaData, Table

BASE_URL = "sqlite:///cyberchase.db"
engine = create_engine(BASE_URL, echo=True)
metadata = MetaData()

# Reflect the existing table from the database:
episodes_table = Table("episodes", metadata, autoload_with=engine)

with engine.connect() as session:
    titles = select(episodes_table.c.title)
    result = session.execute(titles)

for row in result:
    print(row.title)