<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Join Form</title>
<style>
	#wrapper{
		width: 500px;
		margin: auto;
		text-align: center;
	}
	#imageBox{
		border: 0.5px solid black;
		width: 200px;
		height: 200px;
		margin: auto;
	}
	#idCheck, #pwCheck{
		margin: 0px;
		font-size: 13px;
	}
</style>
</head>
<body>
	<div id="wrapper">
		<form action="joinProc" method="post" enctype="multipart/form-data" id="joinForm">
			<div id="imageBox"></div>
			<div><input type="text" id="id" name="id" placeholder="Input ID"></div>
			<p id="idCheck"></p>
			<div><input type="password" id="pw" name="pw" placeholder="Input PW"></div>
			<div><input type="password" id="pw2" placeholder="Check PW"></div>
			<p id="pwCheck"></p>
			<div><input type="file" name="image"></div>
			<div><input type="text" name="name" placeholder="Input NAME"></div>
			<div><input type="text" name="phone" placeholder="Input PHONE"></div>
			<div><input type="email" name="email" placeholder="Input EMAIL"></div>
			<div>
				<input type="button" id="joinBtn" value="Join">
				<input type="button" id="mainBtn" value="Main">
			</div>
		</form>
	</div>
	
	<script>
		$("#id").on("input", function(){
			console.log($(this).val());
			$("#idCheck").text("");
			$.ajax({
				url: "idCheck",
				data: {
					id: $(this).val()
				}
			}).done(function(resp){
				if(resp == "X"){
					$("#idCheck").css("color", "red");
					$("#idCheck").text("이미 존재하는 ID");
				}else if(resp = "O"){
					$("#idCheck").css("color", "green");
					$("#idCheck").text("가입 가능한 ID");
				}
			});
		});
		
		$("#pw").on("input", function(){
			$("#pwCheck").text("");
		});
		$("#pw2").on("input", function(){
			var pw = $("#pw").val();
			if($(this).val() == pw){
				$("#pwCheck").css("color", "green");
				$("#pwCheck").text("비밀번호 일치");
			}else{
				$("#pwCheck").text("");
			}
		});
		$("#joinBtn").on("click", function(){
			$("#joinForm").submit();
		});
		
		$("#mainBtn").on("click", function(){
			location.href = "/";
		})
	</script>
</body>
</html>