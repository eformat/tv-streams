package org.acme.kafka.streams.aggregator.streams;

import io.quarkus.kafka.client.serialization.JsonbSerde;
import org.acme.kafka.streams.aggregator.model.Aggregation;
import org.acme.kafka.streams.aggregator.model.Submission;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.common.utils.Bytes;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.*;
import org.apache.kafka.streams.state.WindowStore;
import org.eclipse.microprofile.config.inject.ConfigProperty;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;
import java.util.concurrent.TimeUnit;

@ApplicationScoped
public class TopologyProducer {

    @ConfigProperty(name = "streams.aggregate.window.minutes")
    int slidingWindow;

    private static final String SUBMISSIONS_TOPIC = "tripvibe";
    static final String SUBMISSIONS_STORE = "submissions-store";
    private static final String SUBMISSIONS_AGGREGATED_TOPIC = "submissions-aggregated";

    @Produces
    public Topology buildTopology() {
        StreamsBuilder builder = new StreamsBuilder();

        JsonbSerde<Aggregation> aggregationSerde = new JsonbSerde<>(Aggregation.class);
        JsonbSerde<Submission> submissionSerde = new JsonbSerde<>(Submission.class);

        KStream<Windowed<String>, Aggregation> windowed = builder.stream(
                SUBMISSIONS_TOPIC,
                Consumed.with(Serdes.String(), submissionSerde)
        )
                .groupByKey()
                .windowedBy(TimeWindows.of(TimeUnit.MINUTES.toMillis(slidingWindow)))
                .aggregate(
                        Aggregation::new,
                        (route_id, submission, aggregation) -> aggregation.updateFrom(submission),
                        Materialized.<String, Aggregation, WindowStore<Bytes, byte[]>>as(SUBMISSIONS_STORE)
                                .withKeySerde(Serdes.String())
                                .withValueSerde(aggregationSerde)
                ).toStream();

        KStream<String, Aggregation> rounded = windowed.map(((integerWindowed, aggregation) -> new KeyValue<>(integerWindowed.key(), aggregation)));
        rounded.to(
                SUBMISSIONS_AGGREGATED_TOPIC,
                Produced.with(Serdes.String(), aggregationSerde)
        );

        return builder.build();
    }
}
