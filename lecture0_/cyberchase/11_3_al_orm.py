from sqlalchemy import create_engine, Column, Integer, String, select, desc
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db", echo=True)
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    season = Column(Integer)

stmt = select(EpisodesTable.title).filter(EpisodesTable.season == 5).order_by(desc(EpisodesTable.title))

with LocalSession() as db_conn:
    result = db_conn.execute(stmt)

for r in result:
    print(r[0])