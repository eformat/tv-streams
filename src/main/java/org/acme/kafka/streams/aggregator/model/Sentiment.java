package org.acme.kafka.streams.aggregator.model;

public class Sentiment {

    public Sentiment() {
    }

    public Sentiment(String stop_name, String stop_id, String route_type, String route_number, String route_id, String direction, String direction_id, String departure_time, String estimated_departure_time, boolean at_platform, String platform_number, String run_id, Integer capacity, Integer vibe) {
        this.stop_name = stop_name;
        this.stop_id = stop_id;
        this.route_type = route_type;
        this.route_number = route_number;
        this.route_id = route_id;
        this.direction = direction;
        this.direction_id = direction_id;
        this.departure_time = departure_time;
        this.estimated_departure_time = estimated_departure_time;
        this.at_platform = at_platform;
        this.platform_number = platform_number;
        this.run_id = run_id;
        this.capacity = capacity;
        this.vibe = vibe;
    }

    // route service fields
    public String stop_name;
    public String stop_id;
    public String route_type;
    public String route_number;
    public String route_id;
    public String direction;
    public String direction_id;
    public String departure_time;
    public String estimated_departure_time;
    public boolean at_platform;
    public String platform_number;
    public String run_id;

    // sentiment
    public Integer capacity;
    public Integer vibe;

    public String getStop_name() {
        return stop_name;
    }

    public void setStop_name(String stop_name) {
        this.stop_name = stop_name;
    }

    public String getStop_id() {
        return stop_id;
    }

    public void setStop_id(String stop_id) {
        this.stop_id = stop_id;
    }

    public String getRoute_type() {
        return route_type;
    }

    public void setRoute_type(String route_type) {
        this.route_type = route_type;
    }

    public String getRoute_number() {
        return route_number;
    }

    public void setRoute_number(String route_number) {
        this.route_number = route_number;
    }

    public String getRoute_id() {
        return route_id;
    }

    public void setRoute_id(String route_id) {
        this.route_id = route_id;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getDirection_id() {
        return direction_id;
    }

    public void setDirection_id(String direction_id) {
        this.direction_id = direction_id;
    }

    public String getDeparture_time() {
        return departure_time;
    }

    public void setDeparture_time(String departure_time) {
        this.departure_time = departure_time;
    }

    public String getEstimated_departure_time() {
        return estimated_departure_time;
    }

    public void setEstimated_departure_time(String estimated_departure_time) {
        this.estimated_departure_time = estimated_departure_time;
    }

    public boolean isAt_platform() {
        return at_platform;
    }

    public void setAt_platform(boolean at_platform) {
        this.at_platform = at_platform;
    }

    public String getPlatform_number() {
        return platform_number;
    }

    public void setPlatform_number(String platform_number) {
        this.platform_number = platform_number;
    }

    public String getRun_id() {
        return run_id;
    }

    public void setRun_id(String run_id) {
        this.run_id = run_id;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public Integer getVibe() {
        return vibe;
    }

    public void setVibe(Integer vibe) {
        this.vibe = vibe;
    }
}
