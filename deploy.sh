#!/bin/bash

REPLICATION=1
PARTITIONS=1

oc exec -it tv-cluster-kafka-0 -- bin/kafka-topics.sh --bootstrap-server tv-cluster-kafka-bootstrap:9092 --create --topic submissions-aggregated-route-1 --replication-factor ${REPLICATION} --partitions ${PARTITIONS} --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

oc exec -it tv-cluster-kafka-0 -- bin/kafka-topics.sh --bootstrap-server tv-cluster-kafka-bootstrap:9092 --create --topic submissions-aggregated-route-5 --replication-factor ${REPLICATION} --partitions ${PARTITIONS} --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

oc exec -it tv-cluster-kafka-0 -- bin/kafka-topics.sh --bootstrap-server tv-cluster-kafka-bootstrap:9092 --create --topic submissions-aggregated-trip-1 --replication-factor ${REPLICATION} --partitions ${PARTITIONS} --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

oc exec -it tv-cluster-kafka-0 -- bin/kafka-topics.sh --bootstrap-server tv-cluster-kafka-bootstrap:9092 --create --topic submissions-aggregated-trip-5 --replication-factor ${REPLICATION} --partitions ${PARTITIONS} --config "cleanup.policy=compact" --config "delete.retention.ms=100"  --config "segment.ms=100" --config "min.cleanable.dirty.ratio=0.01"

oc new-app --as-deployment-config --docker-image=quay.io/eformat/tv-streams:latest --name tv-streams-route-1
oc set env dc/tv-streams-route-1 SOURCE_TOPIC=tripvibe KEY_NAME=route APP_ID=tv-streams-route-1 WINDOW_MINUTES=1

oc new-app --as-deployment-config --docker-image=quay.io/eformat/tv-streams:latest --name tv-streams-route-5
oc set env dc/tv-streams-route-5 SOURCE_TOPIC=tripvibe KEY_NAME=route APP_ID=tv-streams-route-5 WINDOW_MINUTES=5

oc new-app --as-deployment-config --docker-image=quay.io/eformat/tv-streams:latest --name tv-streams-trip-1
oc set env dc/tv-streams-trip-1 SOURCE_TOPIC=tripvibe2 KEY_NAME=trip APP_ID=tv-streams-trip-1 WINDOW_MINUTES=1

oc new-app --as-deployment-config --docker-image=quay.io/eformat/tv-streams:latest --name tv-streams-trip-5
oc set env dc/tv-streams-trip-5 SOURCE_TOPIC=tripvibe2 KEY_NAME=trip APP_ID=tv-streams-trip-5 WINDOW_MINUTES=5
