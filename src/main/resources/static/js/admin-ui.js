//Tab
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}

//셀렉트메뉴
var selectPic = {
    init: function() {
        $('select').niceSelect();
    }
}


$( "document" ).ready( function() {
    //파일올리기
    /*var uploadFile = $('.file-box .upload-name');
    uploadFile.on('change', function() {
        if (window.FileReader) {
            var filename = $(this)[0].files[0].name;
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }
        $(this).siblings('.fileName').val(filename);
    });*/
    
    // 파일올리기
    var uploadFile = $('.file-box .upload-name');
	uploadFile.on('change', function() {
	    if (window.FileReader) {
	    	if($(this)[0].files[0] == null){
	    		$(this).siblings('.fileName').val('');
	    	} else{
	    		var filename = $(this)[0].files[0].name;
	    	}
	    } else {
	        var filename = $(this).val().split('/').pop().split('\\').pop();
	    }
	    
	    $(this).siblings('.fileName').val(filename);
	    
	});
} );



//달력
var dataSelect = {
    init: function() {
        $('.datepick').each(function() {
            $(this).datepicker({
                dateFormat: 'yy/mm/dd',
                prevText: '이전 달',
                nextText: '다음 달',
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                showMonthAfterYear: true,
                yearSuffix: '년'
            });
        });
    }
}

//년월표시 달력
var yearmonthSelect = {
    init: function() {
        $(".yearmonth").each(function() {
            $(this).datepicker({
                dateFormat: 'yy/mm',
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                showMonthAfterYear:true,
                closeText: '선택',
                currentText: '오늘',
                monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                defaultDate: stringToDate($(this).val()+".01"),

                /*20200724 ie 버그 추가*/
                beforeShow: function(input) {
                    $(input).datepicker("widget").addClass('hide-calendar');
                },

                onClose: function(dateText, inst) {
                    var year = inst.selectedYear;
                    var month = inst.selectedMonth;
                    $(this).datepicker("option","defaultDate", new Date(year,month,1));
                    $(this).datepicker('setDate', new Date(year, month, 1));
                    $(this).attr("value",$(this).val());
                    $(".ui-datepicker-calendar").css("display", "none");
                    $(this).on("focus",function(){$(".ui-datepicker-calendar").css("display", "none")});
                    $(this).datepicker('widget').removeClass('hide-calendar');
                }
            });
        });
        $(".yearmonth").focus(function() {
            $(".ui-datepicker-calendar").css("display", "none");
        });
    }
}

//년만 표시
var yearSelect = {
    init: function() {
        $(".year").datepicker({
            changeYear: true,
                showButtonPanel: true,
                dateFormat: 'yy',
                closeText: '선택',
            currentText: '오늘',
                onClose: function(dateText, inst) {
                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, 1));

                }
        });
        $(".year").focus(function() {
            $(".ui-widget.ui-widget-content").css("width", "200px");
            $(".ui-datepicker .ui-datepicker-title").css("margin", "0");
            $(".ui-datepicker-calendar").css("display", "none");
            $(".ui-datepicker-prev").hide();
            $(".ui-datepicker-next").hide();
            $(".ui-datepicker-month").hide();
        });
    }
}

function stringToDate(sDate)
{
    var retDate = null;
    if ( isValidDate(sDate) )
    {
        var days = sDate.split(/[\/\.\-]/);
        var year  = parseInt(days[0],10);
        var month = parseInt(days[1],10);
        var date  = parseInt(days[2],10);

        retDate = new Date(year,month-1,date);
    }
    return retDate;
}

//날짜 Validation Function
function isValidDate(sDate)
{
    var regex = new RegExp(/\d{4}[\/\.\-](0?[1-9]|1[012])[\/\.\-](0?[1-9]|[12][0-9]|3[01])/);

    if(!regex.test(sDate)){
        return false;
    }

    var days = sDate.split(/[\/\.\-]/);
    var year  = parseInt(days[0],10);
    var month = parseInt(days[1],10);
    var date  = parseInt(days[2],10);

    var vDate = new Date(year,month-1,date);

    var year2  = vDate.getFullYear();
    var month2 = vDate.getMonth()+1;
    var date2  = vDate.getDate();

    if(year != year2 || month != month2 || date != date2){
        return false;
    }

    return true;
}

//메뉴 스크롤 픽스
var headerFix = {
    init: function() {
        window.onscroll = function() { myFunction() };

        var header = document.getElementById("header");
        var headerCon = document.getElementById("container");
        var headerfix = header.offsetTop;

        function myFunction() {
            if (window.pageYOffset > headerfix) {
                header.classList.add("header-fix");
                headerCon.classList.add("header-fix-h");
            } else {
                header.classList.remove("header-fix");
                headerCon.classList.remove("header-fix-h");
            }
        }
    }
}

$(document).ready(function() {
    headerFix.init(); //메뉴 스크롤 픽스
    dataSelect.init(); //달력
    yearmonthSelect.init(); //년월선택
    yearSelect.init(); //년선택
    selectPic.init(); //셀렉트 메뉴
});
