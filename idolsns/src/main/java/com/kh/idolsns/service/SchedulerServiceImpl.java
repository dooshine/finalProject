package com.kh.idolsns.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.idolsns.repo.MemberRepo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchedulerServiceImpl implements SchedulerService{

	@Autowired
	private MemberRepo memberRepo;
	
	@Scheduled(cron = "0 * * * * *")
	@Override
	public void clearMemberData() {
		log.debug("d");
		memberRepo.clean();
	}
	
}
