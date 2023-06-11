package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.MapDto;

public interface MapRepo {
	public void insert(MapDto mapDto);
	public MapDto selectOne(Long postNo);
	public void delete(Long postNo); 


	List<String> selectAll(Long postNo);


}
