package com.kh.idolsns.repo;
import com.kh.idolsns.dto.NotiDto;

public interface NotiRepo {

	void insert(NotiDto dto);
	int sequence();
	void delete(int notiNo);
	
}
