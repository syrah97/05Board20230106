<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- BS5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- BSICON -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<style>
.container{width : 300px; margin:100px auto; text-align:center; position:relative;}
.container *{margin-bottom:10px;}
.container .msg{ position:absolute;left:0px;right:0px;top:-25px; margin:auto; font-size:0.5rem; color:gray; padding-left:15px;}
</style>


</head>
<body>
<section class="container">
	<div class="msg">${msg}</div>
	<h1>LOGIN</h1>
	<form name="loginfrm" action="${pageContext.request.contextPath}/auth/login.do" method="post">
		<input type="text" name="email" placeholder="example@example.com" class="form-control" />
		<input type="password" name="pwd"  placeholder="Insert Password" class="form-control" />
	
		<button class="btn btn-primary w-100">로그인</button>
		<a class="w-100 btn btn-secondary" href="javascript:kakaoLogin()">카카오로그인</a>
		<a href="${pageContext.request.contextPath}/member/join.do">회원가입</a>
		<a href="javascript:void(0)">아이디분실</a>
		<a href="javascript:void(0)">패스워드분실</a>
	</form>
</section>


<!-- 카카오 스크립트 -->
<script  src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script defer>
Kakao.init('ca12c0d4f6ea096e99d25d2d2c9b7c77'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
		scope:'profile_nickname,profile_image, account_email, gender',
		success: function (response) {
        //console.log(response);
    	Kakao.API.request({
        url: '/v2/user/me',
        success: function (resp) {
        	
        	const kakao_account = resp.kakao_account;
        		console.log(resp);
  	 
        		
        	  //	location.href="main.jsp?email="+kakao_account.email;
        	  	
        	  let params="email="+kakao_account.email+"&";
        	  	params+= "gender="+kakao_account.gender+"&";
        	  	params+="profile_image="+kakao_account.profile.profile_image_url;
  			  	alert("${pageContext.request.contextPath}/auth/kakaologin.do?"+params);
        	 	location.href="${pageContext.request.contextPath}/auth/kakaologin.do?"+params;
        	  	
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
</script>

</body>
</html>