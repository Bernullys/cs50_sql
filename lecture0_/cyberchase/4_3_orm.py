from sqlalchemy import create_engine, select, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db", echo=True)
LocalSession = sessionmaker(bind=engine)
Base = declarative_base()

class TableEpisodes(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    season = Column(Integer)
    episodes_in_season = Column(Integer)
    title = Column(String(50))
    topic = Column(String(50))
    air_date = Column(String(15))
    production_code = Column(String(10))


with LocalSession() as session:
    result = session.query(TableEpisodes.title).where(TableEpisodes.topic == None)

for r in result:
    print(r[0])