package com.shineway.core_service.model.service.kafka;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import static org.springframework.kafka.support.KafkaHeaders.RECEIVED_TOPIC;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class KafkaConsumer<T> {

    private static final Logger LOGGER = LoggerFactory.getLogger(KafkaProducer.class);

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private MessageHandler<T> handler;

    @KafkaListener(
        topics = "${app.kafka.topics:shineway.default}",
        groupId = "${spring.kafka.consumer.group-id:shineway-core}",
        containerFactory = "stringKafkaListenerFactory"
    )
    public void consume(String json, @Header(RECEIVED_TOPIC) String topic) {
        try {
            Class<T> type = handler.targetType();
            T obj = objectMapper.readValue(json, type);  // deserialize về đúng T
            LOGGER.info("Consumed topic={} type={} json={}", topic, type.getName(), json);
            handler.handle(obj, topic);
        } catch (Exception e) {
            LOGGER.error("Failed to consume message", e);
        }
    }

}
