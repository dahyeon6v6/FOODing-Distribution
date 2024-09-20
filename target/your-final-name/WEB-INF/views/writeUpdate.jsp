<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>FOODing 모임 게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css">

</head>
<body>
<c:import url = "/top.jsp" />
<section class="write-section">
    <div class="write-container">

        <h1>글쓰기</h1>
        <form:form action="${pageContext.request.contextPath}/writeUpdate" modelAttribute="write" method="post">
        <table>
            <tr>
                <td>글쓴이 : ${member}</td>
            </tr>
            <tr>
                <td><form:input path="wtitle" title="글 제목"  value="${write.wtitle}"/></td>
            </tr>
            <tr>
                <td><form:textarea path="wcontent" placeholder="${write.wcontent}"/></td>
            </tr>
        </table>
            <form:hidden path="board.bno" value="${write.board.bno}" />
            <form:hidden path="wno" value="${write.wno}" />

        <div class="button">
            <button type="submit">수정 완료</button>
        </div>
        </form:form>
    </div>

</section>
<c:import url = "/bottom.jsp" />