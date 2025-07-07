from sqlalchemy import create_engine, Column, Table, String, Integer
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///cyberchase.db", echo=True)
Base = declarative_base()
SessionLocal = sessionmaker(bind=engine)

class Episodes(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    season = Column(Integer)
    episode_in_season = Column(Integer)
    title = Column(String(50))
    topic = Column(String(50))
    air_date = Column(String(20))
    production_code = Column(String(20))

with SessionLocal() as session:
    titles = session.query(Episodes.title).where(Episodes.season == 1)

for title in titles:
    print(title[0])

