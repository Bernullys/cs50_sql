Notes from solving these problems.

Using sqlite:
    1- Import sqlite3:
        import sqlite3
    2- Connect the db:
        db_conn = sqlite3.connect("db_path")
    3- Create a cursor:
        db_cursor = db_conn.cursor()
    4- Execute the statement:
        db_cursor.execute(
            '''
                SELECT ....
                FROM ...
                WHERE ... = ?
            ''',(here comes the variables, and also here we should
            type a tuple. If is only one variable, we should add a ,)
        )
    5- Then fetch the results with:
        db_cursor.fetchall()    returns a list of tuples.
        or
        db_cursor.fetchone()    returns a tuple.
        or
        db_cursor.fetchmany(n)  returns a list of n tuples.
    From step 2 we can use context manager to be more efficient.

Using sqlalchemy core:
    1- Imports:
        from sqlalchemy import create_engine, Table, MetaData, select ...
    2- Creates an engine variable to connect the db:
        engine = create_engine("db_type:///path_to_db")
    3- Creates an instance of MetaData
        metadata = MetaData()
    4- Reflects the table:
        reflected_table = Table("table_name", metadata, autoload_with=engine)
    5- Creates the connection using context manager:
        with engine.connect() as db_conn:
            results = db_conn.execute(select(reflected_table.c.column_name))
