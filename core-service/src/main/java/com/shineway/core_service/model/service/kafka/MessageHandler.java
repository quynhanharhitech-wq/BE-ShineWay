package com.shineway.core_service.model.service.kafka;

public interface MessageHandler<T> {
    Class<T> targetType();
    void handle(T payload, String topic) throws Exception;
}
