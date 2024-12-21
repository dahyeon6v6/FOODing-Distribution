<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ID 찾기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findID.css">
</head>
<body>
<c:import url="/topNoneNav.jsp" />

<section>
    <div class="findID-container">
    <h2>ID 찾기</h2>
    <form class="form-container" action="${pageContext.request.contextPath}/findID" method="post">

            <div>
                <label for="mname">이름</label>
                <input type="text" id="mname" name="mname" required>

                <label for="memail">이메일</label>
                <input type="text" id="memail" name="memail" required>

               <label for="mphone">전화번호</label>
                <input type="text" id="mphone" name="mphone" required>

                <input class="button" type="submit" value="ID 찾기">
            </div>

    </form>
    </div>
</section>

<c:import url="/bottom.jsp" />