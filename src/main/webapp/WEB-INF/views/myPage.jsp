<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>My Page</title>
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
		<h2>${dto.name }님의 PROFILE</h2>
		<div id="imageBox"><img src="${dto.profileImg }"></div>
		<div class="float">ID</div><div>${dto.id }</div>
		<div class="float">NAME</div><div>${dto.name }</div>
		<div class="float">PHONE</div><div>${dto.phone }</div>
		<div class="float">EMAIL</div><div>${dto.email }</div>
		<div id="btnBox">
			<button id="modifyBtn">Modify</button>
			<button id="signOutBtn">SignOut</button>
			<button id="mainBtn">Main</button>
		</div>
	</div>
	
	<script>
		$("#modifyBtn").on("click", function(){
			location.href = "modifyForm";
		})
		$("#signOutBtn").on("click", function(){
			location.href = "signOut";
		});
		$("#mainBtn").on("click", function(){
			location.href = "/";
		});
	</script>
</body>
</html>