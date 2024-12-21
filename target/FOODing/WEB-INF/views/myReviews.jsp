<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내가 쓴 리뷰 목록</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myReviews.css">
</head>
<body>
<c:import url="/top.jsp" />

<section >
    <div class="reviews-container">
        <h2>내가 쓴 리뷰 목록</h2>

        <div class="reviews-Box">
            <c:if test="${empty reviews}">
                <p>작성한 리뷰가 없습니다.</p>
            </c:if>

            <c:forEach var="review" items="${reviews}">
                <div class="review-container">
                    <div class="review-item review-item-left"><strong>${review.store.sname}</strong></div>
                    <div class="review-item review-item-right"><strong>작성 날짜 : </strong> ${review.rdate}</div>
                    <div class="review-item review-item-left" style="top: 30px;"><strong>별점 : </strong>
                        <span class="star-rating">
                            <c:forEach begin="1" end="${review.rstar}" var="i">★</c:forEach>
                            <c:forEach begin="${review.rstar + 1}" end="5" var="i">☆</c:forEach>
                        </span>
                    </div>
                    <div class="review-item-content">
                        <div class="review-item"><strong>리뷰 내용 : </strong></div>
                        <div class="review-item review-content">${review.rcomm}</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<c:import url="/bottom.jsp" />