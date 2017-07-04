<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="/new_portal/lib/css/welfare-map.css">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

<!-- 네이버지도  -->
<script type="text/javascript" src="/new_portal/lib/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=mFhtSsXhUMcrGJAakPip&submodules=geocoder"></script>
<script type="text/javascript" src="/new_portal/lib/js/MarkerOverlappingRecognizer.js"></script>
<title>한 눈에 보는 복지자원생태도</title>
</head>

<body>
	<div class="welfare-map-wrap">
		<h1>한 눈에 보는 <strong>복지자원생태도</strong></h1>
		
		<!--복지자원 선택-->
		<div class="welfare-select">
			<form onsubmit="return false;">
				<span class="checks check1">
					<input type="checkbox" name="category" id="category1" value="행정기관" onclick="javascript:showMarkers();" checked="checked"><label for="category1">행정기관</label>
				</span>
				<span class="checks check2">
					<input type="checkbox" name="category" id="category2" value="복지" onclick="javascript:showMarkers();" checked="checked"><label for="category2">복지</label>
				</span>
				<span class="checks check3">
					<input type="checkbox" name="category" id="category3" value="일자리" onclick="javascript:showMarkers();" checked="checked"><label for="category3">일자리</label>
				</span>
				<span class="checks check4">
					<input type="checkbox" name="category" id="category4" value="장애인" onclick="javascript:showMarkers();" checked="checked"><label for="category4">장애인</label>
				</span>
				<span class="checks check5">
					<input type="checkbox" name="category" id="category5" value="어르신" onclick="javascript:showMarkers();" checked="checked"><label for="category5">어르신</label>
				</span>
				<span class="checks check6">
					<input type="checkbox" name="category" id="category6" value="아동청소년" onclick="javascript:showMarkers();" checked="checked"><label for="category6">아동&middot;청소년</label>
				</span>
				<span class="checks check7">
					<input type="checkbox" name="category" id="category7" value="가정" onclick="javascript:showMarkers();" checked="checked"><label for="category7">가정</label>
				</span>
				<span class="checks check8">
					<input type="checkbox" name="category" id="category8" value="건강" onclick="javascript:showMarkers();" checked="checked"><label for="category8">건강</label>
				</span>
				<span class="checks check9">
					<input type="checkbox" name="category" id="category9" value="문화및여가" onclick="javascript:showMarkers();" checked="checked"><label for="category9">문화 및 여가</label>
				</span>
				<span class="checks check10">
					<input type="checkbox" name="category" id="category10" value="기타" onclick="javascript:showMarkers();" checked="checked"><label for="category10">기타</label>
				</span>
			</form>
		</div>
		
		<!--지도 영역-->
		<div id="map" style="width:100%;height:496px;border:2px solid #6d635b;background:#fff;margin-top:10px;"></div>
								
		<!--1.리스트 전체영역-->
		<div class="welfare-list-wrap">
			
			<!--검색 폼-->
			<div class="welfare-search">
				<form name="frm" onsubmit="return false;">
					<h2>찾아보기</h2>
					<span class="f-item wid-20">
						<select name="cate_large" id="cate_large">
							<option value="">대분류(전체)</option>
							<option value="행정기관">행정기관</option>
							<option value="복지">복지</option>
							<option value="일자리">일자리</option>
							<option value="장애인">장애인</option>
							<option value="어르신">어르신</option>
							<option value="아동청소년">아동청소년</option>
							<option value="가정">가정</option>
							<option value="건강">건강</option>
							<option value="문화및여가">문화및여가</option>
							<option value="기타">기타</option>
						</select>
					</span>
					<span class="f-item wid-20">
						<select name="cate_small" id="cate_small">
							<option value="">소분류(전체)</option>
						</select>
					</span>
					<span class="f-item wid-30"><input type="text" name="fname" placeholder="시설명"></span>
					<button class="btn btn-dark btn-search" type="button" onclick="javascript:getList(1);">찾기</button>
				</form>
			</div>
									
			<!--리스트-->						
			<div id="mapList" style="display:none;" class="welfare-list"></div>
			<div id="mapView" style="display:none;" class="welfare-view-wrap"></div>

		</div>
	</div>

<script>
    var mapOptions = {
    	    center: new naver.maps.LatLng(37.558937,126.850642),
    	    zoom: 8,
    	    zoomControl: true
    	};
    var map = new naver.maps.Map('map', mapOptions);
    
    /*마커겹침처리 객체 등록*/
    var recognizer = new MarkerOverlappingRecognizer({
        highlightRect: false,
        tolerance: 5
    });
    recognizer.setMap(map);


