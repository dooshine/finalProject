package com.kh.idolsns.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.idolsns.repo.FundPostRepo;
import com.kh.idolsns.repo.MemberRepo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchedulerServiceImpl implements SchedulerService{

	@Autowired
	private MemberRepo memberRepo;
	
	@Autowired
	private FundPostRepo fundPostRepo;
	
	@Scheduled(cron = "0 0 0 * * *")
	@Override
	public void clearMemberData() {
		//log.debug("d");
		memberRepo.clean();
	}
	
	// 매일 자정에 펀딩상태 업데이트
	@Scheduled(cron = "0 0 0 * * *")
	@Override
	public void updateFundState() {
		fundPostRepo.updateFundState();
		//log.debug("펀딩상태 업데이트 완료!");
	}
	
}
