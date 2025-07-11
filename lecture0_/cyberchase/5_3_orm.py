from sqlalchemy import create_engine, select, Column, String, Integer
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///cyberchase.db")
LocalSession = sessionmaker(bind=engine)
Base = declarative_base()

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    air_date = Column(String(50))

with LocalSession() as session:
    result = session.query(EpisodesTable.title).where(EpisodesTable.air_date == "2004-12-31")

for t in result:
    print(t[0])