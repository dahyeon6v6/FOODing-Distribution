<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ID 찾기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findIDResult.css">
</head>
<body>
<c:import url="/topNoneNav.jsp" />

<section>
    <div class="findIDResult-container">
        <h2>ID 찾기</h2>

        <div class="IDResult">
            <p>${mnamemessage}</p>
            <p class="IDmessage">${IDmessage}</p>
            <p>${message}</p>
        </div>
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/login">로그인</a>
            <a href="${pageContext.request.contextPath}/findPass_IdAuth">비밀번호 찾기</a>
        </div>
    </div>
</section>

<c:import url="/bottom.jsp" />