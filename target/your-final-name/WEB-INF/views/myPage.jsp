<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">
</head>
<body>
<c:import url="/top.jsp" />

<section class="section-mypage">
    <div><h2>마이페이지</h2></div>

    <div class="mypage-content">
        <span class="profile-info">
            <a href="${pageContext.request.contextPath}/member/view">개인 정보 조회</a>
        </span>
        <span class="myreviews-list">
            <a href="${pageContext.request.contextPath}/myReviews">내가 쓴 리뷰 보기</a>
        </span>
    </div>
</section>

<c:import url="/bottom.jsp" />