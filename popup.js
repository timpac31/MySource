/**
 * layer popup : ������ �ɼ�(�ԽñⰣ,��ġ,������)���� ���̾��˾��� ����.
 * auth : ydcho@moren.co.kr
 * since : 2018.01. 
 * usage : https://github.com/timpac31/MySource/tree/master/popjs
 */

var PopJs = {
	
	pop: function(options) {
		var popObj = new Object();
		//�ʼ��ɼ�
		popObj.id = options['id'];
		popObj.left = options['left'];
		popObj.top = options['top'];
		popObj.startDate = options['startDate'];
		popObj.endDate = options['endDate'];
		//���� �ɼ�
		options.hasOwnProperty('z-index') ? popObj.zIndex = options['z-index'] : popObj.zIndex = "300";
		options.hasOwnProperty('background-color') ? popObj.backgroundColor = options['background-color'] : popObj.backgroundColor = "#ffffff";
		options.hasOwnProperty('align-center') ? popObj.alignCenter = options['align-center'] : popObj.alignCenter = false;
		options.hasOwnProperty('width') ? popObj.width = options['width'] : popObj.width = '100%';
		options.hasOwnProperty('cookieName') ? popObj.cookieName = options['cookieName'] : popObj.cookieName = 'mainPop';
		options.hasOwnProperty('overlay') ? popObj.overlay = options['overlay'] : popObj.overlay = true;
		
		if(this.isValid.call(popObj)) 
			this.createPopup(popObj);
	},
	
	//�˾��Ⱓ and �����Ϸ�Ⱥ��� ��Ű üũ   ex)2018/01/12 12:00:00
	isValid: function() {
		var sdate= new Date(this.startDate);
	    var edate= new Date(this.endDate);
	    var now = new Date().getTime();
		
		return now >= sdate && now <= edate && document.cookie.indexOf(this.cookieName) == -1; 
	},	
	
	//�˾�â �� �������� div �����
	createPopup: function(popObj) {
		var popDiv = document.getElementById(popObj.id);

		PopJs.setDefaultStyle(popDiv);
		popDiv.style.top = popObj.top;
		
		if(popObj.alignCenter && window.outerWidth > 700) {
			popDiv.style.left = "50%";
			popDiv.style.marginLeft = (popObj.width.replace('px','')/2)*-1 + "px";
		}else {
			popDiv.style.left = popObj.left;
		}
		if(window.outerWidth < 500) {
			popDiv.style.left = "0px";
		}

		//popDiv.style.left = ( popObj.alignCenter ? ( Math.ceil((window.screen.width - popObj.width.replace('px', ''))/2) + 'px') : popObj.left );
		popDiv.style.zIndex = popObj.zIndex;
		popDiv.style.backgroundColor = popObj.backgroundColor;			
		
		//�����Ϸ� �����ʱ�
		var closeElId = document.getElementsByClassName('close').length;
		
		var closeEl = '<div id="close' +closeElId+ '" class="close" style="font-size:14px; background-color:#ffffff; width:100%; text-align:right; color:#1e1e1e;">'
				+ '<b> ���� �׸� ����</b> <input type="checkbox" name="Notice">'
				+ '<a href="#" id="closePop' +closeElId+ '" style="margin-left:10px;padding:2px;"><img src="/new_portal/renewal_img/btn_close.gif" width="20px" alt="�ݱ�"></a></div>';
		
		var overlay = '<div id="overlay" style="position:fixed;display:none;width:100%;height:100%;top:0;left:0;right:0;bottom:0;background-color:rgba(0,0,0,0.5);z-index:2;"></div>';
		
		popDiv.insertAdjacentHTML( 'beforeend', closeEl );

		document.getElementById("closePop"+closeElId).addEventListener("click", function(){
			if (document.getElementsByName("Notice")[closeElId].checked) {
				PopJs.setCookie(popObj.cookieName, 'done', '1');	//�Ϸ絿�� ��������
		    }
			PopJs.off(popObj.id);
		});
		
		if(!document.getElementById('overlay') && popObj.overlay) {
			popDiv.insertAdjacentHTML( 'afterend', overlay );
		}
	
		this.on(popObj.id);			
	},	

	setDefaultStyle: function(popDiv) {
        popDiv.style.position = "absolute";	
        popDiv.style.border = "2px solid #a3a3a3";
		popDiv.style.borderRadius = "10px";
        popDiv.style.padding = "10px";
	},
	
	setCookie: function(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setTime( todayDate.getTime() + (expiredays * 24 * 60 * 60 * 1000) );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	},

	on: function(id) {
		document.getElementById(id).style.display = "block";
		if(document.getElementById("overlay"))
			document.getElementById("overlay").style.display = "block";
	},
	off: function(id) {
	    document.getElementById(id).style.display = "none";
		if(document.getElementById("overlay"))
		    document.getElementById("overlay").style.display = "none";
	}
	

};