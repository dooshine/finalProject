package com.kh.idolsns.vo;

public class KakaoPayChargeRequestVO {
	   private String memberId;
	    private int paymentTotal;

	    public String getMemberId() {
	        return memberId;
	    }

	    public void setMemberId(String memberId) {
	        this.memberId = memberId;
	    }

	    public int getPaymentTotal() {
	        return paymentTotal;
	    }

	    public void setPaymentTotal(int paymentTotal) {
	        this.paymentTotal = paymentTotal;
	    }
	}
