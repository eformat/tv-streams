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
