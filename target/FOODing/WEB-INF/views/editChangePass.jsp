<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 변경</title>
    <script src="${pageContext.request.contextPath}/resources/js/validation.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/changePass.css">

</head>
<body>
<c:import url="/topNoneNav.jsp" />

<section>
    <div class="changePass-container">
    <h2>비밀번호 변경</h2>
        <form:form action="${pageContext.request.contextPath}/editChangePassSave" modelAttribute="member" method="post" onsubmit="return validatePassForm()">


            <label for="currentPassword">현재 비밀번호</label>
            <input id="currentPassword" name="currentPassword" type="password" required><br/>

            <form:label path="mpass">비밀번호</form:label>
            <form:input path="mpass" type="password" value=""/><br/>

            <form:label path="mpassConfirm">비밀번호 확인</form:label>
            <form:input path="mpassConfirm" id="mpassConfirm" name="mpassConfirm" type="password" />
            <button class="button" type="button" onclick="validatePassword()">비밀번호 확인</button>
            <span id="confirmMessage" class="error"></span><br/>
            <form:errors path="mpassConfirm" cssClass="error" />

            <input class="button" type="submit" value="등록" />
        </form:form>
    </div>
</section>

<c:import url="/bottom.jsp" />