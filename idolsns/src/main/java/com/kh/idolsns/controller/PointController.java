package com.kh.idolsns.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.dto.PaymentDto;
import com.kh.idolsns.repo.PaymentRepo;
import com.kh.idolsns.service.KakaoPayService;
import com.kh.idolsns.vo.KakaoPayApproveRequestVO;
import com.kh.idolsns.vo.KakaoPayApproveResponseVO;
import com.kh.idolsns.vo.KakaoPayCancelRequestVO;
import com.kh.idolsns.vo.KakaoPayCancelResponseVO;
import com.kh.idolsns.vo.KakaoPayOrderRequestVO;
import com.kh.idolsns.vo.KakaoPayOrderResponseVO;
import com.kh.idolsns.vo.KakaoPayReadyRequestVO;
import com.kh.idolsns.vo.KakaoPayReadyResponseVO;


@Controller
@RequestMapping("/point")
public class PointController {

	
	@Autowired
	private KakaoPayService kakaoPayService;

	
	
	

	
	@GetMapping("/history") //충전 내역
	public String history() {
		return "point/history";
	}
	
	
	@GetMapping("/order") //사용 내역
	public String orderHistory() {
		return "point/order";
	}
	

	
	
	
	
	
	//포인트 충전 페이지
	@GetMapping("/charge")
	public String charge() {
		return "point/charge";
	}
	
	@PostMapping("/charge")
	public String charge(@ModelAttribute KakaoPayReadyRequestVO vo,
			HttpSession session) throws URISyntaxException {
		//정보추가(주문자번호, 주문번호)
		vo.setPartner_order_id(UUID.randomUUID().toString());
		vo.setPartner_user_id((String) session.getAttribute("memberId"));
		vo.setItem_name("포인트충전");
		
		
		
		//준비요청
		KakaoPayReadyResponseVO response = kakaoPayService.ready(vo);
		
		//세션에 데이터 임시 첨부(partner_order_id, partner_user_id, tid)
		session.setAttribute("partner_order_id", vo.getPartner_order_id());
		session.setAttribute("partner_user_id", vo.getPartner_user_id());
		session.setAttribute("tid", response.getTid());
		
		//사용자를 결제페이지로 리다이렉트
		return "redirect:" + response.getNext_redirect_pc_url();
	}
	
	
	
	//test1 결제 성공 매핑 - 카카오페이가 불러주는 주소
	@GetMapping("/charge/success")
	public String chargeSuccess(
			//@RequestParam String pg_token
			@ModelAttribute KakaoPayApproveRequestVO vo,
			HttpSession session
			) throws URISyntaxException {
		//partner_order_id, partner_user_id, tid, pg_token 필요하지만
		//메소드에는 pg_token밖에 없다
		//승인을 하기 위해서는 *준비 단계에서 만든 정보*가 필요하다
		//-> 같은 브라우저에서만 데이터가 전달되도록 HttpSession을 사용
		
		//세션에 첨부된 임시 데이터 추출/삭제(partner_order_id, partner_user_id, tid)
		vo.setPartner_order_id((String)session.getAttribute("partner_order_id"));
		vo.setPartner_user_id((String)session.getAttribute("partner_user_id"));
		vo.setTid((String)session.getAttribute("tid"));
		
		session.removeAttribute("partner_order_id");
		session.removeAttribute("partner_user_id");
		session.removeAttribute("tid");
		
		KakaoPayApproveResponseVO response = kakaoPayService.approve(vo);
		
	
		return "redirect:clear";
	}
	
	@GetMapping("/charge/clear")
	public String chargeClear(HttpSession session) {
		// memberId 정보를 세션에서 가져옴
	    String memberId = (String) session.getAttribute("memberId");
	    session.setAttribute("memberId", memberId);
	    
	    return "point/clear";
	}
	
	/////
	
	
	@Autowired
	private PaymentRepo paymentRepo;
	
	@GetMapping("/point/history")
	public String list(Model model, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		List<PaymentDto> list = paymentRepo.selectByMember(memberId);
		model.addAttribute("list", list);
		//return "/WEB-INF/views/pay/list.jsp";
		return "point/history";
	}
	
	@GetMapping("/point/detail")
	public String detail(@RequestParam int paymentNo, Model model) throws URISyntaxException {
		//우리 DB에서 정보를 찾아라
		PaymentDto paymentDto = paymentRepo.find(paymentNo);
		
		//찾은 정보에서 TID를 조회하여 카카오페이에서 실제 정보를 조회하라
		KakaoPayOrderRequestVO vo = new KakaoPayOrderRequestVO();
		vo.setTid(paymentDto.getPaymentTid());
		KakaoPayOrderResponseVO response = kakaoPayService.order(vo);
		
		//모든 정보를 Model에 첨부
		model.addAttribute("paymentDto", paymentDto);
		model.addAttribute("response", response);
		
		//상세 페이지 반환
		return "point/detail"; //"/WEB-INF/views/pay/detail.jsp"
	}
	
	@GetMapping("/point/cancel")
	public String chargeCancel(
			@RequestParam int paymentNo, 
			HttpServletResponse resp,
			RedirectAttributes attr) throws URISyntaxException, IOException, NoHandlerFoundException {
		
		 String memberId = (String) session.getAttribute("memberId");
		
		 
		 
		 
		//[1] paymentNo로 PaymentDto 정보를 조회
		PaymentDto paymentDto = paymentRepo.find(paymentNo);
		if(paymentDto == null || paymentDto.getPaymentRemain() == 0) {
			//resp.sendError(500);//사용자에게 500번을 내보내라
			//return null;
			throw new NoHandlerFoundException(null, null, null);
		}
		
		//[2] 1번에서 구한 정보의 TID와 잔여금액 정보로 카카오에게 취소 요청
		KakaoPayCancelRequestVO vo = new KakaoPayCancelRequestVO();
		vo.setTid(paymentDto.getPaymentTid());
		vo.setCancel_amount(paymentDto.getPaymentRemain());
		
		KakaoPayCancelResponseVO response = kakaoPayService.cancel(vo);
		
		//[3] 내 DB의 잔여 금액을 0으로 변경(paymentRepo)
		//paymentRepo.cancelRemain(paymentNo);
		
		//[4] 상세 페이지로 돌려보낸다
		//return "redirect:detail?paymentNo="+paymentNo;
		attr.addAttribute("paymentNo", paymentNo);
		
		
		
		
		
		
		// 해당 유저의 포인트를 조회합니다.
		  int point = pointService.getPoint(memberId);
		 
		  // 포인트를 차감합니다.
		  int amount = (int) session.getAttribute("amount");
		  pointService.decreasePoint(memberId, amount);
		  
		  // 변경된 포인트를 세션에 저장합니다.
		  session.setAttribute("point", point - amount);
		
		
		
		
		
		return "redirect:detail";
	}
	
	

	
}