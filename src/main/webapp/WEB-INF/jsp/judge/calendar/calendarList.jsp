<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>심판아카데미 운영시스템</title>
    
    <style type="text/css">
	.fc-toolbar-chunk div{
		display: flex;
		align-items: center;
	}
	.fc-day-sat .fc-daygrid-day-number { color:#0000FF; }     /* 토요일 */
    .fc-day-sun .fc-daygrid-day-number { color:#FF0000; }    /* 일요일 */
    .fc-col-header .fc-day-sat .fc-col-header-cell-cushion { color:#0000FF; }    /* 토요일 */
    .fc-col-header .fc-day-sun .fc-col-header-cell-cushion { color:#FF0000; }    /* 일요일 */
    </style>
</head>

<jsp:include page="/WEB-INF/jsp/include/common.jsp"/>
<script type="text/javascript">

$(document).ready(function() {
    console.log("ready @#@#@#@#")
});


<%-- 수강신청 목록 --%>
function fn_scheduleList(){
	location.href = "<c:out value='${pageContext.request.contextPath}/edu/judge/schedule'/>";
}

<%-- 수강내역 목록 --%>
function fn_applyList(){
	location.href = "<c:out value='${pageContext.request.contextPath}/apply/judge/history'/>";
}

</script>

<body>
    <!-- wrapper -->
    <div id="wrapper">
    
    	<jsp:include page="/WEB-INF/jsp/include/judgeHeader.jsp"/>
    
        <!-- container -->
        <div id="container">
            <div class="sub-tit-wrap">
                <div class="sub-tit-container">
                    <!-- tab: 2개-->
                    <div class="tab-wrap tab3">
                        <a href="javascript:fn_scheduleList();" class="tablinks">수강신청</a>
                        <a href="javascript:fn_applyList();" class="tablinks">수강내역</a>
                        <a href="javascript:fn_calendar();" class="tablinks active">달력</a>
                    </div>
                    <!-- //tab -->
                </div>
            </div>
            <!-- search area -->
            <div class="search-wrap">
                <div class="search-container">
                	<form id="searchForm" name="searchForm">
	                    <ul class="filter-row">
	                        <li>
	                            <label for="year">조회기간</label>
	                            <input type="text" id="year" name="year" value="<c:out value='${search.year}'/>" class="input-text year icon_calendar" style="width:100px" placeholder="년도" />
	                        </li>
	                        <li>
	                            <button type="button" id="btn-search" class="btn2 btn-search">
	                                <span>조회</span>
	                            </button>
	                        </li>
	                    </ul>
                    </form>
                </div>
            </div>
            <!-- //search area -->
            <!-- table-wrap -->
            <div class="content-wrap">
				<div id="calendar"></div>
				<div>
					<table id="listTable">
						<tbody id="listData"></tbody>
					</table>
				</div>
				<c:forEach var="holy" items="${holidayList}" varStatus="status">
					${holy.title}
				</c:forEach>
			</div>
            <!-- //table-wrap -->
        </div>
        <!-- //container -->
        
        <jsp:include page = "/WEB-INF/jsp/include/footer.jsp"/>
        
    </div>
    
    <div class="modal" id="pop_detail"></div>
    
<script type="text/javascript">
var year;

var calendarEl = $('#calendar')[0];
// full-calendar 생성하기
var calendar = new FullCalendar.Calendar(calendarEl, {
	aspectRatio: 1.35, // 가로 세로 비율
	height: '700px', // calendar 높이 설정
	expandRows: true, // 화면에 맞게 높이 재설정
	slotMinTime: '08:00', // Day 캘린더에서 시작 시간
	slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
	// 해더에 표시할 툴바
	headerToolbar: {
		left: 'today',
		center: 'prev,title,next',
		right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
	},
	initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
	initialDate: new Date(), // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
	navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
	editable: true, // 수정 가능?
	selectable: true, // 달력 일자 드래그 설정가능
	nowIndicator: true, // 현재 시간 마크
	dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
	lazyFetching: true, // fasle시 보기가 전환되거나 현재 날짜가 변경될 때마다 이벤트를 가져옴.
	locale: 'ko', // 한국어 설정
// 	titleFormat : function(date) { // title 설정
// 		return date.date.year +"년 "+(date.date.month +1)+"월"; 
// 	},
// 	dayHeaderContent: function (date) {
// 	    let weekList = ["일", "월", "화", "수", "목", "금", "토"];
// 	    return weekList[date.dow];
//     },
// 	buttonText: {
//       	today: '오늘',
// 	  	month:    '월',
// 	  	week:     '주',
// 	  	day:      '일',
// 	  	list: '일정목록'
//   	},
//   	weekText: '주',
//     allDayText: '종일',
//     moreLinkText: '개',
//     noEventsText: '일정이 없습니다',
	eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
		console.log('eventAdd : ' + obj);
	},
	eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
		console.log('eventChange : ' + obj);
	},
	eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
		console.log('eventRemove : ' + obj);
	},
	// 이벤트 클릭시 상세 팝업창 호출함
	eventClick: function(obj) {
		console.log('eventClick : ' + JSON.stringify(obj.event))
		console.log('eventClick : ' + JSON.stringify(obj.event.extendedProps.acEduScheduleNo))
		
		var data = {
			"acEduScheduleNo" : obj.event.extendedProps.acEduScheduleNo
		}
		
		$.ajax({
			type: "post",
			url: "<c:out value='${pageContext.request.contextPath}/calendar/judge/calendarDetail'/>",
			data: JSON.stringify(data),
			dataType: "text",
			contentType: "application/json;charset=UTF-8",
			success: function(data){
				$('#pop_detail').html(data);
				
				$('#pop_detail').bPopup({
	                speed: 450,
	                // transition: 'slideDown'
	            });
			},
			error: function(){
				alert("ajax error");
			}
		});
	},
	select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
		var title = prompt('Event Title:');
		if (title) {
			calendar.addEvent({
				title: title,
				start: arg.start,
				end: arg.end,
				allDay: arg.allDay
			})
		}
		calendar.unselect()
	},
	eventSources: [
		{
			events: function(info, successCallback, failureCallback) {
				console.log(moment(info.startStr).format('YYYY-MM-DD') + ' ~ ' + moment(info.endStr).format('YYYY-MM-DD'))
				$.ajax({
					url: "<c:out value='${pageContext.request.contextPath}/calendar/judge/getCalendar'/>",
					type: 'POST',
					dataType: 'json',
					data: {
						start : moment(info.startStr).format('YYYY-MM-DD'),
						end : moment(info.endStr).format('YYYY-MM-DD')
					},
					success: function(data) {
						console.log('eventSources1111')
						$("#listData").empty();
						if(data.result.length > 0)  {
							successCallback(data.result);
							setScheduleList(data.result);
						}
					}
				});
			}
		},
		{
			events: function(info, successCallback, failureCallback) {
				var startStr = moment(info.startStr).format('YYYY');
				var endStr = moment(info.endStr).format('YYYY');
				
				if(year == null || startStr<year || endStr>year) {
					$.ajax({
						url: "<c:out value='${pageContext.request.contextPath}/calendar/judge/getHoliday'/>",
						type: 'POST',
						dataType: 'json',
						data: {
							start : moment(info.startStr).format('YYYY'),
							end : moment(info.endStr).format('YYYY')
						},
						success: function(data) {
							console.log('eventSources2222')
							if(data.result.length > 0)  {
								successCallback(data.result);
								if (startStr == endStr)
								year = startStr;
							}
						}
					});
				}
			},
			allDay: true,
			color: 'red',   // an option!
			textColor: 'white' // an option!
		}
	]
});
// 캘린더 랜더링
calendar.render();

function setScheduleList(list) {
	console.log('setScheduleList...')
	var test = '';
	for (var i = 0; i < list.length; i++) {
		test += '<tr>';
		test += '<td>'+list[i].title+'</td>';
		test +=	'<td><a href="javascript:fn_update('+list[i].acEduScheduleNo+');" class="active">수정</a></td>'
		test +=	'<td><a href="javascript:fn_delete('+list[i].acEduScheduleNo+');" class="active">삭제</a></td>'
		test += '</tr>';
	}
	$("#listData").append(test);
}
function fn_update(acEduScheduleNo) {
	console.log('acEduScheduleNo : ' + acEduScheduleNo)
	// calendar.refetchEvents();	// 캘린더 새로고침
	console.log('fn_update end-----------')
}
function fn_delete(acEduScheduleNo) {
	console.log('acEduScheduleNo : ' + acEduScheduleNo)
	// calendar.refetchEvents();	// 캘린더 새로고침
	console.log('fn_delete end-----------')
}
</script>
</body>
</html>