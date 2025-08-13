from sqlalchemy import create_engine, Column, Integer, Date, String, desc, select
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db")
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    air_date = Column(Date)
    production_code = Column(String(20))

stmt = select(EpisodesTable.id, EpisodesTable.title, EpisodesTable.production_code).order_by(EpisodesTable.production_code, EpisodesTable.air_date)

with LocalSession() as db_conn:
    result = db_conn.execute(stmt)

for r in result:
    print(f"{r[0]} | {r[1]}  | {r[2]}")