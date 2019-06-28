<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Board</title>
<style>
	#wrapper{
		width: 80%;
		margin: auto;
	}
	#wrapper h1{
		text-align: center;
	}
	.cardForm{
		margin: auto;
	}
	.card{
		width: 80%;
		height: 200px;
		border-radius: 20px;
		border: 1px solid black;
		cursor: pointer;
		margin: auto;
	}
	.textBox{
		width: 70%;
		height: 100%;
	}
	.title{
		text-align: center;
	}
	.imageBox{
		width: 30%;
		height: 200px;
	}
	.card img{
		width: 100%;
		height: 100%;
		border-radius: 20px;
	}
	.card div{
		float: left;
	}
	.contentsBox{
		float: none !important;
		width: 90%;
		overflow: hidden;
		text-overflow: ellipsis;
		display:-webkit-box;
		-webkit-line-clamp:3; /* 라인수 */
		-webkit-box-orient:vertical;
		word-wrap: break-word;
		height: 100px;
		line-height: 33px;
		margin: auto;
	}
	.infoBox{
		width: 90%;
		text-align: center;
		padding: 10px;
	}
	.writer{
		display: inline-block;
		width: 30%;
	}
	.view{
		display: inline-block;
		width: 10%;
	}
	.date{
		display: inline-block;
		width: 50%;
	}
	#naviBox{
		text-align: center;
		margin: 15px;
	}
	#naviBox a{
		display: inline-block;
		width: 30px;
		height: 30px;
		background-color: #fce7a7;
		text-decoration:none;
		font-size: 20px;
		color: #e89c20;
	}
	#btnBox{
		width: 80%;
		text-align: right;
		margin: auto;
	}
	.btn{
		width: 60px;
		height: 30px;
	}
	.chatBoxControl{
		position: fixed;
		width: 50px;
		height:50px;
		top: 50px;
		right:0px;
	}
	.chatBoxControl img{
		width: 100%;
		height: 100%;
		cursor: pointer;
	}
	.chatBox{
		position: fixed;
		width: 300px;
		height: 400px;
		top: 100px;
		right: -300px;
		border: none;
		background-color: #fce7a7;
		transition-duration: 1s;
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
		width: 78%;
		height: 100%;
		box-sizing: border-box;
		border-radius: 20px;
	}
	#send{
		width: 19%;
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
	<div id="wrapper">
		<h1>BOARD</h1>
		<c:forEach var="dto" items="${list }">
			<form action="read" class="cardForm">
				<input type="hidden" name="seq" value="${dto.seq }">
				<input type="hidden" name="currentPage" value="${pageNavi.currentPage }">
				<div class="card">
					<div class="imageBox">
						<img src="${dto.image }">
					</div>
					<div class="textBox">
						<p><h3 class="title">${dto.title }</h3></p>
						<div class="contentsBox">${dto.contents }</div>
						<div class="infoBox">
							<span class="writer">✎${dto.writer }</span>
							<span class="view">👁${dto.view_count }</span>
							<span class="date">🗓${dto.write_date }</span>
						</div>
					</div>
				</div>
			</form>
		</c:forEach>
		<div id="naviBox">
			<c:if test="${pageNavi.needPrev == 1 }">
				<a href="board?currentPage=${pageNavi.startNavi - 1}">&laquo;</a>
			</c:if>
			<c:if test="${pageNavi.currentPage > pageNavi.startNavi }">
				<a href="board?currentPage=${pageNavi.currentPage - 1}">&lt;</a>
			</c:if>
			<c:forEach var="i" begin="${pageNavi.startNavi}" end="${pageNavi.endNavi}">
				<a href="board?currentPage=${i }" class="pageNum">${i}</a>
			</c:forEach>
			<c:if test="${pageNavi.currentPage < pageNavi.pageTotalCount }">
				<a href="board?currentPage=${pageNavi.currentPage + 1}">&gt;</a>
			</c:if>
			<c:if test="${pageNavi.needNext == 1 }">
				<a href="board?currentPage=${pageNavi.endNavi + 1}">&raquo;</a>
			</c:if>
		</div>
		<div id="btnBox">
			<input type="button" class="btn" id="writeBtn" value="Write">
			<input type="button" class="btn" id="mainBtn" value="Main">
		</div>
	</div>
	
	<div class="chatBoxControl">
		<img src="/resources/chat.png" id="chatOpenBtn">
		<img src="/resources/close.png" id="chatCloseBtn" style="display:none">
	</div>
	<div class="chatBox">
		<div class="contents">
			
		</div>
		<div class="control">
			<input type="text" id="input">
			<input type="button" id="send" value="Send">
		</div>
	</div>
	
	<script>
		var contents = $(".contentsBox").text();
		var socket = new WebSocket("ws://192.168.60.32/chat");
		if(${sessionScope.loginId == null}){
			$("#input").attr("placeholder", "로그인 후 이용해주세요.");
			$("#input").attr("disabled", "true");
			$("#send").attr("disabled", "true");
		}
		
		$(".pageNum").each(function(i, item){
			var pageNum = $(item).text();
			if(${pageNavi.currentPage} == pageNum){
				$(item).css("background-color", "#ebd698");
			}
		})
		socket.onmessage = function(evt){	// 서버로부터 메세지가 도착한 경우
			console.log(evt.address);
			$(".contents").append("<p>" + evt.data + "</p>");
			$(".contents").scrollTop($(".contents")[0].scrollHeight);
		}
		
		$("#send").on("click", function(){
			var msg = $("#input").val();
			$(".contents").append("<p class='myMsg'>나: " + msg + "</p>");
			$(".contents").scrollTop($(".contents")[0].scrollHeight);
			$("#input").val("");
			$("#input").focus();
			socket.send(msg);
		});
		$("#input").keydown(function(key){
			if(key.keyCode == 13){
				var msg = $("#input").val();
				$(".contents").append("<p class='myMsg'>나: " + msg + "</p>");
				$(".contents").scrollTop($(".contents")[0].scrollHeight);
				$("#input").val("");
				$("#input").focus();
				socket.send(msg);
			}
		});
		$(".contentsBox").each(function(i, item){
			var contents = $(item).text();
			$(item).text(contents);
		})
		$(".card").on("click", function(){
			$(this).closest(".cardForm").submit();
		});
		$("#writeBtn").on("click", function(){
			location.href = "writeForm";
		});
		$("#mainBtn").on("click", function(){
			location.href = "/";
		});
		
		$("#chatOpenBtn").on("click", function(){
			$(".chatBox").css("right", "0px");
			$(this).css("display", "none");
			$("#chatCloseBtn").css("display", "block");
		});
		$("#chatCloseBtn").on("click", function(){
			$(".chatBox").css("right", "-300px");
			$(this).css("display", "none");
			$("#chatOpenBtn").css("display", "block");
		});
	</script>
</body>
</html>