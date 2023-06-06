<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<style>
			:root {
			  --fc-small-font-size: .85em;
			  --fc-page-bg-color: #fff;
			  --fc-neutral-bg-color: rgba(208, 208, 208, 0.3);
			  --fc-neutral-text-color: #808080;
			  --fc-border-color: #ddd;
				
			  /*버튼 색*/			
			  --fc-button-text-color: #6a53fb;
			  --fc-button-bg-color: none;
			  --fc-button-border-color: none;
			  --fc-button-hover-bg-color: none;
			  --fc-button-hover-border-color: none;
			  --fc-button-active-bg-color: none;
			  --fc-button-active-border-color: none;
			
			  --fc-event-bg-color: #6a53fb;
			  --fc-event-border-color: #6a53fb;
			  --fc-event-text-color: #fff;
			  --fc-event-selected-overlay-color: rgba(0, 0, 0, 0.25);
			
			  --fc-more-link-bg-color: #d0d0d0;
			  --fc-more-link-text-color: inherit;
			
			  --fc-event-resizer-thickness: 8px;
			  --fc-event-resizer-dot-total-width: 8px;
			  --fc-event-resizer-dot-border-width: 1px;
			
			  --fc-non-business-color: rgba(215, 215, 215, 0.3);
			  --fc-bg-event-color: rgb(143, 223, 130);
			  --fc-bg-event-opacity: 0.3;
			  --fc-highlight-color: #f8f7fc;
			  --fc-today-bg-color: #f8f7fc;
			  --fc-now-indicator-color: red;
			}
			
			#calendar {
				min-height: 600px !important;
				margin: 0 auto;
				background-color: white;
				border: 0.3px solid #dee2e6;
				border-radius: 5px;
				padding: 16px;
			}
			
			/*요일*/
			.fc-col-header-cell-cushion {
				text-decoration: none;
				color: #000;
			}
			.fc-col-header-cell-cushion:hover {
				text-decoration: none;
				color:#000;
			}
			/*일자*/
			.fc-daygrid-day-number,
			.fc-daygrid-day-number:hover {
				color: #000;
				font-size:1em;
				text-decoration: none;
			}
			/*일정시간*/
			.fc-daygrid-event > .fc-event-time{
				color:#000;
			}
			/*시간제목*/
			.fc-daygrid-dot-event > .fc-event-title{
				color:#000 !important;
			}
			/* 일요일 날짜색 */
			.fc-day-sun a,
			.fc-day-sun a:hover {
				color: #6a53fb;
				text-decoration: none;
			}
			
			/* 토요일 날짜색 */
			.fc-day-sat a,
			.fc-day-sat a:hover {
				color: #6a53fb;
				text-decoration: none;
			}
			
			.fc-daygrid-day-frame {
				padding: 3px;
			}
			
			/* 이전, 다음 버튼 */
			.fc-button {
				border: 0px !important;
				box-shadow: none !important;
			}
			
			/* 달력 제목 */
			.fc-toolbar-title {
				font-size: 1.3em !important;
				font-weight: bold !important;
			}
			
			/* 캘린더 외 요소 디자인 */
			.custom-btn {
				padding-top: 0.3em;
				padding-bottom: 0.3em;
			}
			.ti-alert-triangle {
				color: #6a53fb;
				font-size: 3em;
			}
			.custom-modal {
				z-index: 99999;
			}
			#deleteAlertModal {
				position: fixed;
				top: 20%; 
				left: 50%;
				transform: translate(-50%, -20%);
			}
			.display-none {
				display: none;
			}
			#calendarMemo,
			#calendarMemoEdit {
				/* 파폭 스크롤 커스텀 */
    			scrollbar-width: thin;
    			scrollbar-color: #c8c8c8 rgba(0,0,0,0);
			}
			/* 스크롤바 설정*/
			#calendarMemo::-webkit-scrollbar,
			#calendarMemoEdit::-webkit-scrollbar {
			    width: 5px;
			}
			/* 스크롤바 막대 설정*/
			#calendarMemo::-webkit-scrollbar-thumb,
			#calendarMemoEdit::-webkit-scrollbar-thumb {
			    background-color: #c8c8c8;
			    border-radius: 10px;    
			}
			/* 스크롤바 뒷 배경 설정*/
			#calendarMemo::-webkit-scrollbar-track,
			#calendarMemoEdit::-webkit-scrollbar-track {
			    background-color: rgba(0,0,0,0);
			}
		</style>    
    
    
		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
     
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
	                    	<h5 class="text-center mt-3 mb-4">로그인하고 기억해 둘 일정을 등록해 보세요!</h5>
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
        </div>
     
		<div id='calendar' class="custom-shadow">
		</div>
     

		<script type="text/javascript">
			let currentTime = new Date();
			let calendar;
			let startDate;
			let endDate;
			let calendarNo;
			document.addEventListener('DOMContentLoaded', function() {
				const calendarEl = document.getElementById('calendar');
				calendar = new FullCalendar.Calendar(calendarEl, {
					//locale: 'ko',
					headerToolbar: {
						left: 'title',
						right: 'prev,next'
					},
					initialView: 'dayGridMonth',
					views:{
						dayGridMonth:{
							titleFormat:function(obj){
								return "✨ " + obj.date.year+"년 " + (obj.date.month+1)+"월";
							},
							dayHeaderFormat:function(obj){
								//console.log(obj.date.day);
								switch(obj.date.day) {
									case 4: return "일";
									case 5: return "월";
									case 6: return "화";
									case 7: return "수";
									case 8: return "목";
									case 9: return "금";
									case 10: return "토";
								}
							},
						},
					},
					fixedWeekCount: false,
					droppable: false,
					selectable: true,
					displayEventTime: false,
					editable: true,
					//navLinks: true,
					//unselectAuto: true,
				
					select: function(arg) {
						startDate = arg.start;
						endDate = arg.end;
						//console.log("arg : " + arg.start);
						$("#addCalendarModal").modal("show");
						// 모달 열리자마자 제목으로 focus
						$("#calendarTitle").focus();
						//if(arg.start.length > 0) arg.start = "";
						//if(arg.end.length > 0) arg.end = "";
						/*const startDate = arg.start;
						const endDate = arg.end;*/
						console.log("startDate : " + startDate);
						console.log("endDate : " + endDate);
						$("#scheduleDate").val(
							moment(startDate).format('YYYY년 MM월 DD일')
							+ " - " + 
							moment(endDate - 1).format('YYYY년 MM월 DD일')
						);
						// 등록 버튼 클릭 시 이벤트 함수 실행
		                $(".addSchedule-btn").on("click", addSchedule);
		                // 제목에서 엔터치면 메모로 focus
		                $("#calendarTitle").on("keypress", function(e) {
					        if (e.which === 13) {
					            e.preventDefault();
					            $("#calendarMemo").focus();
					        }
					    });
					},
					// 일정 상세 조회
					eventClick: function(arg) {
					    $("#detailCalendarModal").modal("show");
					    // 상세조회이므로 수정 영역은 숨기기
					    $(".calendarEditModal").hide();
					    calendarNo = arg.event.id;
					    //console.log("click calendarNo: " + calendarNo);
					    $.ajax({
					        url: "${pageContext.request.contextPath}/calendar/detail/" + calendarNo,
					        method: "get",
					        success: function(resp) {
					            /*console.log(resp);
					            console.log("calendarStart: " + resp.calendarStart);
					            console.log("calendarEnd: " + resp.calendarEnd);
					            console.log("calendarTitle: " + resp.calendarTitle);
					            console.log("calendarMemo: " + resp.calendarMemo);*/
					            if (resp.length != 0) {
					                $("#detailCalendarDate").val(
					                    moment(resp.calendarStart).format('YYYY년 MM월 DD일') +
					                    " - " +
					                    moment(resp.calendarEnd).subtract(1, 'day').format('YYYY년 MM월 DD일')
					                );
					                $("#detailCalendarTitle").val(resp.calendarTitle);
					                $("#detailCalendarMemo").text(resp.calendarMemo);
					            }
					            // 일정 삭제 경고 알림 모달 띄우기
					            $(".delete-schedule-btn").on("click", function() {
					            	$("#deleteAlertModal").show();
					            });
					            $("#delete-schedule").on("click", function() {
					                $.ajax({
					                    url: "${pageContext.request.contextPath}/calendar/" + calendarNo,
					                    method: "delete",
					                    success: function() {
					                    	$("#deleteAlertModal").hide();
					                        $("#detailCalendarModal").modal("hide");
					                        loadMemberCalendar(); // 전체일정 재로드
					                    }
					                });
					            });
					            // 삭제 취소 시 경고 모달 닫기
					            $("#delete-cancel").on("click", function() {
					            	$("#deleteAlertModal").hide();
					            });
					         	// 일정 상세 모달 닫을 때 삭제 경고 모달 닫기
					            $("#detailCalendarModal").on("hidden.bs.modal", function() {
					            	$("#deleteAlertModal").hide();
					            });
					         	
					         	// 일정 수정 - 내용
								// 수정 모드
								$(".edit-schedule-btn").on("click", function() {
									$(".calendarDetailModal").hide();
									$(".calendarEditModal").show();
									$("#scheduleDateEdit").val(
					                    moment(resp.calendarStart).format('YYYY년 MM월 DD일') +
					                    " - " +
					                    moment(resp.calendarEnd).subtract(1, 'day').format('YYYY년 MM월 DD일')
					                );
					                $("#calendarTitleEdit").val(resp.calendarTitle);
					                $("#calendarMemoEdit").val(resp.calendarMemo);
								})
								// 수정 취소
								$(".cancel-edit-btn").on("click", function() {
									$(".calendarEditModal").hide();
									$(".calendarDetailModal").show();
									$("#scheduleDateEdit").val(
					                    moment(resp.calendarStart).format('YYYY년 MM월 DD일') +
					                    " - " +
					                    moment(resp.calendarEnd).subtract(1, 'day').format('YYYY년 MM월 DD일')
					                );
					                $("#calendarTitleEdit").val(resp.calendarTitle);
					                $("#calendarMemoEdit").val(resp.calendarMemo);
								})
								// 수정 버튼 클릭하면 수정 함수 실행
								$(".edit-confirn-btn").on("click", editSchedule);
					        },
					    });
					},
					// 일정 수정 - 날짜
					eventChange: function(arg) {
						const calendarNo = arg.event.id;
						const startDate = arg.event._instance.range.start;
						const endDate = arg.event._instance.range.end;
						/*console.log("calendarNo: " + calendarNo);
						console.log("startDate: " + startDate);
						console.log("endDate: " + endDate);*/
						const data = JSON.stringify({
					        calendarNo: calendarNo,
					        calendarStart: moment(startDate).format('YYYY-MM-DD'),
					        calendarEnd: moment(endDate).format('YYYY-MM-DD')
					    });
						// ajax
						$.ajax({
					        url: "${pageContext.request.contextPath}/calendar/date",
					        method: "put",
					        contentType: 'application/json',
					        data: data,
					        success: function(resp) {
					        	loadMemberCalendar();
					        }
					    });
					},
					// 페이지 켜지자 마자 로그인한 회원의 일정 불러오기
					events: function(fetchInfo, sucessCallback, failureCallback) {
						if(memberId.length > 0) {
							loadMemberCalendar()
								.done(function(resp) {
									sucessCallback(resp);
								})
								.fail(function() {
									failureCallback();
								});
						}
						else sucessCallback([]);
					}
				});
				calendar.render();
			}); 
			
			// 로그인한 회원의 일정 불러오는 함수
			function loadMemberCalendar() {
				return $.ajax({
					url:"${pageContext.request.contextPath}/calendar/load/" + memberId,
					success:function(resp){
						//console.log(resp);
						calendar.removeAllEvents();
						if(resp.length != 0){
							for(var i=0;i<resp.length;i++){
								calendar.addEvent({
									title: resp[i]['calendarTitle'],
									start: resp[i]['calendarStart'],
									end: resp[i]['calendarEnd'],
									id: resp[i]['calendarNo'],
									extendedProps: {
										"memberId": resp[i]['memberId']
									}
								})
							}
						}
					},
				});
			}
			
			// 일정 등록
			function addSchedule() {
				const calendarTitle = $("#calendarTitle").val();
				const calendarMemo = $("#calendarMemo").val();
				if(calendarTitle) {
					const dto={
						"memberId": memberId,
						"calendarTitle": calendarTitle,
						"calendarStart": moment(startDate).format('YYYY-MM-DD'),
						"calendarEnd": moment(endDate).format('YYYY-MM-DD'),
						"calendarMemo": calendarMemo
					};
					axios({
						url:"${pageContext.request.contextPath}/calendar/add",
						method:"post",
						data:JSON.stringify(dto),
						headers: { 'Content-Type': 'application/json' }
					}).then(function(resp){
						$("#calendarTitle").val("");
         						$("#calendarMemo").val("");
						loadMemberCalendar();
					});
				}
				// 일정 등록 모달 닫기
                $("#addCalendarModal").modal("hide");
			}
			
			// 일정 수정 - 내용
			function editSchedule() {
				const calendarTitle = $("#calendarTitleEdit").val();
				const calendarMemo = $("#calendarMemoEdit").val();
				console.log("calendarNo: " + calendarNo);
				console.log("calendarTitle: " + calendarTitle);
				console.log("calendarMemo: " + calendarMemo);
				const data = JSON.stringify({
			        calendarNo: calendarNo,
			        calendarTitle: calendarTitle,
					calendarMemo: calendarMemo
			    });
				//console.log("calendarNo: " + calendarNo);
				$.ajax({
			        url: "${pageContext.request.contextPath}/calendar/content",
			        method: "put",
			        contentType: 'application/json',
			        data: data,
			        success: function(resp2) {
			        	loadMemberCalendar();
			        	$("#detailCalendarModal").modal("hide");
			        }
			    });
			}
			
			// 글자수 체크
			$(function() {
				// 일정 등록
				let addValid = {
					titleValid: false,
					memoValid:true,
					isAllValid: function() {
						return this.titleValid && this.memoValid;
					},
					disalbeBtn: function() {
						const addBtn = $(".addSchedule-btn");
						if(this.isAllValid()) addBtn.removeAttr("disabled");
						else addBtn.attr("disabled", "disabled");
					}
				}
				// 일정 이름 검사
				$("#calendarTitle").blur(function() {
					let isValid = $(this).val().length <= 30 && $(this).val().length > 0;
					addValid.titleValid = isValid;
					$(this)
						.removeClass("is-invalid")
						.addClass(isValid ? "" : "is-invalid");
					$(this).nextAll('.invalidMessage:first')
						.removeClass("display-none invalid-feedback")
						.addClass(isValid ? "display-none" : "invalid-feedback");
					addValid.disalbeBtn();
				});
				// 메모 검사
				$("#calendarMemo").blur(function() {
					let isValid = $(this).val().length <= 100;
					addValid.memoValid = isValid;
					$(this)
						.removeClass("is-invalid")
						.addClass(isValid ? "" : "is-invalid");
					$(this).nextAll('.invalidMessage:first')
						.removeClass("display-none invalid-feedback")
						.addClass(isValid ? "display-none" : "invalid-feedback");
					addValid.disalbeBtn();
				});
				// 일정 수정
				let editValid = {
					titleValid: true,
					memoValid:true,
					isAllValid: function() {
						return this.titleValid && this.memoValid;
					},
					disalbeBtn: function() {
						const confirmBtn = $(".edit-confirn-btn");
						if(this.isAllValid()) confirmBtn.removeAttr("disabled");
						else confirmBtn.attr("disabled", "disabled");
					}
				}
				// 일정 이름 검사
				$("#calendarTitleEdit").blur(function() {
					let isValid = $(this).val().length <= 30 && $(this).val().length > 0;
					editValid.titleValid = isValid;
					$(this)
						.removeClass("is-invalid")
						.addClass(isValid ? "" : "is-invalid");
					$(this).nextAll('.invalidMessage:first')
						.removeClass("display-none invalid-feedback")
						.addClass(isValid ? "display-none" : "invalid-feedback");
					editValid.disalbeBtn();
				});
				// 메모 검사
				$("#calendarMemoEdit").blur(function() {
					let isValid = $(this).val().length <= 100;
					editValid.memoValid = isValid;
					$(this)
						.removeClass("is-invalid")
						.addClass(isValid ? "" : "is-invalid");
					$(this).nextAll('.invalidMessage:first')
						.removeClass("display-none invalid-feedback")
						.addClass(isValid ? "display-none" : "invalid-feedback");
					editValid.disalbeBtn();
				});
			})
			
			// 일정 등록 모달 닫힐 때 입력창 비우고 유효성 검사 초기화
			$(function() {
				$("#addCalendarModal").on("hidden.bs.modal", function() {
			        // 입력창 값 초기화
			        $("#calendarTitle").val("");
			        $("#calendarMemo").val("");
			        // 유효성 검사 문구 초기화
			        $("#calendarTitle").removeClass("is-invalid");
			        $("#calendarMemo").removeClass("is-invalid");
			        $(".invalidMessage").addClass("display-none");
			    });
			})
			// 로그인 여부에 따라 일정 등록 모달 문구 바꾸기
			$(function() {
				if (memberId.length < 1) {
				    $(".beforeLogin").show();
				    $(".addCalendarModalFooter").hide();
				    $(".afterLogin").hide();
				}
				else {
				    $(".beforeLogin").hide();
				    $(".addCalendarModalFooter").show();
				    $(".afterLogin").show();
				}
			});
			// 일정 등록 모달 닫힐 때 입력창 비우고 유효성 검사 초기화
			$(function() {
				$("#addCalendarModal").on("hidden.bs.modal", function() {
			        // 입력창 값 초기화
			        $("#calendarTitle").val("");
			        $("#calendarMemo").val("");
			        // 유효성 검사 문구 초기화
			        $("#calendarTitle").removeClass("is-invalid");
			        $("#calendarMemo").removeClass("is-invalid");
			        $(".invalidMessage").addClass("display-none");
			    });
			})
			// 일정 상세 모달 닫힐 때 모달 초기화
			$(function() {
				$("#detailCalendarModal").on("hidden.bs.modal", function() {
					$(".calendarDetailModal").show();
					$("#calendarTitleEdit").val("");
			        $("#calendarMemoEdit").val("");
					$(".calendarEditModal").hide();
			    });
			})
			
			// 로그인하러 가기 버튼
			$(".calendar-login-btn").on("click", function() {
			    window.location.href = "${pageContext.request.contextPath}/member/login";
			});
		</script>
   