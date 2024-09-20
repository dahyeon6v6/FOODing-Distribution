<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>FOODing 모임 게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">

</head>
<body>
<c:import url = "/top.jsp" />
<section class="board-section">
    <div class="board-container">

        <h1>${board.bname}</h1>
        <c:forEach var="boardWrite" items="${boardWrite}" varStatus="status">
            <div class="btnwrite-container">
                <div class="btnwrite">
                    <button><a href="${pageContext.request.contextPath}/write?bno=${boardWrite.bno}">글쓰기</a></button>
                </div>
            </div>
        </c:forEach>
        <c:choose>
        <c:when test="${writes==null}">
            <p>게시물이 존재하지 않습니다.</p>
        </c:when>
        <c:otherwise>
        <table>
            <thead>
                <td>번호</td>
                <td>글제목</td>
                <td>글쓴이</td>
                <td>작성날짜</td>
            </thead>
            <tbody>

            <c:forEach var="write" items="${writes}">
                    <tr>
                        <td>${write.wno}</td>
                        <td><a href="${pageContext.request.contextPath}/read?wno=${write.wno}">${write.wtitle}</a></td>
                        <td>${write.member.mnick}</td>
                        <td>${write.dateToString}</td>
                    </tr>
            </c:forEach>
            </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <div class="pagination">

            <%-- 시작 페이지 번호와 끝 페이지 번호 계산 --%>
            <c:set var="halfSize" value="5" />
            <c:set var="startPage" value="${currentPage - halfSize}" />
            <c:set var="endPage" value="${currentPage + halfSize - 1}" />

            <%-- startPage가 1보다 작을 경우, startPage를 1로 설정하고 endPage를 재조정 --%>
            <c:if test="${startPage < 1}">
                <c:set var="endPage" value="${endPage + (1 - startPage)}" />
                <c:set var="startPage" value="1" />
            </c:if>

            <%-- endPage가 totalPages를 넘을 경우, endPage를 totalPages로 설정하고 startPage를 재조정 --%>
            <c:if test="${endPage > totalPages}">
                <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
                <c:set var="endPage" value="${totalPages}" />
            </c:if>

            <%-- startPage가 다시 1보다 작을 경우, 1로 설정 --%>
            <c:if test="${startPage < 1}">
                <c:set var="startPage" value="1" />
            </c:if>

            <%-- 페이지 번호 출력 --%>
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${i}&size=${size}&gno=${board.group.gno}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</section>
<c:import url = "/bottom.jsp" />