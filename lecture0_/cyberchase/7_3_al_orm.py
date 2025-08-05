from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

engine = create_engine("sqlite:///cyberchase.db", echo=True)
Base = declarative_base()
LocalSession = sessionmaker(bind=engine)

class EpisodesTable(Base):
    __tablename__ = "episodes"

    id = Column(Integer, primary_key=True)
    title = Column(String(50))
    topic = Column(String(50))

with LocalSession() as db_conn:
    result = db_conn.query(EpisodesTable.title, EpisodesTable.topic
                           ).where(EpisodesTable.topic.like("%fraction%"))

for r in result:
    print(r[0], "|", r[1])