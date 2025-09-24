from sqlalchemy import create_engine, Column, String, Integer, select
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///views.db")
SessionLoad = sessionmaker(bind=engine)
Base = declarative_base()

class ViewsTable(Base):
    __tablename__= "views"

    id = Column(Integer, primary_key=True)
    japanese_title = Column(String(50))
    english_title = Column(String(50))

stmt = select(ViewsTable.japanese_title, ViewsTable.english_title)

with SessionLoad() as session:
    titles = session.execute(stmt)

for title_row in titles:
    print(title_row[0], title_row[1])