/**
 * layer popup : 지정된 옵션(게시기간,위치,배경색등)으로 레이어팝업을 띄운다.
 * auth : ydcho@moren.co.kr
 * since : 2018.01. 
 * usage : https://github.com/timpac31/MySource/tree/master/popjs
 */

var PopJs = {
	closeEl : '<div id="close" style="font-size:14px; background-color:#ffffff; width:100%; text-align:right; color:#1e1e1e;">'
			+ '<b> 오늘 그만 보기</b> <input type="checkbox" name="Notice">'
			+ '<a href="#" id="closePop" style="margin-left:10px;padding:2px;"><img src="/new_portal/renewal_img/btn_close.gif" width="20px" alt="닫기"></a></div>',
	
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
		options.hasOwnProperty('align-center') ? popObj.alignCenter = options['align-center'] : popObj.alignCenter = false;
		options.hasOwnProperty('width') ? popObj.width = options['width'] : popObj.width = '100%';
		options.hasOwnProperty('cookieName') ? popObj.cookieName = options['cookieName'] : popObj.cookieName = 'mainPop';
		
		if(this.isValid.call(popObj)) 
			this.createPopup(popObj);
	},
	
	//팝업기간 and 오늘하루안보기 쿠키 체크   ex)2018/01/12 12:00:00
	isValid: function() {
		var sdate= new Date(this.startDate);
	    var edate= new Date(this.endDate);
	    var now = new Date().getTime();
		
		return now >= sdate && now <= edate && document.cookie.indexOf(this.cookieName) == -1; 
	},
	
	//팝업창 및 오버레이 div 만들기
	createPopup: function(popObj) {
		var popDiv = document.getElementById(popObj.id);

		popDiv.style.position = "absolute";			
		popDiv.style.top = popObj.top;
		
		if(popObj.alignCenter) {
			popDiv.style.left = "50%";
			popDiv.style.marginLeft = (popObj.width.replace('px','')/2)*-1 + "px";
		}else {
			popDiv.style.left = popObj.left;
		}
		//popDiv.style.left = ( popObj.alignCenter ? ( Math.ceil((window.screen.width - popObj.width.replace('px', ''))/2) + 'px') : popObj.left );
		popDiv.style.zIndex = popObj.zIndex;
		popDiv.style.backgroundColor = popObj.backgroundColor;			
		
		if(!document.getElementById('close')) popDiv.insertAdjacentHTML( 'beforeend', this.closeEl );
		if(!document.getElementById('overlay')) popDiv.insertAdjacentHTML( 'afterend', this.overlay );
	
		this.on(popObj.id);
		
		document.getElementById("closePop").addEventListener("click", function(){
			if (document.getElementsByName("Notice")[0].checked) {
				PopJs.setCookie(popObj.cookieName, 'done', '1');	//하루동안 열지않음
		    }
			PopJs.off(popObj.id);
		});
	},

	setCookie: function(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setTime( todayDate.getTime() + (expiredays * 24 * 60 * 60 * 1000) );
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

