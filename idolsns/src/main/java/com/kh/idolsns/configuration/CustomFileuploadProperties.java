package com.kh.idolsns.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "custom.filedir")
public class CustomFileuploadProperties {
    private String path;
}
