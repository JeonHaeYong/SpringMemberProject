<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Read</title>
<style>
	#wrapper{
		width: 80%;
		margin: auto;
		border: 1px solid black;
	}
	#titleBox h2{
		text-align: center;
	}
	#imageBox{
		width: 50%;
		margin: auto;
		text-align: center;
	}
	#imageBox img{
		max-width: 100%;
	}
	#contentBox{
		border: 1px solid black;
		margin: 10px;
		padding: 10px;
	}
	#contentBox img{
		max-width: 100%;
	}
	#infoBox div{
		width: 100%;
		text-align: center;
	}
	.seq{
		display: inline-block;
		width: 10%;
	}
	.writer{
		display: inline-block;
		width: 20%;
	}
	.view{
		display: inline-block;
		width: 10%;
	}
	.date{
		display: inline-block;
		width: 20%;
	}
	#btnBox{
		text-align: right;
		margin: 10px;
	}
	.btnForm{
		display: inline-block;
	}
	.btn{
		width: 60px;
		height: 30px;
	}
</style>
</head>
<body>
	<div id="wrapper">
		<div id="titleBox"><h2>${dto.title }</h2></div>
		<div id="imageBox"><img src="${dto.image }"></div>
		<div id="infoBox">
			<div>
				<span class="seq">seq</span>
				<span class="writer">writer</span>
				<span class="view">view</span>
				<span class="date">date</span>
			</div>
			<div>
				<span class="seq">${dto.seq }</span>
				<span class="writer">${dto.writer }</span>
				<span class="view">${dto.view_count }</span>
				<span class="date">${dto.write_date }</span>
			</div>
		</div>
		<div id="contentBox">${dto.contents }</div>
		<div id="btnBox">
			<c:if test="${sessionScope.loginId == dto.writer }">
				<form action="articleModifyForm" class="btnForm">
					<input type="submit" class="btn" id="modifyBtn" value="Modify">
					<input type="hidden" name="seq" value="${dto.seq }">
					<input type="hidden" name="currentPage" value="${currentPage }">
				</form>
				<form action="deleteArticle" id="deleteArtiForm" class="btnForm">
					<input type="button" class="btn" id="deleteBtn" value="Delete">
					<input type="hidden" name="seq" value="${dto.seq }">
				</form>
			</c:if>
			<form action="board" class="btnForm">
				<input type="submit" class="btn" id="listBtn" value="List">
				<input type="hidden" name="currentPage" value="${currentPage }">
			</form>
			<form action="/" class="btnForm">
				<input type="submit" class="btn" id="mainBtn" value="Main">
			</form>
		</div>
	</div>
	
	<script>
		$("#deleteBtn").on("click", function(){
			if(confirm("정말 삭제하시겠습니까?")){
				$("#deleteArtiForm").submit();
			}
		});
		$("#listBtn").on("click", function(){
			location.href = "board?currentPage=${currentPage}";
		});
		$("#mainBtn").on("click", function(){
			location.href = "/";
		});
	</script>
</body>
</html>