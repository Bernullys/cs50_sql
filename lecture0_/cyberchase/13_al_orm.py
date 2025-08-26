from sqlalchemy import create_engine, Column, String, Integer, Date, select, or_
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///cyberchase.db")
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    air_date = Column(Date)
    topic = Column(String(50))

stmt = select(EpisodesTable.title, EpisodesTable.topic, EpisodesTable.air_date).where(or_(
    EpisodesTable.air_date.like("%-12-25"),
    EpisodesTable.air_date.like("%-12-31")
))

with LocalSession() as db_conn:
    res = db_conn.execute(stmt)


for r in res:
    print(r)
