package com.kh.idolsns.advice;

//403번 대신 사용할 예외 클래스
//- response.sendError(403) 대신 
//- throw new RequiredPermissionException() 사용
//- 이렇게 해야 @ControllerAdvice에서 처리가 가능하기 때문
//- 예외 클래스가 되려면 Exception을 상속받아야 함
//- RuntimeException을 상속받으면 따로 예외 전가를 하지 않아도 됨
public class RequirePermissionException extends RuntimeException {
    public RequirePermissionException(String message) {
		super(message);
	}
}
