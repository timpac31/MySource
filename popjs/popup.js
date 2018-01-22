/**
 * layer popup 
 * auth : jyd@moren.co.kr
 * since : 2018.01. 
 */

var PopJs = {
	closeEl : '<div id="close" style="font-size:14px; background-color:#ffffff; width:100%; text-align:right; color:#1e1e1e;">'
			+ '<b> 오늘 그만 보기</b> <input type="checkbox" name="Notice">'
			+ '<a href="#" id="closePop"><img src="images/btn_close.gif" width="20px" alt="닫기"></a></div>',
	
	overlay : '<div id="overlay" style="position:fixed;display:none;width:100%;height:100%;top:0;left:0;right:0;bottom:0;background-color:rgba(0,0,0,0.5);z-index:2;"></div>',
	
	pop: function(options) {
		var popObj = new Object();
		//필수옵션
		popObj.id = options['id'];
		popObj.left = options['left'];
		popObj.top = options['top'];
		popObj.startDate = options['startDate'];
		popObj.endDate = options['endDate'];		
		//선택 옵션
		options.hasOwnProperty('z-index') ? popObj.zIndex = options['z-index'] : popObj.zIndex = "300";
		options.hasOwnProperty('background-color') ? popObj.backgroundColor = options['background-color'] : popObj.backgroundColor = "#ffffff";
		
		if(this.isValid(popObj.startDate, popObj.endDate)) 
			this.createPopup(popObj);
	},
	
	//팝업기간 and 오늘하루안보기 쿠키 체크   ex)2018/01/12 12:00:00
	isValid: function(startDate, endDate) {
		var sdate= new Date(startDate);
	    var edate= new Date(endDate);
	    var now = new Date().getTime();
		
		return now >= sdate && now <= edate && document.cookie.indexOf('mainPop') == -1; 
	},
	
	//팝업창 및 오버레이 div 만들기
	createPopup: function(popObj) {
		var popDiv = document.getElementById(popObj.id);
		popDiv.style.position = "absolute";
		popDiv.style.left = popObj.left;
		popDiv.style.top = popObj.top;
		popDiv.style.zIndex = popObj.zIndex;
		popDiv.style.backgroundColor = popObj.backgroundColor;
		
		popDiv.insertAdjacentHTML( 'beforeend', this.closeEl );
		popDiv.insertAdjacentHTML( 'afterend', this.overlay );
		
		this.on(popObj.id);
		
		document.getElementById("closePop").addEventListener("click", function(){
			if (document.getElementsByName("Notice")[0].checked) {
				PopJs.setCookie('mainPop', 'done', '1');	//하루동안 열지않음
		    }
			PopJs.off(popObj.id);
		});
	},

	setCookie: function(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	},

	on: function(id) {
		document.getElementById(id).style.display = "block";
	    document.getElementById("overlay").style.display = "block";
	},
	off: function(id) {
	    document.getElementById(id).style.display = "none";
	    document.getElementById("overlay").style.display = "none";
	}
	

};