var markers = [], infoWindows = []; 
var	cates = [], addrs = [], anchorxs = [], anchorys = [], fnames = [], homepages = [], tels = [], addrs = [], seqs = []; 

 $.ajax({
	url:'mapList.jsp',
	type: 'POST',
	dataType: 'json',
	async: false,
	success: function(data){
		$.each(data.mapList, function(i,n){
			seqs.push(n.seq);
			addrs.push(n.addr);
			fnames.push(n.fname);
			homepages.push(n.homepage);
			tels.push(n.tel);
			anchorxs.push(n.anchorx);
			anchorys.push(n.anchory);
			cates.push(n.cate_large);
		});
	},
 	error:function(request,status,error){
     	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
}); 

 
//분류별 아이콘 설정
function setIcon(idx) {
	if(cates[i] == "행정기관"){
		return "rc/img/cate-point1.png";
	}
	if(cates[i] == "복지"){
		return "rc/img/cate-point2.png";
	}
	if(cates[i] == "일자리"){
		return "rc/img/cate-point3.png";
	}
	if(cates[i] == "장애인"){
		return "rc/img/cate-point4.png";
	}
	if(cates[i] == "어르신"){
		return "rc/img/cate-point5.png";
	}
	if(cates[i] == "아동청소년"){
		return "rc/img/cate-point6.png";
	}
	if(cates[i] == "가정"){
		return "rc/img/cate-point7.png";
	}
	if(cates[i] == "건강"){
		return "rc/img/cate-point8.png";
	}
	if(cates[i] == "문화및여가"){
		return "rc/img/cate-point9.png";
	}
	if(cates[i] == "기타"){
		return "rc/img/cate-point10.png";
	}
	return "rc/img/cate-point1.png";
}


// 마커 ,인포윈도우 생성
for(var i=0; i<seqs.length; i++) {
	var marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(anchorys[i], anchorxs[i]),
	    map: map,
	    title: fnames[i],
	    zIndex: 100,
	    icon: {
	    	url : setIcon(i),
	    	size: new naver.maps.Size(18, 21),
	    }
	}); 
	var infoWindow = new naver.maps.InfoWindow({
	    content: 
	    	'<div class="talk-bubble">'
	    	+ '<strong class="talk-tit">'+fnames[i]+'</strong>'
	    	+ '<div class="talk-bubble-inner"><ul>'
	    	+ '<li><span class="badge">주소</span>'+addrs[i]+'</li>'
	    	+ '<li><span class="badge">전화</span>'+tels[i]+'</li>'
	    	+ '<li><span class="badge">홈페이지</span><a href="'+homepages[i]+'" target="_blank" title="새 창열기">'+homepages[i]+'</a></li></ul>' 
			+ '<div class="talk-btns"><a href="javascript:detail(\'' + (i+1) + '\')" class="btn btn-small btn-dark" >자세히보기</a>'
			+ '<a href="http://map.naver.com/?elat=' +anchorys[i]+ '&elng=' +anchorxs[i]+ '&eText=' +fnames[i]+ '" class="btn btn-small btn-dark" target="_blank">길찾기</a>'
			+ '<a href="javascript:closeInfoWindow(\'' +i+ '\')" class="btn btn-small">창닫기</a></div>'
	    	
	});
	markers.push(marker);
	infoWindows.push(infoWindow);

	recognizer.add(marker);
    window.MARKER = marker;
}


// 마커 클릭 이벤트 등록
function getClickHandler(seq) {
    return function(e) {
        var marker = markers[seq],
            infoWindow = infoWindows[seq];

        if (infoWindow.getMap()) {
            infoWindow.close();
        } else {
            infoWindow.open(map, marker);
        }
    }
}
for (var i=0, ii=markers.length; i<ii; i++) {
    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
}


//체크한 카테고리 마커만 보이기
function showMarkers() {
	var checkTypeArr = $("input[name='category']:checked");
	var checkYn = false;
	
	for(var i=0; i<cates.length; i++) {
		checkYn = false;
		
		checkTypeArr.each(function(){
			if(cates[i] == this.value)	checkYn = true;
		});
		
		if(checkYn){
			markers[i].setVisible(true);
		}else {
			markers[i].setVisible(false);
		}
	}
}

//해당 좌표로 센터 설정 and 해당마커만 보이기
function setCenter(x, y, seq) {
	for(var i=0; i<markers.length; i++){
		markers[i].setVisible(false);
	}
	markers[seq-1].setVisible(true);
	
	map.setCenter(new naver.maps.LatLng(y,x));
	map.setZoom(12, true);
}

function closeInfoWindow(idx) {
	infoWindows[idx].close();
}


//좌표찾기 임시
function getAnchor() {
	var addr = $('#findAnchor').val();
	naver.maps.Service.geocode({
        address: addr
    }, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert(status);
        }

        var item = response.result.items[0];
        $('#resultAnchor').val(item.point.x + ' , ' +item.point.y);

    });
}


/********** 지도 목록관련 ajax 스크립트 시작 ***********/
var page_size = 10;
var list_size = 5;

