from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db")
Base = declarative_base()
SessionLocal = sessionmaker(bind=engine)

class Episodes(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    season = Column(Integer)
    episode_in_season = Column(Integer)
    title = Column(String(50))
    topic = Column(String(50))
    air_date = Column(String(50))
    production_code = Column(String(20))


with SessionLocal() as session:
    result = session.query(Episodes.season, Episodes.title).where(Episodes.episode_in_season == 1)

for r in result:
    print(r[0], r[1])