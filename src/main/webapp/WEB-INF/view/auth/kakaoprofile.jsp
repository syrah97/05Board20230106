<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- BS5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- BSICON -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<style>
body {
	padding: 10px;
}

a {
	text-decoration: none;
	color: black;
}

ul {
	list-style: none;
	padding: 0px;
}

header {
	magin-bottom: 10px;
}

header .top-header {
	height: 40px;
}

header .top-header ul {
	display: flex;
	justify-content: right;
	align-items: center;
	height: 40px;
	font-size: 0.6rem;
}

header .top-header ul li {
	margin-left: 10px;
}

header nav {
	height: 50px;
	background-color: #F2F2F2
}

header nav ul {
	height: 50px;
	display: flex;
	justify-content: space-around;
	align-items: center;
}

header nav ul li {
	
}

section {
	height: 600px;
	width: 95vw;
	margin-top: 10px;
}

.container {
	position: relative;
}

.container * {
	margin-bottom: 10px;
}

.container .msg {
	position: absolute;
	left: 0px;
	right: 0px;
	top: -15px;
	margin: auto;
	font-size: 0.5rem;
	color: red;
	padding-left: 15px;
}
</style>


</head>
<body>
	<header>
		<div class="top-header">
			<ul>
				<li><a href="javascript:void(0)">나의정보</a></li>
				<li><a href="${pageContext.request.contextPath}/auth/logout.do">로그아웃</a></li>
				<li><a href="javascript:kakaoLogout('${pageContext.request.contextPath }')">카카오로그아웃</a></li>
			</ul>
		</div>
		<nav>
			<ul>
				<li><a href="javascript:void(0)">회사소개</a></li>
				<li><a href="${pageContext.request.contextPath}/notice/list.do">공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/board/list.do">자유게시판</a></li>
				<li><a href="javascript:void(0)">ETC</a></li>

			</ul>
		</nav>
	</header>

	<section class="container">
		<!-- 메시지 -->
		<div class="msg">${msg}</div>
		<!-- 페이지경로표시 -->
		<div>
			<a href="${pageContext.request.contextPath}/main.do"> <i
				class="bi bi-house-door"></i>
			</a> > 카카오로그인 확인
		</div>

		<h1>프로필정보</h1>
		 
			아이디 : ${param.email }<br>
			성별 : ${param.gender }<br>
			프로필 사진 :  <img src="${param.profile_image }" style="width:50px;height:50px;"  /> <br>
		 


	</section>
 

 


	<!-- 다음주소 API -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		var addr='';		//전역변수로 사용
		<!-- 다음 시작  -->
		function test(){
		new daum.Postcode({
		oncomplete : function(data) {
		 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		 // 예제를 참고하여 다양한 활용법을 확인해 보세요.
		
		 //사용자가 도로명 주소 선택
		 if(data.userSelectedType==='R')
		 {
		 	addr=data.roadAddress;
		 	test2(addr);
		 }
		 else //사용자가 지번 주소 선택 'J'
		 {
		 	addr=data.jibunAddress;
		 	test2(addr);
		 }         
		}	
		}).open(); 
		}
	</script>

	<!-- 다음 끝  -->


	<!-- 카카오 주소로위치 찾기  -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca12c0d4f6ea096e99d25d2d2c9b7c77&libraries=services"></script>


	<script>
	//test 시작
	function test2(addr)
	{
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
		 center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		 level: 3 // 지도의 확대 레벨
		};  

		//지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		//주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {
	
		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {
	
			 var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			 // 결과값으로 받은 위치를 마커로 표시합니다
			 var marker = new kakao.maps.Marker({
					     map: map,
					     position: coords
					 });
			
					 // 인포윈도우로 장소에 대한 설명을 표시합니다
					 var infowindow = new kakao.maps.InfoWindow({
					     content: '<div style="width:150px;text-align:center;padding:6px 0;">'+addr+'</div>'
					 });
					 infowindow.open(map, marker);
			
					 // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					 map.setCenter(coords);
				} 
			});    

	//test 끝
	}
</script>


<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
 <script>
		Kakao.init('ca12c0d4f6ea096e99d25d2d2c9b7c77'); //발급받은 키 중 javascript키를 사용해준다.
		console.log(Kakao.isInitialized()); // sdk초기화여부판단

		//카카오로그아웃  
		function kakaoLogout(path) {
			if (Kakao.Auth.getAccessToken()) {
				Kakao.API.request({
					url : '/v1/user/unlink',
					success : function(response) {
						console.log("RESPONSE : " + response)
						location.href = path+"/auth/logout.do"
					},
					fail : function(error) {
						console.log(error)

					},
				})
				Kakao.Auth.setAccessToken(undefined)
			}
		}
 </script>
</body>
</html>