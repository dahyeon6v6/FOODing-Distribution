<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 완료</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/deleteSuccess.css">
 </head>
<body>
<c:import url="/topNoneNav.jsp" />

<section>
    <div class="deleteSuccess-container">
        <h1 class="message">
            회원탈퇴가 완료되었습니다.
        </h1>
        <div class="button">
            <a href="${pageContext.request.contextPath}/registerSelect" class="register">회원가입 화면으로 이동</a>
            <a href="${pageContext.request.contextPath}/main" class="main">메인화면으로 이동</a>
        </div>
    </div>
</section>

<c:import url="/bottom.jsp" />
</body>
</html>
