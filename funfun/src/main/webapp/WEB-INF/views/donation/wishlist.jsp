<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="en">
<body>
<!-- preloader -->
<div id="preloader">
    <div class="spinner spinner-round"></div>
</div>
<!-- / preloader -->


    <div id="page-header" class="shopping-cart">
        <div class="container">
            <div class="page-header-content text-center">
                <div class="page-header wsub">
                    <h1 class="page-title fadeInDown animated first">위시리스트</h1>
                </div><!-- / page-header -->
                <p class="slide-text fadeInUp animated second">내가 관심있는 영화제 목록</p>
            </div><!-- / page-header-content -->
        </div><!-- / container -->
    </div><!-- / page-header -->

<!-- content -->

<!-- shopping-cart -->
<div id="shopping-cart">
    <div class="container">
        <!-- shopping cart table -->
        <table class="shopping-cart">
            <thead>
                <tr>
                    <th class="image" style="width: 40%; text-align: center;">영화제</th>
                    <th style="width: 50%; text-align: center;">이름</th>
                	<th>&nbsp;</th>
                </tr>
            </thead>
            <tbody class="wish-items">
            </tbody>
        </table>
	</div>  
	
	<div id="pageNumDiv"></div>
        <!-- / shopping cart table -->
</div>

<!-- / content -->



<!-- javascript -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.easing.min.js"></script>

<!-- preloader -->
<script src="${pageContext.request.contextPath}/resources/js/preloader.js"></script>
<!-- / preloader -->

<!-- / javascript -->
<script type="text/javascript">
var page = 1; // 기본 페이지 번호 설정
var size = 10; // 기본 페이지 크기 설정
//var viewType = 'list'; // 기본 보기 설정 = 목록으로 보기
var wishlistUrl = "${pageContext.request.contextPath}/wish_list"



//위시 리스트 출력 함수
function wishListDisplay(pageNum) {
	$(".wish-items").show();
	$("#pageNumDiv").show();
	page=pageNum;

 $.ajax({
     method: "GET",
     url: wishlistUrl,
     data: {"pageNum": pageNum},
     dataType: "json",
     success: function(result) {
         $(".wish-items").empty();
         
         var tbody = $(".wish-items");

         if (result.wishList.length == 0) { // 검색된 게시글이 없을 때
             var row = "<tr class='wish-item'>"+
                 "<td colspan='2'>관심있는 펀딩 정보를 추가하세요!</td>"+
             "</tr>";
             tbody.append(row);
         } 
         for (var i = 0; i < result.wishList.length; i++) {
        	 var wish = result.wishList[i];
        	 var imagePath = '${pageContext.request.contextPath}/resources/upload/' + wish.mainImg;
        	 var row = "<tr class='wish-item'>" +
        	     "<td class='image'><a href='${pageContext.request.contextPath}/donation/single-festival?idx=" + wish.festivalIdx + "'><img src='" + imagePath + "' width='50px' height='50px' style='object-fit:cover;'/></a></td>" +
        	     "<td style='text-align: center'>" + wish.subject + "</td>" +
        	     "<td><a class='btn btn-danger-filled x-remove wishremove' data-festival-idx='"+wish.festivalIdx+"'>×</a></td>"+
        	     "</tr>";
        	 tbody.append(row);
        }
         // 페이지 번호 출력
         pageNumDisplay(result.pager);
     },
     error: function(xhr) {
         alert("wish 정보를 불러오는 중에 오류가 발생했습니다. (에러 코드 = " + xhr.status + ")");
     }
 });
}





//페이지 번호를 출력하는 함수
function pageNumDisplay(pager) {
 var html = "";
 if (pager.startPage > pager.blockSize) {
     html += "<a href=\"javascript:wishListDisplay(" + pager.prevPage + ");\" class='btn btn-direction btn-default btn-rounded'><i class='fa fa-long-arrow-left'/></a>";
 } else {
	 html += "<a class='btn btn-direction btn-default btn-rounded' disabled><i class='fa fa-long-arrow-right'/></a>";
 }

 for (var i = pager.startPage; i <= pager.endPage; i++) {
     if (pager.pageNum != i) {
         html += "<a class='btn btn-direction btn-default btn-rounded' href=\"javascript:wishListDisplay(" + i + ");\">" + i + "</a>";
     } else {
         html += "<a class='btn btn-direction btn-default btn-rounded' disabled>" + i + "</a>";
     }
 }

 if (pager.endPage != pager.totalPage) {
     html += "<a href=\"javascript:wishListDisplay(" + pager.nextPage + ");\" class='btn btn-direction btn-default btn-rounded'><i class='fa fa-long-arrow-right'/></a>";
 } else {
     html += "<a class='btn btn-direction btn-default btn-rounded' disabled><i class='fa fa-long-arrow-right'/></a>";
 }

 $("#pageNumDiv").html(html);
}

$(document).ready(function () {
	wishListDisplay();

	// 부모 요소에 이벤트 리스너 추가
	$(document).on("click",".wishremove", function() {
		var festivalIdx = $(this).data("festival-idx");
	
	    $.ajax({
	        type: "DELETE",
	        url: "${pageContext.request.contextPath}/wish_remove",
	        contentType: "application/json",
	        data: JSON.stringify({"accountId": "${loginAccount.id}", "festivalIdx": festivalIdx }),
	        dataType: "text",
	        success: function(result) {
	            if(result == "success") {
	            	wishListDisplay();
	            }
	        },
	        error: function(xhr) {
	            alert("찜 취소 중 오류가 발생하였습니다("+ xhr.status+")");
	        }
	    });
	    
	});
	
});


</script>