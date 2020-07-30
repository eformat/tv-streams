package org.acme.kafka.streams.aggregator.model;

import io.quarkus.runtime.annotations.RegisterForReflection;

import java.math.BigDecimal;
import java.math.RoundingMode;

@RegisterForReflection
public class Aggregation {
    public String route_id;

    public int count;

    public double capacityMin = Double.MAX_VALUE;
    public double capacityMax = Double.MIN_VALUE;
    public double capacitySum;
    public double capacityAvg;

    public double vibeMin = Double.MAX_VALUE;
    public double vibeMax = Double.MIN_VALUE;
    public double vibeSum;
    public double vibeAvg;

    public Aggregation updateFrom(Submission submission) {
        route_id = submission.getSentiment().getRoute_id();

        count++;
        capacitySum += submission.getSentiment().getCapacity();
        vibeSum += submission.getSentiment().getVibe();

        capacityAvg = BigDecimal.valueOf(capacitySum / count)
                .setScale(1, RoundingMode.HALF_UP).doubleValue();
        vibeAvg = BigDecimal.valueOf(vibeSum / count)
                .setScale(1, RoundingMode.HALF_UP).doubleValue();

        capacityMin = Math.min(capacityMin, submission.getSentiment().getCapacity());
        capacityMax = Math.max(capacityMax, submission.getSentiment().getCapacity());
        vibeMin = Math.min(vibeMin, submission.getSentiment().getCapacity());
        vibeMax = Math.max(vibeMax, submission.getSentiment().getCapacity());

        return this;
    }
}
