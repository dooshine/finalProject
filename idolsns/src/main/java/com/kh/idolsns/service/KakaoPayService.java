package com.kh.idolsns.service;

import java.net.URISyntaxException;

import com.kh.idolsns.vo.KakaoPayApproveRequestVO;
import com.kh.idolsns.vo.KakaoPayApproveResponseVO;
import com.kh.idolsns.vo.KakaoPayCancelRequestVO;
import com.kh.idolsns.vo.KakaoPayCancelResponseVO;
import com.kh.idolsns.vo.KakaoPayOrderRequestVO;
import com.kh.idolsns.vo.KakaoPayOrderResponseVO;
import com.kh.idolsns.vo.KakaoPayReadyRequestVO;
import com.kh.idolsns.vo.KakaoPayReadyResponseVO;


public interface KakaoPayService {
	
	//준비 ready
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO vo) throws URISyntaxException;
	
	//승인 approve
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO vo) throws URISyntaxException;
	
	
	//조회 order
	KakaoPayOrderResponseVO order(KakaoPayOrderRequestVO vo) throws URISyntaxException;
	
	//취소 cancel
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO vo) throws URISyntaxException;
	
}
