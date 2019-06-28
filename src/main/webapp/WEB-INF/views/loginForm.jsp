<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Login Form</title>
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
		<form action="loginProc">
			<input type="text" name="id"><br>
			<input type="password" name="pw"><br>
			<input type="submit" value="Login">
			<input type="button" id="mainBtn" value="Main">
		</form>
	</div>
	<script>
		$("#mainBtn").on("click", function(){
			location.href = "/";
		})
	</script>
</body>
</html>