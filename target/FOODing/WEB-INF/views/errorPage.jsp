<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>잘못된 접근입니다.</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/errorPage.css">
</head>
<body>
<c:import url="/topNoneNav.jsp" />

<section class="error-section">
    <div class="error-container">
        <h2 class="error-message">잘못된 접근입니다.</h2>
        <a href="<%= request.getContextPath() %>/main" class="button">홈페이지로 이동</a>
    </div>
</section>

<c:import url="/bottom.jsp" />