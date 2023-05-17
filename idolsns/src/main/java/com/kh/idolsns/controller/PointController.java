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

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.PaymentDto;
import com.kh.idolsns.repo.FundRepo;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.repo.PaymentRepo;
import com.kh.idolsns.service.KakaoPayService;
import com.kh.idolsns.vo.KakaoPayApproveRequestVO;
import com.kh.idolsns.vo.KakaoPayApproveResponseVO;
import com.kh.idolsns.vo.KakaoPayCancelRequestVO;
import com.kh.idolsns.vo.KakaoPayCancelResponseVO;
import com.kh.idolsns.vo.KakaoPayChargeRequestVO;
import com.kh.idolsns.vo.KakaoPayOrderRequestVO;
import com.kh.idolsns.vo.KakaoPayOrderResponseVO;
import com.kh.idolsns.vo.KakaoPayReadyRequestVO;
import com.kh.idolsns.vo.KakaoPayReadyResponseVO;


@Controller
@RequestMapping("/point")
public class PointController {

	
	@Autowired
	private KakaoPayService kakaoPayService;

	@Autowired
	private MemberRepo memberRepo;
	
	
	@Autowired
	private PaymentRepo paymentRepo;
	
	@Autowired
	private FundRepo fundRepo;

	
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
	
	
	
	//충전 성공 매핑 - 카카오페이가 불러주는 주소
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
		
		 // 결제 승인 요청
	    KakaoPayApproveResponseVO response = kakaoPayService.approve(vo);

	    // 충전된 금액을 포인트로 업데이트
	    KakaoPayChargeRequestVO chargeRequestVO = new KakaoPayChargeRequestVO();
	    chargeRequestVO.setMemberId((String) session.getAttribute("memberId"));
	    chargeRequestVO.setPaymentTotal(response.getAmount().getTotal());
	    System.out.println("chargeRequestVO: " + chargeRequestVO);
	    kakaoPayService.charge(chargeRequestVO);

	    // "redirect:clear"로 리다이렉트하여 clear 페이지로 이동
	    return "redirect:clear";
	}
	
	@GetMapping("/charge/clear")
	public String chargeClear(@RequestParam int paymentNo, Model model) throws URISyntaxException {
		
		PaymentDto paymentDto = paymentRepo.find(paymentNo);
		
	    // tid 값을 사용하여 주문 정보 조회
	    KakaoPayOrderRequestVO vo = new KakaoPayOrderRequestVO();
	    vo.setTid(paymentDto.getPaymentTid());
	    KakaoPayOrderResponseVO response = kakaoPayService.order(vo);
	  
	    // 주문 정보를 모델에 추가
	    model.addAttribute("response", response);
	    return "point/clear";
	}
	

	
	@GetMapping("/history")
	public String pointHistory(Model model, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		List<PaymentDto> list = paymentRepo.selectByMember(memberId);
		model.addAttribute("list", list);
	
		return "point/history";
	}
	
	
	
	
	@GetMapping("/detail")
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
	
	
	
	
	
	@GetMapping("/cancel")
	public String chargeCancel(
			@RequestParam int paymentNo, 
			HttpServletResponse resp,
			RedirectAttributes attr) throws URISyntaxException, IOException, NoHandlerFoundException {
		
		 
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
		paymentRepo.cancelRemain(paymentNo);
		
		 //[4] 포인트 차감
	    String memberId = paymentDto.getMemberId();
	    int paymentTotal = paymentDto.getPaymentTotal();
	    memberRepo.decreasePoint(memberId, paymentTotal);

	    //[5] 상세 페이지로 돌려보낸다
	    attr.addAttribute("paymentNo", paymentNo);
	    
	    return "redirect:detail";
	
	}

	
	///////////////////////////
	
	

	@GetMapping("/order") //사용 내역
	public String orderHistory(Model model, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		List<FundDto> list = fundRepo.selectByMember(memberId);
		model.addAttribute("list", list);
	
		return "point/order";
	}
	

		
}
