from sqlalchemy import create_engine, Column, String, Integer, and_
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db", echo=True)
LocalSession = sessionmaker(bind=engine)
Base = declarative_base()

class EpisodesTable(Base):
    __tablename__ = "episodes"
    
    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    season = Column(Integer)
    air_date = Column(String(50))

with LocalSession() as session:
    title = session.query(EpisodesTable.title).filter(EpisodesTable.season == 6, EpisodesTable.air_date.like("2007-%"))

for t in title:
    print(t[0])