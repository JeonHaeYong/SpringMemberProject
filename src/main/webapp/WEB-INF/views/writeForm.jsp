<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<style>
div {
	/* 	border: 1px solid black; */
	/* 	box-sizing: border-box; */
	text-align: center;
}

.boardTitle {
	height: 100px;
}

.boardTitle h1{
	line-height: 100px;
}

.article {
	/* 	height: 500px; */
	
}

.article>.contents {
	/* 	height: 500px; */
	
}

.content {
	/* 	height: 500px; */
	
}

.content div {
	text-align: left;
}

.inputTitle {
	height: 50px;
	text-align: center;
}

.inputContents {
	/* 	height: 90%; */
	/* 	overflow-y: auto; */
	
}

#title {
	width: 93%;
	height: 100%;
}
#image{
	width: 30%
}
#imageBox{
	width: 60%;
	display: inline-block;
}
#imageBox img{
	max-width: 100%;
	max-height:300px;
}

#contents {
	/* 	height: 430px; */
	border: none;
	/* 	overflow-y: auto; */
	text-align: left;
}

#contents div {
	border: none;
}

#text {
	overflow-y: auto;
}

.article3 {
	text-align: right;
}

.mybtn {
	/*				font-weight: 100;*/
	border: 1px solid black;
/* 	float: right; */
	/* color: white; */
	/* 	background-color: #c89963; */
}

.btn1, .btn2{
	float: right;
}

.mybtn:hover {
	/*				font-weight: 600;*/
	background-color: #c8996390;
}
</style>
</head>
<body>
	<div class="container p-0">
		<div class="boardTitle"><h1>WRITE</h1></div>
		<div class="article p-0 m-0">
			<div class="contents p-0 m-0">
				<form action="write" method="post" id="writeForm">
					<div class="row content col-12 p-0 m-0">
						<div class="inputTitle col-12 p-0">
							Title: <input type="text" name="title" id="title">
						</div>
						<div class="inputImage col-12 p-0">
							Image: <input type="file" id="image">
							<input type="hidden" name=image id="imageSrc">
							<div id="imageBox" class="p-0"></div>
						</div>
						<div class="inputContents col-12 p-0">
							<input type="hidden" id="submitContents" name="contents">
							<div id="contents" class="summernote" contenteditable="true"></div>
						</div>
					</div>
					<div class="row article3 p-0 m-0">
						<a class="btn mybtn btn1 m-0" id="writeBtn">Write</a>
						<a class="btn mybtn btn2 m-0" id="cancelBtn">cancel</a>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		document.getElementById("writeBtn").onclick = function() {
			var title = document.getElementById("title").value;
			var contents = $(".note-editable").html();
			var imageSrc = $("#imageSrc").val();
			contents = contents.replace(/(&lt;.?script&gt;)/g, "script");
			if(imageSrc == ""){
				$("#imageSrc").val("/resources/noimage.png");	
			}
			if (title == "") {
				alert("제목을 입력해주세요.");
			} else if (contents == "") {
				alert("내용을 작성해주세요.");
			} else if (confirm("글 작성을 완료하시겠습니까?")) {
				document.getElementById("submitContents").value = contents;
				document.getElementById("writeForm").submit();
			}
		}
		document.getElementById("cancelBtn").onclick = function() {
			$("img").each(function(index, item) {
				var src = $(this).attr("src");
				$.ajax({
					data : {
						imagePath : src
					},
					type : "POST",
					url : "deleteImage", // replace with your url
					cache : false
				});
			});

			if (confirm("입력하신 내용이 사라집니다. 그래도 취소하시겠습니까?")) {
				location.href = "board";
			}
		}
		$("#image").on("change", function(){
			var data = new FormData();
			data.append("image", $(this)[0].files[0]);
			$.ajax({
				url: "imageUpload",
				type:"POST",
				data: data,
				contentType: false,
				enctype: "multipart/form-data",
				processData: false
			}).done(function(resp){
				$("#imageBox").html("<img src='" + resp + "'>");
				$("#imageSrc").val(resp);
			});
		});
// 		$(window).on("beforeunload", function(){
// 			$("img").each(function(index, item) {
// 				var src = $(this).attr("src");
// 				$.ajax({
// 					data : {
// 						imagePath : src
// 					},
// 					type : "POST",
// 					url : "deleteImage", // replace with your url
// 					cache : false
// 				});
// 			});
// 		})
// 		$(".note-editable").keyup(function(e){
// 			if(e.keyCode == 8)alert('backspace trapped')
// 		})
		$(".summernote").summernote({
			placeholder : 'write text here!',
			height : 310, // 기본 높이값
			minHeight : 310, // 최소 높이값(null은 제한 없음)
			maxHeight : null, // 최대 높이값(null은 제한 없음)
			focus : true, // 페이지가 열릴때 포커스를 지정함
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						sendFile(files[i], this);
					}
				},
				onMediaDelete : function(target) {
					deleteFile(target[0].src);
				}
			}
		});
		function sendFile(file, editor) {
			var data = new FormData(); // <form></form>
			data.append("image", file); // <form><input type="file"></form>
			$.ajax({
				url : "imageUpload",
				data : data,
				type : "POST",
				cache : false,
				contentType : false,
				enctype : "multipart/form-data",
				processData : false
			}).done(function(resp) {
				$(".note-editable").append("<img src='"+resp+"'>");
			})
		}
		function deleteFile(src) {
			$.ajax({
				data : {
					imagePath : src
				},
				type : "POST",
				url : "deleteImage",
				cache : false
			});
		}
	</script>
</body>
</html>