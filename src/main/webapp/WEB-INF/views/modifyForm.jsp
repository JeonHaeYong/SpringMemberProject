<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Modify</title>
<style>
	#wrapper{
		width: 500px;
		height: 500px;
		margin: auto;
		text-align: center;
	}
	h2{
		text-align: center;
	}
	#imageBox{
		width: 300px;
		height: 300px;
		margin: auto;
	}
	#imageBox img{
		max-width: 300px;
		max-height: 300px;
	}
	.float{
		float: left;
		width: 100px;
	}
	#btnBox{
		margin: 20px;
		text-align: right;
	}
</style>
</head>
<body>
	<div id="wrapper">
		<form action="modify" method="post">
			<h2>${dto.name }님의 PROFILE</h2>
			<div id="imageBox"><img src="${dto.profileImg }"></div>
			<div class="float">IMAGE</div><div><input type="file" name="image" id="image"></div>
			<div class="float">ID</div><div>${dto.id }</div>
			<div class="float">PASSWORD</div><div><input type="password" id="pw" name="pw"></div>
			<div class="float">PWCHECK</div><div><input type="password" id="pw2"></div>
			<div class="float">NAME</div><div><input type="text" name="name" value="${dto.name }"></div>
			<div class="float">PHONE</div><div><input type="text" name="phone" value="${dto.phone }"></div>
			<div class="float">EMAIL</div><div><input type="email" name="email" value="${dto.email }"></div>
			<div id="btnBox">
				<input type="submit" id="modifyBtn" value="Modify">
				<button type="button" id="mainBtn">Main</button>
			</div>
		</form>
	</div>
	
	<script>
		$("#mainBtn").on("click", function(){
			location.href = "/";
		});
		$("#image").on("change", function(){
			var data = new FormData();
			data.append("image", $(this)[0].files[0]);
			$.ajax({
				url: "modifyProfileImg",
				type:"POST",
				data: data,
				contentType: false,
				enctype: "multipart/form-data",
				processData: false
			}).done(function(resp){
				$("#imageBox").html("<img src='" + resp + "'>");
			});
		});
	</script>
</body>
</html>