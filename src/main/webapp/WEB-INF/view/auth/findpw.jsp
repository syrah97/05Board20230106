<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- BS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<!-- JQUERY -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>


<style>
.login {
	width: 300px;
	height: 200px;
	border: 1px solid gray;
	border-radius: 5px;
	margin : 100px auto;
	padding : 10px;
}

</style>
</head>
<body>

	<section class="login">
		<form action="" name="emailform" onsubmit="return false">
				<input type="email" name="email" placeholder="Insert Email" class="form-control" />
				<button onclick="sendmail('${pageContext.request.contextPath}')" class="btn btn-secondary">요청</button>
			 	<input type="hidden" name="step" value="1" />
		</form>
	

	</section>


	<script defer>
		const emailform = document.emailform;
		
		//--------------------
		const sendmail = function(path) 
		{
			alert(emailform.email.value);
			let loginsection = document.querySelector('.login');
			$.ajax({
						url : path + "/mail/sendmail.do", // 읽어올 문서 
						type : 'GET', // 방식 
						data : {"email" : emailform.email.value, "step" : emailform.step.value}, //파라미터 s
						success : function(result) 
						{
							//alert("SUCCESS"); 
							let code = "<div>";
							code +="<form action='' onsubmit='return false' name='confirmform'>"
							code += "<input type=text name=code placeholder='인증코드입력(6자리)' class='form-control' />";
							code += "<button class='btn btn-secondary'  onclick=requestAuth('${pageContext.request.contextPath}')>인증요청</button>";
							code += "<input type='hidden' name='step' value='2' />";
							code += "</form>"
							code += "</div>";
							$(loginsection).append(code)

						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:"
									+ request.responseText + "\n" + "error:"
									+ error);
						}
				});
		}
		//---------------------
		const requestAuth = function(path) 
		{
			
			const confirmform = document.confirmform;
			alert(confirmform.code.value + "," + confirmform.step.value);
			$.ajax({
				url : path + "/mail/sendmail.do", // 읽어올 문서 
				type : 'GET', // 방식 
				data : {"code" : confirmform.code.value,"step" : confirmform.step.value }, //파라미터 
				success : function(result) {
					alert(result); 

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
			
		}
	</script>
	


</body>
</html>