package com.gn.sungha.configuration;

import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;

public class DatabaseConfiguration {

	@Bean
	@ConfigurationProperties(prefix = "spring.datasource.hikari")
	public DataSource dataSource() {
		return DataSourceBuilder.create().build();
	}

}
