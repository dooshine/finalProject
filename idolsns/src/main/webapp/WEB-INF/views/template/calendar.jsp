<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<style>
			/*
			for css vars only.
			these values are automatically known in all stylesheets.
			the :root statement itself is only included in the common stylesheet.
			this file is not processed by postcss when imported into the postcss-custom-properties plugin,
			so only write standard css!
			
			NOTE: for old browsers, will need to restart watcher after changing a variable
			*/
			
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
                    	<div class="form-floating mb-3">
							<input type="text" readonly class="form-control-plaintext" id="scheduleDate" placeholder="dd">
							<label for="scheduleDate" class="startDate">날짜</label>
						</div>
                   		<div class="form-floating mb-3">
							<input type="text" class="form-control" id="calendarTitle" placeholder="dd">
							<label for="calendarTitle">일정 이름 (최대 30자)</label>
						</div>
                   		<div class="form-floating">
							<textarea class="form-control" placeholder="Leave a comment here" id="calendarMemo" style="height: 100px; resize: none;"></textarea>
							<label for="calendarMemo">메모 (최대 100자)</label>
						</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="addSchedule-btn custom-btn btn-purple1">
                            등록
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 일정 상세 모달 -->
     	<div class="modal" tabindex="-1" role="dialog" id="detailCalendarModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
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
						<div class="form-floating">
							<textarea class="form-control-plaintext" placeholder="Leave a comment here" id="detailCalendarMemo" style="resize: none;"></textarea>
							<label for="calendarMemo">메모</label>
						</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="delete-schedule-btn custom-btn btn-purple1-secondary">
                            삭제
                        </button>
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
					//navLinks: true,
					//unselectAuto: true,
				
					select: function(arg) {
						$("#addCalendarModal").modal("show");
						const startDate = arg.start;
						const endDate = arg.end;
						$("#scheduleDate").val(
							moment(startDate).format('YYYY년 MM월 DD일')
							+ " - " + 
							moment(endDate - 1).format('YYYY년 MM월 DD일')
						);
						
						function addSchedule() {
							const calendarTitle = $("#calendarTitle").val();
							const calendarMemo = $("#calendarMemo").val();
							
							if(calendarTitle) {
								var dto={
									"memberId": memberId,
									"calendarTitle": calendarTitle,
									"calendarStart": moment(startDate).format('YYYY-MM-DD'),
									"calendarEnd": moment(endDate).format('YYYY-MM-DD'),
									"calendarMemo": calendarMemo
								};
								//console.log(dto);
								axios({
									url:"${pageContext.request.contextPath}/calendar/add",
									method:"post",
									data:JSON.stringify(dto),
									headers: { 'Content-Type': 'application/json' }
								}).then(function(resp){
									//console.log(resp);
									//location.reload(); // unselect 작동 안하면 강제 새고...
									//calendar.unselect(); //작동 안하는데 이유를 모르겠음
									$("#calendarTitle").val("");
            						$("#calendarMemo").val("");
									loadMemberCalendar();
								});
							}
							//calendar.unselect();
							// 일정 등록 모달 닫기
		                    $("#addCalendarModal").modal("hide");
						}
						// 등록 버튼 클릭 시 이벤트 함수 실행
		                $(".addSchedule-btn").on("click", addSchedule);
		                //calendar.unselect();
					},
					// 일정 상세 조회
					eventClick: function(arg) {
					    $("#detailCalendarModal").modal("show");
					    const calendarNo = arg.event.id;
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
					                $("#detailCalendarMemo").val(resp.calendarMemo);
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
					        },
					    });
					},

					// 페이지 켜지자 마자 로그인한 회원의 일정 불러오기
					events: [
						loadMemberCalendar()
					]
				});
				calendar.render();
			}); 
			
			// 로그인한 회원의 일정 불러오는 함수
			function loadMemberCalendar() {
				return $.ajax({
					url:"${pageContext.request.contextPath}/calendar/load/" + memberId,
					success:function(resp){
						console.log(resp);
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
		</script>
   