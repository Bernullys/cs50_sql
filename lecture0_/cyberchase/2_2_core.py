from sqlalchemy import create_engine, MetaData, Table, select

engine = create_engine("sqlite:///cyberchase.db")
metadata = MetaData()
re_episodes = Table("episodes", metadata, autoload_with=engine)

stmt = select(re_episodes.c.season, re_episodes.c.title).where(re_episodes.c.episode_in_season == 1)

with engine.connect() as session:
    result = session.execute(stmt)

for r in result:
    print(r[0], r[1])