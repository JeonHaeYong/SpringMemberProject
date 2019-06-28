<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Home</title>
<style>
	#wrapper{
		width: 500px;
		margin: auto;
		text-align: center;
	}
</style>
</head>
<body>
	<div id="wrapper">
		<h1>Hello Spring!</h1>
		<input type="button" id="boardBtn" value="Board">
		<c:choose>
			<c:when test="${sessionScope.loginId != null}">
				<input type="button" id="chatBtn" value="Chat">
				<input type="button" id="myPageBtn" value="MyPage">
				<input type="button" id="logoutBtn" value="Logout">
			</c:when>
			<c:otherwise>
				<input type="button" id="loginBtn" value="Login">
				<input type="button" id="joinBtn" value="Join">
			</c:otherwise>
		</c:choose>
	</div>
	
	<script>
		if(${msg != null}){
			alert("${msg}");
		}
		$("#boardBtn").on("click", function(){
			location.href = "board?currentPage=1";
		})
		$("#loginBtn").on("click", function(){
			location.href = "loginForm";
		})
		$("#joinBtn").on("click", function(){
			location.href = "joinForm";
		})
		$("#myPageBtn").on("click", function(){
			location.href = "myPage";
		})
		$("#logoutBtn").on("click", function(){
			location.href = "logout";
		})
		$("#chatBtn").on("click", function(){
			location.href = "webchat";
		})
	</script>
</body>
</html>