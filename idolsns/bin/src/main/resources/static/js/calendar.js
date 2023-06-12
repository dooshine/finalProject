// 캘린더 스크립트

let currentTime = new Date();
let calendar;
let startDate;
let endDate;
let calendarNo;

$(function(){
	$("#addCalendarModal").click(function(){
		loadCalendar();
	});
})
function loadCalendar() {
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
		height: 'auto',
		//dayMaxEvents: true,
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
		        url: contextPath + "/calendar/detail/" + calendarNo,
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
		                    url: contextPath + "/calendar/" + calendarNo,
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
			if(memberId === "") return;
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
		        url: contextPath + "/calendar/date",
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
}

document.addEventListener('DOMContentLoaded', loadCalendar); 

// 로그인한 회원의 일정 불러오는 함수
function loadMemberCalendar() {
	if(memberId === "") return;
	return $.ajax({
		url: contextPath + "/calendar/load/" + memberId,
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
	if(memberId === "") return;
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
			url: contextPath + "/calendar/add",
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
	if(memberId === "") return;
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
        url: contextPath + "/calendar/content",
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
$(function() {
	$(".calendar-login-btn").on("click", function() {
	    window.location.href = contextPath + "/member/login";
	});
})
