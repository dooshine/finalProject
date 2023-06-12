<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     	<!-- 일정 등록 모달 -->
     	<div class="modal" tabindex="-1" role="dialog" id="addCalendarModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">일정 등록</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                    	<div class="beforeLogin">
                    		<h5 class="text-center mt-4">🙌</h5>
	                    	<h5 class="text-center mt-3 mb-4">로그인하고 중요한 일정을 등록해 보세요!</h5>
<%-- 	                    <a class="custom-btn btn-purple1 btn-round w-100 mb-4 calendar-login-btn" 
	                    			style="text-decoration: none; width: 100%" href="${pageContext.request.contextPath}/member/login">
								로그인하러 가기
							</a> --%>
							<button type="button" class="custom-btn btn-purple1 btn-round w-100 mb-4 calendar-login-btn">
								로그인하러 가기
							</button>
						</div>
                    	<div class="afterLogin">
	                    	<div class="form-floating mb-3">
								<input type="text" readonly class="form-control-plaintext" id="scheduleDate" placeholder="dd">
								<label for="scheduleDate" class="startDate">날짜</label>
							</div>
	                   		<div class="form-floating mb-3">
								<input type="text" class="form-control" id="calendarTitle" placeholder="dd">
								<label for="calendarTitle">일정 이름</label>
								<div class="display-none invalidMessage">
							    	1글자 이상, 30글자 이하로 입력할 수 있습니다.
							    </div>
							</div>
	                   		<div class="form-floating">
								<textarea class="form-control" placeholder="Leave a comment here" id="calendarMemo" style="height: 100px; resize: none;"></textarea>
								<label for="calendarMemo">메모</label>
								<div class="display-none invalidMessage">
							    	100글자 이하로 입력할 수 있습니다.
							    </div>
							</div>
						</div>
                    </div>
                    <div class="modal-footer addCalendarModalFooter">
                        <button type="button" class="addSchedule-btn custom-btn btn-purple1">
                            등록
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 일정 상세, 수정 모달 -->
     	<div class="modal" tabindex="-1" role="dialog" id="detailCalendarModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                	<!-- 상세 -->
                	<div class="calendarDetailModal">
	                    <div class="modal-header">
	                        <h5 class="modal-title">일정 상세정보</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">
	                   		<div class="form-floating mb-3">
								<input type="text" readonly class="form-control-plaintext" id="detailCalendarDate" placeholder="dd">
								<label for="detailScheduleDate" class="startDate">날짜</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" readonly class="form-control-plaintext" id="detailCalendarTitle" placeholder="dd">
								<label for="detailScheduleTitle" class="startDate">일정 이름</label>
							</div>
							<div class="form-floating" style="height: auto;">
								<div class="form-control-plaintext" id="detailCalendarMemo" style="white-space:pre; height: auto;"></div>
								<label for="calendarMemo">메모</label>
							</div>
	                    </div>
	                    
	                    <!-- 일정 삭제 경고 모달 -->
				        <div class="custom-modal" style="display:none;" id="deleteAlertModal">
					        <div class="custom-modal-body">
					        	<div class="text-center mb-3">
					        		<i class="ti ti-alert-triangle"></i>
					        	</div>
					        	<div class="text-center">삭제한 일정은 복구할 수 없습니다.</div>
					        	<div class="text-center">일정을 정말 삭제하시겠습니까?</div>
					        	<div class="d-flex justify-content-center mt-4">
					        		<button class="custom-btn btn-round btn-purple1-secondary me-2 w-100" id="delete-schedule">삭제</button>
					        		<button class="custom-btn btn-round btn-purple1 w-100" id="delete-cancel">취소</button>
					        	</div>
					        </div>
					    </div>
	                    
	                    <div class="modal-footer">
	                        <button type="button" class="delete-schedule-btn custom-btn btn-purple1-secondary">
	                            삭제
	                        </button>
	                        <button type="button" class="edit-schedule-btn custom-btn btn-purple1">
	                            수정
	                        </button>
	                    </div>
                    </div>
                    <!-- 수정 -->
                	<div class="calendarEditModal">
	                    <div class="modal-header">
	                        <h5 class="modal-title">일정 수정</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">
	                    	<div class="form-floating mb-3">
								<input type="text" readonly class="form-control-plaintext" id="scheduleDateEdit" placeholder="dd">
								<label for="scheduleDateEdit" class="startDate">날짜</label>
							</div>
	                   		<div class="form-floating mb-3">
								<input type="text" class="form-control" id="calendarTitleEdit" placeholder="dd">
								<label for="calendarTitleEdit">일정 이름</label>
								<div class="display-none invalidMessage">
							    	1글자 이상, 30글자 이하로 입력할 수 있습니다.
							    </div>
							</div>
	                   		<div class="form-floating">
								<textarea class="form-control" placeholder="Leave a comment here" id="calendarMemoEdit" style="height: 100px; resize: none;"></textarea>
								<label for="calendarMemoEdit">메모</label>
								<div class="display-none invalidMessage">
							    	100글자 이하로 입력할 수 있습니다.
							    </div>
							</div>
	                    </div>
	                    <div class="modal-footer">
	                        <button type="button" class="cancel-edit-btn custom-btn btn-purple1-secondary">
	                            취소
	                        </button>
	                        <button type="button" class="edit-confirn-btn custom-btn btn-purple1">
	                            수정
	                        </button>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
     
		<div id='calendar' class="custom-shadow">
		</div>
   
	
   