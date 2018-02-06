# Layer Popup 
> 지정된 옵션으로 레이어 팝업을 띄운다

## Usage
~~~
<!doctype html>
<html>
<head>
<title>example</title>
<script src="popup.js"></script>
</head>
<body>
    <h4>contents</h4>
		<!-- layer popup -->
		<div id="mainPopLayer" style="display:none;">
			<img src="images/img_visual.jpg" />
		</div>
    
<script>
	var options = {
		//필수 옵션
		'id' : 'mainPopLayer', 
		'left' : '200px',
		'right' : '300px',
		'startDate' : '2018/01/07 00:00:00',
		'endDate' : '2018/12/22 18:00:00',

		//선택옵션
		'z-index' : '300',				// default 300
		'background-color' : '#ccc'		// default #ffffff
	};
  
  PopJs.pop(options);
</script>
</body>
</html>
~~~

## options
option name        | Description                          | ex                       | necessary
-------------------|--------------------------------------|--------------------------|------------------------------------
`id`               | `팝업창 div element의 아이디를 등록`   | `mainPopLayer`           | Y
`left`             | `팝업창 left 포지션`                  | `100px`                  | Y
`top`              | `팝업창 top 포지션`                   | `100px`                  | Y
`startDate`        | `게시 시작 날짜`                      | `yyyy/mm/dd hh:MM:ss`    | Y
`endDate`          | `게시 마지막 날짜`                    | `yyyy/mm/dd hh:MM:ss`    | Y
`z-index`          | `z-index`                            | `100`                    | N  , default:300
`background-color` | `배경색`                              | `#ccc`                   | N  , default:#ffffff
`width`            | `가로 크기`				| `1000px`		  | N  ,  default:100%
`align-center`	   | `가운데 정렬`				| true or false		  | N , default:false
## License
timpac31
