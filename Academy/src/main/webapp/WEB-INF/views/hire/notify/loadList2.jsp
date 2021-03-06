<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="viewData" value="${viewData}"/>

<!-- 게시판 생성 -->
<div class="content">
	<ul class="list">
	<c:choose>
		<c:when test="${viewData.isEmpty()}">
		</c:when>
		<c:otherwise>
			<c:forEach var="HireVO" items="${viewData.objList}">
				<li>
					<label for="${HireVO.boardNum}">
						<a class="boardNum" name="${HireVO.boardNum}">
							<div>
								<img alt="이미지없음" src="${HireVO.photo}">
								<p class="hide" style="font-size: 14px; font-family: notokr-bold; font-weight: 600;">${HireVO.title}</p>
								<p class="hide">${HireVO.content}</p>
								<p class="hide">1차 면접 :
								<fmt:parseDate value="${HireVO.date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${dateFmt}"  pattern="yyyy-MM-dd(E)"/>
								</p>
							</div>
						</a>
					 </label>
					<input type="checkbox" id="${HireVO.boardNum}" class="delchk" name="delchk" value="${HireVO.boardNum}">
				</li>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</ul>
</div>

<hr>


<!-- 페이징 처리 -->
<c:choose>
	<c:when test="${viewData.isEmpty()}">
	</c:when>
	<c:otherwise>
		<div class="paging">
			<div class="inbox">
				<c:choose>
					<c:when test="${viewData.pageTotalCount == 1}">
						<a class="current">1</a>
					</c:when>
					<c:otherwise>
						<c:forEach varStatus="i" begin="${viewData.startPage}"
							end="${viewData.endPage}">
							<c:choose>
								<c:when test="${i.index == viewData.currentPageNumber}">
									<a class="current" name="${i.index}">${i.index}</a>
								</c:when>
								<c:otherwise>
									<a class="page" name="${i.index}">${i.index}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
	</c:otherwise>
</c:choose>



<script type="text/javascript">

$(document).ready(function(){
	
	//선택한 회원을 탈퇴처리
	$('#dbdelete').off('click').on('click', function(){
		
			//선택한 항목을 배열로 만들어준다.
		    var boardlength = $("input[name='delchk']:checked").length;
			if (boardlength > 0) {
				var delOK;
				delOK =	confirm('정말 삭제하시겠습니까??');
				if (delOK) {
				    var boardArray = new Array(boardlength);
				    for(var i=0; i<boardlength; i++){                          
				    	boardArray[i] = $("input[name='delchk']:checked")[i].value;
				    }
					
						$.ajax({
							url : '<%=request.getContextPath()%>/hire/notify/delete',
							method : 'POST',
							type: "json",
							data : JSON.stringify(boardArray),
							contentType: "application/json",
							error : function(error) {
						        alert("Error!");
						    },
							success : function(data) {
								alert(data);
								//기본 화면으로 불러온다. 
								location.href = '<%=request.getContextPath()%>/hire/notify2'
							}
						});
					
				};
			} else {
				alert("선택된 게시물이 없습니다.");
			}
		
	});
	
	$('#totalCount').html(${viewData.objTotalCount});
	
	$('#pageNum').html(${viewData.currentPageNumber});
	
	$('#totalPage').html(${viewData.pageTotalCount});
	
	
	
	//리스트를 불러오는 함수
	function loadList(pageNumber, rowNum){
		
		$(this).unbind();	
		
		$.ajax({
			url : '<%=request.getContextPath()%>/hire/notify2/loadList2?pageNumber='+ pageNumber 
				+ '&rowNum=' + rowNum,
			type : 'GET',
			error : function(error) {
		        alert("Error!");
		    },
			success : function(data) {
				$('#board').html(data);
			}
		});
		
	}
	
	//열 번호를 클릭하면 해당 줄 수만큼 페이지를 불러온다.
	$('.row').off('click').click(function() {
		
		var rowNum = $(this).attr('name');
		
		$('#rowNum').attr('name', rowNum);
		
		loadList(1, rowNum);
		
	});
	
	//페이지 번호를 클릭하면 페이지를 불러온다.
	$('.page').off('click').click(function() {
		
		var pageNumber = $(this).attr('name');
		
		var rowNum = $('#rowNum').attr('name');
		
		loadList(pageNumber, rowNum);
		
		
	});
	
	
});

</script>
