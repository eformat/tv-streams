CREATE SOURCE subs1
FROM KAFKA BROKER 'localhost:9092' TOPIC 'submissions-aggregated-1'
FORMAT TEXT
ENVELOPE UPSERT;

CREATE MATERIALIZED VIEW AVERAGES1 AS
    SELECT (text::JSONB)->>'route_id' as route_id,
           CAST((text::JSONB)->'count' as int) as count,
           CAST((text::JSONB)->'capacityAvg' as float) as capacityAvg,
           CAST((text::JSONB)->'capacityMax' as int) as capacityMax,
           CAST((text::JSONB)->'capacityMin' as float) as capacityMin,
           CAST((text::JSONB)->'vibeAvg' as float) as vibeAvg,
           CAST((text::JSONB)->'vibeMax' as int) as vibeMax,
           CAST((text::JSONB)->'vibeMin' as float) as vibeMin
    FROM (SELECT * FROM subs1);

CREATE SOURCE subs5
FROM KAFKA BROKER 'localhost:9092' TOPIC 'submissions-aggregated-5'
FORMAT TEXT
ENVELOPE UPSERT;

CREATE MATERIALIZED VIEW AVERAGES5 AS
    SELECT (text::JSONB)->>'route_id' as route_id,
           CAST((text::JSONB)->'count' as int) as count,
           CAST((text::JSONB)->'capacityAvg' as float) as capacityAvg,
           CAST((text::JSONB)->'capacityMax' as int) as capacityMax,
           CAST((text::JSONB)->'capacityMin' as float) as capacityMin,
           CAST((text::JSONB)->'vibeAvg' as float) as vibeAvg,
           CAST((text::JSONB)->'vibeMax' as int) as vibeMax,
           CAST((text::JSONB)->'vibeMin' as float) as vibeMin
    FROM (SELECT * FROM subs5);
