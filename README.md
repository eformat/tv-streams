# tv-streams project

kafka streams aggregator for tv-submit using rolling time window

Set sliding window in minutes. Pushes to topic named `submissions-aggregated-1`
```bash
export APP_ID=tv-streams; export WINDOW_MINUTES=1; mvn quarkus:dev
```

Run multiple versions of app for different aggregate windows:
```bash
# 1 minute aggregate window, pushes to topic named submissions-aggregated-1
export APP_ID=tv-streams-5; export WINDOW_MINUTES=5; mvn quarkus:dev -Dquarkus.http.port=8081 -Ddebug=5006

# 5 minute aggregate window, , pushes to topic named submissions-aggregated-5
export APP_ID=tv-streams-5; export WINDOW_MINUTES=5; mvn quarkus:dev -Dquarkus.http.port=8082 -Ddebug=5007
```

Create compacted topic for aggrgates
```bash
/opt/kafka_2.12-2.2.0/bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic submissions-aggregated-1 --replication-factor 1 --partitions 1 --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"
```

Materlialize
```bash
psql -h localhost -p 6875 materialize -f ./load.sql

psql -h localhost -p 6875 materialize -c 'select * from AVERAGES1;'

 route_id | count | capacityavg | capacitymax | capacitymin | vibeavg | vibemax | vibemin 
----------+-------+-------------+-------------+-------------+---------+---------+---------
 99       |    28 |          53 |          81 |          25 |      29 |      81 |      25
 216      |    28 |          38 |          66 |          10 |      54 |      66 |      10
 867      |    27 |        28.6 |          43 |          13 |    76.8 |      43 |      13
(3 rows)
```
