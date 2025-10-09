package com.shineway.core_service.model.service.kafka;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KafkaProducer<T> {
    private static final Logger LOGGER = LoggerFactory.getLogger(KafkaProducer.class);

    private KafkaTemplate<String, T> kafkaTemplate;

    public KafkaProducer(KafkaTemplate<String, T> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    @Autowired
    ObjectMapper objectMapper;

    public void sendMessage(T t, String topic) {
        try {
            LOGGER.info("Sending Kafka message: {} => {}", t.getClass().getSimpleName(), objectMapper.writeValueAsString(t));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // create message
        Message<T> message = MessageBuilder
                .withPayload(t)
                .setHeader(KafkaHeaders.TOPIC, topic)
                .build();
        kafkaTemplate.send(message);
    }

}

