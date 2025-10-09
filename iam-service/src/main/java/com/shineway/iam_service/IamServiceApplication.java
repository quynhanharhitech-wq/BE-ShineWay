package com.shineway.iam_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = {"com.shineway.iam-service", "com.shineway.core_service"})
@EnableJpaRepositories(basePackages = "com.shineway.iam-service.model.repo")
@EntityScan(basePackages = "com.shineway.iam-service.model.entities")
public class IamServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(IamServiceApplication.class, args);
	}

}
