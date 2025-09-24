from sqlalchemy import create_engine, Table, MetaData, select

engine = create_engine("sqlite:///views.db")
metadata = MetaData()

reflected_table = Table("views", metadata, autoload_with=engine)

with engine.connect() as db_conn:
    titles = db_conn.execute(
        select(reflected_table.c.japanese_title, reflected_table.c.english_title)
    )

for title_row in titles:
    print(title_row[0], title_row[1])