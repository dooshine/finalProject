package com.kh.idolsns;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling //스케쥴링 기능
@SpringBootApplication
public class IdolsnsApplication {

	public static void main(String[] args) {
		SpringApplication.run(IdolsnsApplication.class, args);
	}

}
