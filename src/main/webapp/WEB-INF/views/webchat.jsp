<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Web Chat</title>
<style>
	div{
		border: 0.5px solid black;
		box-sizing: border-box;
		border-radius: 20px;
	}
	.container{
		width: 400px;
		height: 500px;
		margin: 0 auto;
		border: none;
		background-color: #fce7a7;
	}
	.contents{
		width: 100%;
		height: 85%;
		overflow-y: auto;
		word-wrap: break-word;
	}
	.control{
		width: 100%;
		height: 15%;
	}
	#input{
		width: 79.3%;
		height: 100%;
		box-sizing: border-box;
		border-radius: 20px;
	}
	#send{
		width: 19.2%;
		height: 100%;
		box-sizing: border-box;
		border-radius: 20px;
		background-color: white;
		border: none;
		font-size: 20px;
		transition-duration: 1s;
	}
	#send:hover{
		transition-duration: 1s;
		background-color: #fff4d4;
	}
	.myMsg{
		text-align: right;
	}
</style>
</head>
<body>
	<div class="container">
		<div class="contents">
			
		</div>
		<div class="control">
			<input type="text" id="input">
			<input type="button" id="send" value="Send">
		</div>
	</div>
	
	<script>
		var socket = new WebSocket("ws://192.168.60.32/chat");
		socket.onmessage = function(evt){	// 서버로부터 메세지가 도착한 경우
			console.log(evt.address);
			$(".contents").append("<p>" + evt.data + "</p>");
			$(".contents").scrollTop($(".contents")[0].scrollHeight);
		}
		
		$("#send").on("click", function(){	// 서버로 메세지를 보내는 경우
			var msg = $("#input").val();
			$(".contents").append("<p class='myMsg'>나: " + msg + "</p>");
			$(".contents").scrollTop($(".contents")[0].scrollHeight);
			$("#input").val("");
			$("#input").focus();
			socket.send(msg);
		})
		
	</script>
</body>
</html>