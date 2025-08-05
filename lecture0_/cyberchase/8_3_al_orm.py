from sqlalchemy import create_engine, Column, Integer, String, Date, func, select
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///cyberchase.db", echo=True)
LocalSession = sessionmaker(bind=engine)
Base = declarative_base()

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    episode_in_season = Column(Integer)
    air_date = Column(Date)


with LocalSession() as session:
    res = session.query(
        func.count(EpisodesTable.episode_in_season)
        ).filter(EpisodesTable.air_date.between("2018-01-01", "2023-12-31")
        ).scalar()

print(res)
