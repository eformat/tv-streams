# tv-streams project

kafka streams aggregator for tv-submit using rolling time window

Set sliding window in minutes. Pushes to topic named `submissions-aggregated-route-1`
```bash
export SOURCE_TOPIC=tripvibe; export KEY_NAME=route; export APP_ID=tv-streams; export WINDOW_MINUTES=1; mvn quarkus:dev
```

Source Topics:
```bash
tripvibe  - submissions keyed on route
tripvibe2 - submissions keyed on (route, type, direction, run, stop) 
```

Run multiple versions of app for different aggregate windows:
```bash
# 1 minute aggregate window, pushes to topic named submissions-aggregated-route-1
export SOURCE_TOPIC=tripvibe; export KEY_NAME=route; export APP_ID=tv-streams-r1; export WINDOW_MINUTES=1; mvn quarkus:dev -Dquarkus.http.port=8081 -Ddebug=5006

# 5 minute aggregate window, , pushes to topic named submissions-aggregated-route-5
export SOURCE_TOPIC=tripvibe; export KEY_NAME=route; export APP_ID=tv-streams-r5; export WINDOW_MINUTES=5; mvn quarkus:dev -Dquarkus.http.port=8082 -Ddebug=5007

# 1 minute aggregate window, pushes to topic named submissions-aggregated-trip-1
export SOURCE_TOPIC=tripvibe2; export KEY_NAME=trip; export APP_ID=tv-streams-t1; export WINDOW_MINUTES=1; mvn quarkus:dev -Dquarkus.http.port=8083 -Ddebug=5008

# 5 minute aggregate window, pushes to topic named submissions-aggregated-trip-5
export SOURCE_TOPIC=tripvibe2; export KEY_NAME=trip; export APP_ID=tv-streams-t5; export WINDOW_MINUTES=5; mvn quarkus:dev -Dquarkus.http.port=8084 -Ddebug=5009
```

Create compacted topic for aggregates
```bash
/opt/kafka_2.12-2.2.0/bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic submissions-aggregated-route-1 --replication-factor 1 --partitions 1 --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

/opt/kafka_2.12-2.2.0/bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic submissions-aggregated-route-5 --replication-factor 1 --partitions 1 --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

/opt/kafka_2.12-2.2.0/bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic submissions-aggregated-trip-1 --replication-factor 1 --partitions 1 --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

/opt/kafka_2.12-2.2.0/bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic submissions-aggregated-trip-5 --replication-factor 1 --partitions 1 --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"
```

Materlialize
```bash
psql -h localhost -p 6875 materialize -f ./load.sql

psql -h localhost -p 6875 materialize -c 'select * from AVERAGES_ROUTE_1;'

 key | count | capacityavg | capacitymax | capacitymin | vibeavg | vibemax | vibemin 
-----+-------+-------------+-------------+-------------+---------+---------+---------
 99  |    20 |          53 |          81 |          25 |      29 |      81 |      25
 216 |    20 |          38 |          66 |          10 |      54 |      66 |      10
 867 |    20 |          28 |          43 |          13 |      77 |      43 |      13
(3 rows)

psql -h localhost -p 6875 materialize -c 'select * from AVERAGES_TRIP_1;'

        key        | count | capacityavg | capacitymax | capacitymin | vibeavg | vibemax | vibemin 
-------------------+-------+-------------+-------------+-------------+---------+---------+---------
 99-1-28-13085-22  |    20 |          53 |          81 |          25 |      29 |      81 |      25
 216-1-28-13085-22 |    20 |          38 |          66 |          10 |      54 |      66 |      10
 867-1-28-13085-22 |    18 |          28 |          43 |          13 |      77 |      43 |      13
(3 rows)
```
