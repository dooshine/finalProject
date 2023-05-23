<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- clndr -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clndr/1.1.0/clndr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.6/underscore-min.js"></script>
<link rel="stylesheet" type="text/css" href="/static/css/clndr.css">
            </div>
       
            
		

	<div class="col-3">
	  	<div id="calendar">
	  		<div class="clndr-grid">
				<div class="days-of-the-week clearfix">
					<c:forEach items="${daysOfTheWeek}" var="day">
						<div class="header-day">${day}</div>
					</c:forEach>
				</div>
				<div class="days clearfix">
					<c:forEach items="${days}" var="day">
						<div class="${day.classes}" id="${day.id}">
							<span class="day-number">${day.day}</span>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="event-listing">
				<div class="event-listing-title">EVENTS THIS MONTH</div>
				<c:forEach items="${eventsThisMonth}" var="event">
					<div class="event-item">
						<div class="event-item-name">${event.name}</div>
						<div class="event-item-location">${event.location}</div>
					</div>
				</c:forEach>
			</div>
	  	</div>
	</div>
	





        
        </section>
        <hr>
        <footer>
            <h1>푸터</h1>
            <h2>세션 memberId: ${sessionScope.memberId}</h2>
            <h2>세션 memberLevel: ${sessionScope.memberLevel}</h2>
        </footer>
    </main>
 
 
 
	<!-- 부트스트랩 js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    

 	<script>
 		$(function() {
 			$("#calendar").clndr({
 				daysOfTheWeek: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
 			numberOfRows: 5,
 			days: [
 			  {
 			    day: '1',
 			    classes: 'day today event',
 			    id: 'calendar-day-2013-09-01',
 			    events: [ ],
 			    date: moment('2013-09-01')
 			  },
 			],
 			month: 'September',
 			year: '2013',
 			eventsThisMonth: [ ],
 			extras: { }
 			});
 		});
	</script>
 

 
    
</body>
</html>

