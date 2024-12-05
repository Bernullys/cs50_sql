# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

    The observations will be evenly distributed. That is a good characteristic because it ensures that we are utilizing all the available space to store data.
    The researcher will need to run the query on all of the boats. Querying multiple databases will take more time to process the queries.
    If, for any reason, we lose one of the databases, we will lose that portion of the data.

## Partitioning by Hour

    The observations will not be evenly distributed. This could create an overloaded database and lead to the misuse of other databases.
    The researcher will need to run the query on only some of the boats. This will make querying more efficient.
    If, for any reason, we lose one of the databases, we will lose that portion of the data.

## Partitioning by Hash Value

    The observations will be evenly distributed. That is a good characteristic because it ensures that we are utilizing all the available space to store data.
    The researcher will need to run the query on all of the boats. The queries can be optimized if you're searching for a specific value, as the databases are designed in ranges of values. On the other hand, queries based on time-related data will be slower.
    If, for any reason, we lose one of the databases, we will lose that portion of the data.
