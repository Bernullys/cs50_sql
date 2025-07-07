from sqlalchemy import create_engine, Column, String, Integer
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("sqlite:///cyberchase.db")
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class Episodes(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    season = Column(String(50))
    episode_in_season = Column(String(50))
    title = Column(String(50))
    topic = Column(String(50))
    air_date = Column(String(50))
    production_code = Column(String(20))

with LocalSession() as session:
    answer = session.query(Episodes.production_code).where(Episodes.title == "Hackerized!")


for a in answer:
    print(a[0])