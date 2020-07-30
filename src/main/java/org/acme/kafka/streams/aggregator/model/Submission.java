package org.acme.kafka.streams.aggregator.model;

import java.util.UUID;

public class Submission {

    public Submission() {
    }

    public Submission(String id, String timestamp_created, Float location_lng, Float location_lat, Submitter submitter, Sentiment sentiment) {
        this.id = id;
        this.timestamp_created = timestamp_created;
        this.location_lng = location_lng;
        this.location_lat = location_lat;
        this.submitter = submitter;
        this.sentiment = sentiment;
    }

    private String id;
    public String timestamp_created;
    public Float location_lng;
    public Float location_lat;
    public Submitter submitter;
    public Sentiment sentiment;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTimestamp_created() {
        return timestamp_created;
    }

    public void setTimestamp_created(String timestamp_created) {
        this.timestamp_created = timestamp_created;
    }

    public Float getLocation_lng() {
        return location_lng;
    }

    public void setLocation_lng(Float location_lng) {
        this.location_lng = location_lng;
    }

    public Float getLocation_lat() {
        return location_lat;
    }

    public void setLocation_lat(Float location_lat) {
        this.location_lat = location_lat;
    }

    public Submitter getSubmitter() {
        return submitter;
    }

    public void setSubmitter(Submitter submitter) {
        this.submitter = submitter;
    }

    public Sentiment getSentiment() {
        return sentiment;
    }

    public void setSentiment(Sentiment sentiment) {
        this.sentiment = sentiment;
    }

}
