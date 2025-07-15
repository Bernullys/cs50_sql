from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db", echo=True)
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    air_date = Column(String(15))


with LocalSession() as session:
    result = session.query(EpisodesTable.title).where(EpisodesTable.air_date == "2004-12-31")

for r in result:
    print(r[0])