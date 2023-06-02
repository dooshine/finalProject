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
			
			  --fc-event-bg-color: #3788d8;
			  --fc-event-border-color: #3788d8;
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
			  /*--fc-highlight-color: rgba(188, 232, 241, 0.3);*/
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
		</style>    
    
    
		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
 		<!-- <script src='fullcalendar/core/locales/ko.js'></script> -->
     
		<div id='calendar' class="custom-shadow">
		</div>
     
    <script type="text/javascript">
   		var currentTime=new Date();
		 document.addEventListener('DOMContentLoaded', function() {
			const calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				//locale: 'ko',
				headerToolbar: {
		            left: 'title',
		            right: 'prev,next'
		        },
				initialView: 'dayGridMonth',
			 	views:{
		        	dayGridMonth:{
		            	titleFormat:function(obj){
		                	return "✏ " + obj.date.year+"년 " + (obj.date.month+1)+"월";
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
				editable : true,
				fixedWeekCount: false,
				droppable: false,
				//navLinks: true, // can click day/week names to navigate views
			    selectable: true,
			    selectMirror: true,
				
				select: function(arg) {
				   	  console.log(arg);
				   	  var result=moment(arg.start).isAfter(currentTime);
				   	  console.log(result);
				   	  if(result==false){
				   		  confirm("지나간 날짜에는 일정을 등록할 수 없습니다");
				   		  return false;
				   	  }
				       var title = prompt('입력할 일정:');
				       var dto={
				     		"memberId": memberId,
				      		"calendarTitle": calendarTitle,
				      		"calendarStart": moment(arg.start).format('YYYY-MM-DD HH:mm:ss'),
				      		"calendarEnd": moment(arg.end).format('YYYY-MM-DD HH:mm:ss'),
				      		"calendarMemo": "이부분 나중에 수정"
				   	  };
				      console.log(dto);
				   
				   // title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가
				       if(title) {
				       	   calendar.addEvent({
					           title: title,
					           start: arg.start,
					           end: arg.end,
				           }),
				      	
				         //화면에 addEvent 추가후 통신
				        axios({
				       	 	url:"${pageContext.request.contextPath}/calendar/",
				       	 	method:"post",
				       	 	data:JSON.stringify(dto),
				        }).then(function(resp){
							console.log(resp);
							alert("일정이 입력되었습니다");
							location.reload();
				        });
				       }
				       calendar.unselect()
				},
				// 로그인한 회원의 일정 불러오기
				events: [
			    	$.ajax({
		    			url:"${pageContext.request.contextPath}/calendar/load/" + memberId,
			    		method:"get",
			    		success:function(resp){
			    			console.log(resp);
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
			    	  })
			      ]
			});
			calendar.render();
			//console.log(calendar.currentData.calendarOptions);
		}); 
    </script>
   