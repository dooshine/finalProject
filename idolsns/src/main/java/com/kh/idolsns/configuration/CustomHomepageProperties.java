package com.kh.idolsns.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "custom.homepage")
public class CustomHomepageProperties {
    // 제재 기준 횟수
    private int SANCTION_CRITERIA_TOTAL_1;
    private int SANCTION_CRITERIA_TOTAL_2;
    private int SANCTION_CRITERIA_TOTAL_3;
    private int SANCTION_CRITERIA_MONTH;

    // 제재 일자
    private int SANCTION_TERM_TOTAL_1;
    private int SANCTION_TERM_TOTAL_2;
    private int SANCTION_TERM_TOTAL_3;
    private int SANCTION_TERM_MONTH;
}