function getList(page) { 
	scl = document.frm.cate_large.value;
	scs = document.frm.cate_small.value;
	sfn = document.frm.fname.value;
	
	$.ajax({
		url:'mapList.jsp',
		type: 'POST',
		data:{
			page_no: page,
			scl: scl,
			scs: scs,
			sfn: sfn
		},
		dataType: 'json',
		async: false,
		success: function(data){
			
			var html = "<table><thead>"
			+ "<tr><th scope=\"col\" style=\"padding:0 10px\">번호</th><th scope=\"col\">시설명</th><th scope=\"col\">주소</th>"
			+ "<th scope=\"col\">전화번호</th><th scope=\"col\">상세정보</th></tr></thead><tbody>";
			
			
			$.each(data.mapList, function(i,n){
				html += "<tr><td>"+n.seq+"</td><td class=\"a-left\">"+n.fname+"</td><td class=\"a-left\">"+n.addr+"</td><td>"+n.tel+"</td>"
					+ "<td><a href=\"javascript:void(0);\" onclick=\"javascript:detail(\'" +n.seq+ "\')\" class=\"btn btn-detail\">자세히보기</a></td></tr>";
			});
			
			html += "<tbody></table>";
			$('#mapList').html(html);
			$('#mapView').css("display", "none");
			$('#btn_list').remove();
			$('#mapList').css("display", "block");
			
			//console.log(data.total_cnt, page);
			getPaging(data.total_cnt, page);
		}
	}); 
}

getList(1);

function getPaging(total_cnt, cur_page) {
	var hasNextPage = true;
	var first_no = parseInt((cur_page-1)/page_size)*page_size + 1;
	var end_no = first_no + page_size - 1;
	if((end_no*list_size) > total_cnt){
		end_no = parseInt((total_cnt-1)/list_size) + 1;
		hasNextPage = false;
	}
	
	//만들기
	var html = "<div class=\"paging\">";
	if(first_no != 1)
		html += '<a href=\"javascript:getList(\'' +(first_no-1)+ '\')\" class=\"btn-prev\"><i>이전</i></a>';
	for(var i=first_no; i<=end_no; i++){
		if(i == cur_page)
			html += '<a href=\"javascript:getList(\'' +i+ '\')\"  class=\"on\">' + i + '</a>';
		else
			html += '<a href=\"javascript:getList(\'' +i+ '\')\">' + i + '</a>';
	}
	if(hasNextPage) 
		html += '<a href=\"javascript:getList(\'' +(end_no+1)+ '\')\" class=\"btn-next\"><i>다음</i></a>';
	
	html +="</div>";
	$('#mapList').append(html);
}

//상세보기
function detail(seq) {
	$.ajax({
		url:'mapView.jsp',
		type: 'POST',
		data : {"seq":seq},
		dataType: 'json',
		success: function(data){
			var inhtml = "<h3>"+data.fname+"</h3>";			
			inhtml += "<ul class=\"welfare-view-list\">"
				 + "<li><span class=\"badge\">주소</span>"+data.addr+"</li>"
				 + "<li><span class=\"badge\">전화</span>"+data.tel+"</li>"
				 + "<li><span class=\"badge\">홈페이지</span><a href=\""+data.homepage+"\" target=\"_blank\" title=\"새 창열기\">"+data.homepage+"</a></li></ul>"
				 + "<h2>"+data.detail+"</h2>";				 
			$('#mapView').html(inhtml);
				 
			if($('#btn_list').length == 0) {	//지도 윈도인포에서 자세히보기 클릭시 목록버튼 중복추가 방지
				var afterHtml = "<div class=\"btn-wrap\" id=\"btn_list\"><a class=\"btn btn-dark btn-list\" href=\"javascript:void(0);\" onclick=\"goList();\">목록보기</a></div>";
				$('#mapView').after(afterHtml);
			}
			
			$('#mapList').css("display", "none");
			$('#mapView').css("display", "block"); 
			document.getElementById("map").scrollIntoView();
			
			setCenter(data.anchorx, data.anchory, seq);
		}
	});
}

function goList() {
	$('#mapView').css("display", "none");
	$('#btn_list').remove();
	$('#mapList').css("display", "block");
	
	for(var i=0; i<markers.length; i++){
		markers[i].setVisible(true);		
	}
	map.setCenter(new naver.maps.LatLng(37.558937,126.850642));
	map.setZoom(8, true);
}


	//소분류 가져오기
	$('select[name=cate_large]').change(function() {
		cate_large = $('select[name=cate_large]').val();
		$.ajax({
			url:'mapCategory.jsp',
			type: 'POST',
			data : {"cate_large":cate_large},
			dataType: 'html',
			success: function(data){
				$('#cate_small').html(data);
			}
		});
	});


/********** 지도 목록관련 ajax 스크립트 끝 ***********/
</script>

</body>
</html>
