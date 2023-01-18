<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

<!-- JQ -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

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
			</a> > BOARD > READ > UPDATE
		</div>

		<h1>자유게시판</h1>
		<p></p>
		<form action="" method="post"  onsubmit="return false" name='updatefrm'>
			<table class="table w-50">
				<tr>
					<td>Title</td>
					<td><input type="text" class="form-control" name="title" value="${boarddto.title }" /></td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type="text" class="form-control" name="email"  value="${boarddto.email}" /></td>
				</tr>				
				<tr>
					<td>Content</td>
					<td><textarea id="" cols="30" rows="10" name="content" class="form-control" >${boarddto.content }</textarea></td>
				</tr>
				<tr>
					<td>Files</td>
					<td>
						<c:set var="filenames" value="${fn:split(boarddto.filename,';')}" />
						<c:set var="filesizes" value="${fn:split(boarddto.filesize,';')}" />
			      
	 					<c:forEach var="i" begin="0" step="1" end="${fn:length(filenames)-1}" >
								<%-- <span>${filenames[i]}</span> <a href="javascript:remove('${pageContext.request.contextPath}','${filenames[i]}','${filesizes[i]}')"> <i class="bi bi-trash3"></i>  </a>	<br> --%>
						<span>${filenames[i]}</span> <a href="${pageContext.request.contextPath}/board/removefile.do?filename=${filenames[i]}&filesize=${filesizes[i]}'&dirpath=${boarddto.dirpath}"> <i class="bi bi-trash3"></i>  </a>	<br>
					
						</c:forEach>  
						 
					</td>
				</tr>	
				<tr>
					<td colspan=2>
						<a   class="btn btn-primary"  href="javascript:updatereq('${pageContext.request.contextPath}')">수정하기</a>
						<a class="btn btn-secondary"  href="javascript:history.go(-1)">이전으로</a>				
					</td>				 
				</tr>												
			</table>
		</form>
		
	</section>


	<script defer>
		const updatereq =function(path){
				
			let form = document.updatefrm;
			form.action=path+"/board/update.do"
			form.submit();
			
			
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