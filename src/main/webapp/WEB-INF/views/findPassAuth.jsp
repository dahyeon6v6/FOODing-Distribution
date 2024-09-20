<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findPassAuth.css">
    <script>
        window.onload = function() {
            if (${not empty num}) {
                document.getElementById('auth').focus();
            } else {
                document.getElementById('mid').focus();
            }
        };
    </script>
</head>
<body>
<c:import url="/topNoneNav.jsp" />

<section>
    <div class="findPassAuth-container">
        <h2>비밀번호 찾기</h2>
        <form class="form-container" action="${pageContext.request.contextPath}/findPassEmail" method="post">
            <div>
                <label for="mid">ID</label>
                <input type="text" id="mid" name="mid" value="${mid}" required>

                <label for="mname">이름</label>
                <input type="text" id="mname" name="mname" value="${mname}" required>

                <label for="memail">이메일</label>
                <input type="email" id="memail" name="memail" value="${memail}" required>


            <button type="submit" class="btnPass">비밀번호 인증번호 받기</button>
                <c:if test="${not empty message}">
                    <p>${message}</p>
                </c:if>
            </div>
        </form>

        <form class="form-container" action="${pageContext.request.contextPath}/findPassAuth" method="post">
            <div>
                <label>인증번호</label>
                <input type="text" id ="auth" name="auth" required>

                <c:if test="${not empty messageAuth}">
                    <p>${messageAuth}</p>
                </c:if>
                <input type="hidden" id="num" name="num" value="${num}">
                <input type="hidden" id="mno" name="mno" value="${mno}">
                <button type="submit" class="btnAuth">인증받기</button>
            </div>
        </form>
    </div>
</section>

<c:import url="/bottom.jsp" />