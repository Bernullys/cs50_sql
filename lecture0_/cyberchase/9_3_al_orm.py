from sqlalchemy import create_engine, Column, Integer, Date, func
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///cyberchase.db")
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    episode_in_season = Column(Integer)
    air_date = Column(Date)

stmt = func.count(EpisodesTable.episode_in_season).filter(EpisodesTable.air_date.between("2002-01-01", "2007-12-31"))

with LocalSession() as db_conn_session:
    result = db_conn_session.query(stmt)

for r in result:
    print(r[0])