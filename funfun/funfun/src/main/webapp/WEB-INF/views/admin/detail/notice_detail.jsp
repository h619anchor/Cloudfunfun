<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
.categories-sidebar-widget {
    max-width: 150px;
    margin-top: 150px;
    margin-left: 50px;
}
.col-sm-8 {
   margin-top: 20px;
}
.comment-form {
   margin-bottom: 50px;
}
</style>
</head>

<body>

<!-- content -->

<!-- content -->
<div class="container">
    <!-- blog content + sidebar -->
    <section id="blog">
        <div class="row">
            <!-- blog content area -->
            <div class="col-sm-8">
                <div class="post-content-area">
                    <div class="media">
                        <div class="media-body">
                            <h3 class="media-heading">${notice.title }</h3>
                            <hr>
							<img src="<c:url value='/resources/upload/${notice.fileData}' />" alt="">                            
                            <hr>
                            <p>${notice.day}</p>
                            <hr>
                            <p>${notice.content}</p>
                            <hr>
                            <p>첨부 파일: ${notice.fileData }</p>
                            
                            <hr>
                            <!-- 수정 폼을 감싸는 div -->
                            <div id="edit-form" style="display: none;">
                              	<textarea id="title" name="title">${notice.title}</textarea>
                              	<hr>
                              	<textarea id="nContent" name="nContent">${notice.content}</textarea>
                              	<hr>
                        		<!-- 수정 버튼 -->
                              	<button id="modifyBtn" type="submit">저장</button>
                              	<button id="cancelModifyBtn" type="button">취소</button>
                            </div>
                        </div><!-- / media-body -->
                    </div><!-- / media -->

                    <div class="post-footer">
                        <div class="pull-left">
                            <a href="javascript:void(0)" id="modify-notice" class="btn btn-xs btn-primary-filled btn-rounded">수정하기</a>
                            <!-- 관리자에게만 보이게 -->
                            <a href="javascript:void(0)" id="delete-notice" class="btn btn-xs btn-primary-filled btn-rounded">삭제하기</a>
                        </div>
                    </div><!-- / post-footer -->
                </div><!-- / blog-block -->
            </div>
            <!-- / col-sm-8 --> 
        </div><!-- / row -->
    </section>
    <!-- / blog content + sidebar -->
</div><!-- / container -->
<!-- / content -->


<!-- javascript -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.easing.min.js"></script>

<!-- preloader -->
<script src="${pageContext.request.contextPath}/resources/js/preloader.js"></script>
<!-- / preloader -->

<script type="text/javascript">
$(document).ready(function() {
	$("#cancelModifyBtn").click(function(){
        $("#edit-form").toggle();
	});
	
    $("#modify-notice").click(function() {
        // 수정 폼을 표시하거나 숨기기
        $("#edit-form").toggle();
    });
    
    $("#modifyBtn").click(function() {
    	var title=$("#title").val();
    	var content=$("#nContent").val();
    	var idx = "${notice.idx}";
    	
    	if(title == "") {
    		alert("제목을 입력해 주세요.");
    		return;
    	}
    	
    	if(content == "") {
    		alert("내용을 입력해 주세요.");
    		return;
    	}
    	
    	$.ajax({
    		type: "PUT",
    		url: "<c:url value="/admin/notice_modify"/>",
    		contentType: "application/json",
    		data: JSON.stringify({"idx":idx, "title":title, "content":content}),
    		dataType: "text",
    		success: function(result) {
    			
    			if(result == "success") {
    			
    			noticeDetail(idx);
    			
    			}
    		},
    		error: function(xhr) {
    			alert("공지 사항 수정 중 오류가 발생하였습니다("+ xhr.status+")");
    		}
    	});
    });
    
	 $("#delete-notice").click(function() {
	        if (confirm("정말로 삭제하시겠습니까?")) {
	            var idx = "${notice.idx}";
	            
	            $.ajax({
	                type: "DELETE",
	                url: "<c:url value='/admin/notice_remove?idx='/>" + idx,
	                success: function(result) {
	                    if(result == "success") {
	                    	noticeListDisplay(page, size, keyword);
	                    } else {
	                        alert("공지 사항 삭제 중 오류가 발생하였습니다.");
	                    }
	                },
	                error: function(xhr) {
	                    alert("공지 사항 삭제 중 오류가 발생하였습니다("+ xhr.status+")");
	                }
	            });
	        }
	    });
});

</script>

<!-- / javascript -->
</body>

</html>