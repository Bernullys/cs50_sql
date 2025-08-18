from sqlalchemy import create_engine, Column, Integer, String, func, distinct, select
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db", echo=True)
LocalSession = sessionmaker(bind=engine)
Base = declarative_base()

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))

stmt = select(func.count(distinct(EpisodesTable.title)))

with LocalSession() as db_conn:
    res = db_conn.execute(stmt)

for r in res:
    print(r[0])