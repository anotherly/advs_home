<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javaScript" language="javascript">
function fn_paging(paramMap){
	var innerHtml = "";
	if(paramMap.maxPage > 0) {
		innerHtml +='<li><a href="javascript:fn_paging_move(1);" title="처음 페이지">&lt;&lt;</a></li>';
		if(paramMap.currentPage == 1){
			innerHtml +='<li><a href="javascript:fn_paging_move('+paramMap.currentPage+');" title="이전 페이지">&lt;</a></li>';
		}else if(paramMap.currentPage != 1){
			innerHtml +='<li><a href="javascript:fn_paging_move('+(paramMap.currentPage-1)+');" title="이전 페이지">&lt;</a></li>';
		}
		for(var i=paramMap.leastPage; i<=paramMap.greatestPage; i++){ //한번에 보여주는 페이징처리 갯수 조정
			if(paramMap.currentPage == i){
				innerHtml += '<li><strong style="font-weight: bold;">'+i+'</strong></li>';
			}else{
				innerHtml += '<li><a href="javascript:fn_paging_move('+i+');">'+i+'</a></li>';
			}
		}
		if(paramMap.currentPage == paramMap.maxPage){
			innerHtml +='<li><a href="javascript:fn_paging_move('+paramMap.maxPage+');" title="다음 페이지">&gt;</a></li>';
		}else if(paramMap.currentPage != paramMap.maxPage){
			innerHtml +='<li><a href="javascript:fn_paging_move('+(paramMap.currentPage+1)+');" title="다음 페이지">&gt;</a></li>';
		}
		innerHtml +='<li><a href="javascript:fn_paging_move('+paramMap.maxPage+');">&gt;&gt;</a></li>';
	}else{
		
	}
	//console.log(innerHtml);
	$("#pagination").html(innerHtml);
	
	/* var innerHtmlCounter = "";
	var totListCnt = "<strong>"+paramMap.listCnt+"</strong>";
	if(paramMap.listCnt > 0){
		innerHtmlCounter += '<span>total : <strong>'+paramMap.listCnt+'</strong>건</span><span>['+paramMap.currentPage+'/<strong>'+paramMap.maxPage+'</strong>] </span>';
	}else{
		innerHtmlCounter += '<span>total : <strong>'+paramMap.listCnt+'</strong>건</span>';
	}
	$("#total_counter").html(innerHtmlCounter); */
/*
버전1
	<a class="dir" href="javascript:fn_paging(1);"><img src="/images/contents/paginate_first.gif" alt="처음 페이지로" /></a>
    <c:if test="${paramMap.currentPage eq 1}">
	<a class="dir first" href="javascript:fn_paging(${paramMap.currentPage});"><img src="/images/contents/paginate_prev.gif" alt="이전 페이지로" /></a>
    </c:if>
    <c:if test="${paramMap.currentPage ne 1}">
	<a class="dir first" href="javascript:fn_paging(${paramMap.currentPage-1});"><img src="/images/contents/paginate_prev.gif" alt="이전 페이지로" /></a>
    </c:if>
    <c:forEach var="i" begin="${paramMap.currentPage}" end="${paramMap.maxPage}" step="1">
        <c:choose>
            <c:when test="${i eq paramMap.currentPage}">
                <strong><c:out value="${i}"/></strong>
            </c:when>
            <c:otherwise>
                <a href="javascript:fn_paging(${i});"><c:out value="${i}"/></a>
            </c:otherwise>
        </c:choose>
        <!--<c:if test="${not status.last}">|</c:if>-->
    </c:forEach>
	<a class="dir last" href="javascript:fn_paging(${paramMap.currentPage+1});"><img src="/images/contents/paginate_next.gif" alt="다음 페이지로" /></a>
	<a class="dir" href="javascript:fn_paging(${paramMap.maxPage});"><img src="/images/contents/paginate_last.gif" alt="마지막 페이지로" /></a>
	*/
}
</script>
    <ul id="pagination" class="pagination"></ul>
    <input type="hidden" name="currentPage" id="currentPage" value="" />
   <br/>