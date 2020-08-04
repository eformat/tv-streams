CREATE SOURCE avgr1
--FROM KAFKA BROKER 'localhost:9092' TOPIC 'submissions-aggregated-route-1'
FROM KAFKA BROKER 'tv-cluster-kafka-bootstrap:9092' TOPIC 'submissions-aggregated-route-1'
FORMAT TEXT
ENVELOPE UPSERT;

CREATE MATERIALIZED VIEW AVERAGES_ROUTE_1 AS
    SELECT (text::JSONB)->>'key' as key,
           CAST((text::JSONB)->'count' as int) as count,
           CAST((text::JSONB)->'capacityAvg' as float) as capacityAvg,
           CAST((text::JSONB)->'capacityMax' as int) as capacityMax,
           CAST((text::JSONB)->'capacityMin' as float) as capacityMin,
           CAST((text::JSONB)->'capacitySum' as float) as capacitySum,
           CAST((text::JSONB)->'vibeAvg' as float) as vibeAvg,
           CAST((text::JSONB)->'vibeMax' as int) as vibeMax,
           CAST((text::JSONB)->'vibeMin' as float) as vibeMin,
           CAST((text::JSONB)->'vibeSum' as float) as vibeSum
    FROM (SELECT * FROM avgr1);

CREATE SOURCE avgr5
--FROM KAFKA BROKER 'localhost:9092' TOPIC 'submissions-aggregated-route-5'
FROM KAFKA BROKER 'tv-cluster-kafka-bootstrap:9092' TOPIC 'submissions-aggregated-route-5'
FORMAT TEXT
ENVELOPE UPSERT;

CREATE MATERIALIZED VIEW AVERAGES_ROUTE_5 AS
    SELECT (text::JSONB)->>'key' as key,
           CAST((text::JSONB)->'count' as int) as count,
           CAST((text::JSONB)->'capacityAvg' as float) as capacityAvg,
           CAST((text::JSONB)->'capacityMax' as int) as capacityMax,
           CAST((text::JSONB)->'capacityMin' as float) as capacityMin,
           CAST((text::JSONB)->'capacitySum' as float) as capacitySum,
           CAST((text::JSONB)->'vibeAvg' as float) as vibeAvg,
           CAST((text::JSONB)->'vibeMax' as int) as vibeMax,
           CAST((text::JSONB)->'vibeMin' as float) as vibeMin,
           CAST((text::JSONB)->'vibeSum' as float) as vibeSum
    FROM (SELECT * FROM avgr5);

CREATE SOURCE avgt1
--FROM KAFKA BROKER 'localhost:9092' TOPIC 'submissions-aggregated-trip-1'
FROM KAFKA BROKER 'tv-cluster-kafka-bootstrap:9092' TOPIC 'submissions-aggregated-trip-1'
FORMAT TEXT
ENVELOPE UPSERT;

CREATE MATERIALIZED VIEW AVERAGES_TRIP_1 AS
    SELECT (text::JSONB)->>'key' as key,
           CAST((text::JSONB)->'count' as int) as count,
           CAST((text::JSONB)->'capacityAvg' as float) as capacityAvg,
           CAST((text::JSONB)->'capacityMax' as int) as capacityMax,
           CAST((text::JSONB)->'capacityMin' as float) as capacityMin,
           CAST((text::JSONB)->'capacitySum' as float) as capacitySum,
           CAST((text::JSONB)->'vibeAvg' as float) as vibeAvg,
           CAST((text::JSONB)->'vibeMax' as int) as vibeMax,
           CAST((text::JSONB)->'vibeMin' as float) as vibeMin,
           CAST((text::JSONB)->'vibeSum' as float) as vibeSum
    FROM (SELECT * FROM avgt1);

CREATE SOURCE avgt5
--FROM KAFKA BROKER 'localhost:9092' TOPIC 'submissions-aggregated-trip-5'
FROM KAFKA BROKER 'tv-cluster-kafka-bootstrap:9092' TOPIC 'submissions-aggregated-trip-5'
FORMAT TEXT
ENVELOPE UPSERT;

CREATE MATERIALIZED VIEW AVERAGES_TRIP_5 AS
    SELECT (text::JSONB)->>'key' as key,
           CAST((text::JSONB)->'count' as int) as count,
           CAST((text::JSONB)->'capacityAvg' as float) as capacityAvg,
           CAST((text::JSONB)->'capacityMax' as int) as capacityMax,
           CAST((text::JSONB)->'capacityMin' as float) as capacityMin,
           CAST((text::JSONB)->'capacitySum' as float) as capacitySum,
           CAST((text::JSONB)->'vibeAvg' as float) as vibeAvg,
           CAST((text::JSONB)->'vibeMax' as int) as vibeMax,
           CAST((text::JSONB)->'vibeMin' as float) as vibeMin,
           CAST((text::JSONB)->'vibeSum' as float) as vibeSum
    FROM (SELECT * FROM avgt5);
