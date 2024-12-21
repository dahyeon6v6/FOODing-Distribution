<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>FOODing 모임 게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/read.css">

</head>
<body>
<c:import url = "/top.jsp" />
<section class="read-section">
    <div class="read-container">

        <h1>글읽기</h1>
        <table>
            <tr>
                <td colspan="3">글쓴이 : ${write.member.mnick}</td>
            </tr>
            <tr>
                <td>글 번호</td>
                <td>${write.wno}</td>
            </tr>
            <tr>
                <td>작성날짜</td>
                <td>${write.dateToString}</td>
            </tr>
            <tr>
                <td>글 제목</td>
                <td>${write.wtitle}</td>
            </tr>
            <tr>
                <td>글 내용</td>
                <td colspan="3">${write.wcontent}</td>
            </tr>
        </table>

        <div class="button-container">

            <c:choose>
                <c:when test="${canEdit}">
                    <div class="left-btn">
                        <a href="${pageContext.request.contextPath}/board?gno=${gno}" class="btnList">목록</a>
                    </div>
                    <div class="right-btn">
                        <a href="${pageContext.request.contextPath}/writeUpdate?wno=${write.wno}" class="btnUpdate">수정</a>
                    </div>
                    <div class="right-btn">
                        <a href="#" class="btnDelete" onclick="document.getElementById('deleteForm').submit(); return false;">삭제</a>

                        <form id="deleteForm" action="${pageContext.request.contextPath}/writeDelete" method="post">
                            <input type="hidden" name="wno" value="${write.wno}"/>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="left-btn">
                        <a href="${pageContext.request.contextPath}/board?gno=${gno}" class="btn">목록</a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
        <form:hidden path="board.bno" value="${bno}" />


    </div>
</section>
<c:import url = "/bottom.jsp" />