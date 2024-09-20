<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>회원가입 선택</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/registerSelect.css">
</head>
<body>
<c:import url = "/topNoneNav.jsp" />

<section>
<div class="registerSelect-container">
    <div class="head-container">
            <h2 class="head">회원가입을 선택해주세요</h2>
    </div>
    <div class="button-container">
        <a href="${pageContext.request.contextPath}/register/user" class="btn-user">일반 회원가입</a>
        <a href="${pageContext.request.contextPath}/checkBusiness" class="btn-owner">사장님 회원가입</a>
    </div>
</div>
</section>

<c:import url = "/bottom.jsp" />
</body>
</html>
