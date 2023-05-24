package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.PaymentDto;
import com.kh.idolsns.repo.FundRepo;
import com.kh.idolsns.repo.PaymentRepo;


@CrossOrigin
@RestController
@RequestMapping("/rest/point")
public class PointRestController {

	
	@Autowired 
	private PaymentRepo paymentRepo;
	
	@Autowired
	private FundRepo fundRepo;
	
	@GetMapping("/history/{memberId}")
    public List<PaymentDto> selectByMember(@PathVariable String memberId) {
        // memberId를 사용하여 해당 멤버의 충전 내역을 페이지별로 조회하는 로직을 작성해주세요.
        // page와 size를 활용하여 페이지네이션을 구현하고, 조회 결과인 PaymentDto 리스트를 반환합니다.
        // 예시로 임시로 생성한 PaymentDto 리스트를 반환합니다.
        
	return paymentRepo.selectByMember(memberId);
    }
	
	//디테일
	@GetMapping("/{paymentNo}")
    public PaymentDto find(@PathVariable int paymentNo) {
	 	PaymentDto paymentDto = paymentRepo.find(paymentNo);
	    return paymentDto;
    }
	
	
	
	
	@GetMapping("/order/{memberId}")
    public List<FundDto> selectByMember2(@PathVariable String memberId) {
        // memberId를 사용하여 해당 멤버의 충전 내역을 페이지별로 조회하는 로직을 작성해주세요.
        // page와 size를 활용하여 페이지네이션을 구현하고, 조회 결과인 PaymentDto 리스트를 반환합니다.
        // 예시로 임시로 생성한 PaymentDto 리스트를 반환합니다.
        
		return fundRepo.selectByMember(memberId);
    }
}