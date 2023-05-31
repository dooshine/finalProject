package com.kh.idolsns.repo;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;

@Repository
public class FundPostRepoImpl implements FundPostRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private FundPostImageRepo fundPostImageRepo;
	
	@Override
	public void insert(FundPostDto dto) {
		sqlSession.insert("fundPost.add", dto);
	}

	@Override
	public List<FundPostDto> selectList() {
		return sqlSession.selectList("fundPost.selectList");
	}

	@Override
	public FundPostDto selectOne(Long postNo) {
		return sqlSession.selectOne("fundPost.selectOne", postNo);
	}

	@Override
	public boolean update(FundPostDto dto) {
		return sqlSession.update("fundPost.edit", dto) > 0;
	}

	@Override
	public void connect(PostImageDto postImageDto) {
		sqlSession.insert("fundPost.connect", postImageDto);
	}

	@Override
	public boolean sponsorCount(FundPostDto fundPostDto) {
		return sqlSession.update("fundPost.sponsorCount", fundPostDto) > 0;
	}

	@Override
	public void updateFundState() {
		// total값 포함& 모든 펀딩게시물 리스트 조회
		List<FundPostImageDto> list = fundPostImageRepo.selectList();
		// 임시 리스트 생성
		List<FundPostImageDto> templist = new ArrayList<>();
		// 오늘날짜 설정
		LocalDate currentDate = LocalDate.now();
		for(FundPostImageDto dto : list) {
			LocalDate postEnd = dto.getPostEnd().toLocalDate();
			if(currentDate.isAfter(postEnd)) { // 현재날짜가 마감날짜를 지났으면
				templist.add(dto); // 임시 리스트에 저장
			}
		}
		
		for(FundPostImageDto dto: templist) {
			// 모금액이 목표액과 같거나 많을 경우 ( 펀딩 성공 )
			if(dto.getTotalPrice() >= dto.getFundGoal()) {
				sqlSession.update("fundPost.updateFundSuccess", dto.getPostNo());
			}
			// 모금액이 목표액에 못미치는 경우 ( 펀딩 무산 )
			else { 
				sqlSession.update("fundPost.updateFundFail", dto.getPostNo());
			}
		}
	}

//	@Override
//	public void connect(Long postNo, int attachmentNo) {
//		Map<String, Object> parameters = new HashMap<>();
//		parameters.put("param1", postNo);
//		parameters.put("param2", attachmentNo);
//		sqlSession.insert("fundPost.connect", parameters);
//	}



}
