<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOODing 메인화면</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main_style_section.css"
          type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main_ranking_box.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/slider.js"></script>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <link href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;500&display=swap" rel="stylesheet"/>
</head>
<body>
<c:import url="/top.jsp"/>
<c:if test="${not empty error}">
<script>
    alert('${error}');
</script>
</c:if>
<section>
    <div class="show-area1">
        <div class="slider-div">
            <button class="preBtn"></button>
            <ul class="mainSliderList">
                <li class="slider mainSlider1 active">
                    <a href="${pageContext.request.contextPath}/groupList">
                        <div class="sliderImg">
                            <img src="${pageContext.request.contextPath}/resources/images/banner1.png">
                        </div>
                    </a>
                </li>
                <li class="slider mainSlider2">
                    <a href="${pageContext.request.contextPath}/storeListByLocation">
                        <div class="sliderImg">
                            <img src="${pageContext.request.contextPath}/resources/images/banner2.png">
                        </div>
                    </a>
                </li>
                <li class="slider mainSlider3">
                    <a href="#">
                        <div class="sliderImg">
                            <img src="${pageContext.request.contextPath}/resources/images/banner3.png">
                        </div>
                    </a>
                </li>
            </ul>
            <button class="nextBtn"></button>
        </div>
    </div>
    <div class="show-area2">
        <div class="category-area">
            <h1 id="category-title">카테고리별</h1>
            <table>
                <tr>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=한식">
                            <img src="${pageContext.request.contextPath}/resources/store_images/korean_food_icon.png">
                            <p>한식</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=일식">
                            <img src="${pageContext.request.contextPath}/resources/store_images/japanese_food_icon.png">
                            <p>일식</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=중식">
                            <img src="${pageContext.request.contextPath}/resources/store_images/chinese_food_icon.png">
                            <p>중식</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=양식">
                            <img src="${pageContext.request.contextPath}/resources/store_images/western_food_icon.png">
                            <p>양식</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=세계요리">
                            <img src="${pageContext.request.contextPath}/resources/store_images/global_food_icon.png">
                            <p>세계요리</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=빵/디저트">
                            <img src="${pageContext.request.contextPath}/resources/store_images/dessert_icon.png">
                            <p>빵/디저트</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=차/커피">
                            <img src="${pageContext.request.contextPath}/resources/store_images/coffee_icon.png">
                            <p>차/커피</p>
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/storeList?scate=술집">
                            <img src="${pageContext.request.contextPath}/resources/store_images/pub_icon2.png">
                            <p>술집</p>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="show-area3">
        <div class="score-ranking-area">
            <div class="ranking-box">
                <div class="header">
                    <h1>별점 순위</h1>
                </div>
                <div class="leaderboard">
                    <div class="ribbon"></div>
                    <table>
                        <c:forEach var="store1" items="${rankByScore}" varStatus="status">
                            <tr>
                                <td class="number">${status.index + 1}</td>
                                <td class="name">${store1.sname}</td>
                                <td class="points">
                                    <fmt:formatNumber value="${store1.scoreArg}" pattern="0.0"/>점
                                    <c:if test="${status.index ==0}">
                                        <img class="gold-medal"
                                             src="https://github.com/malunaridev/Challenges-iCodeThis/blob/master/4-leaderboard/assets/gold-medal.png?raw=true"
                                             alt="gold medal"/>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <div class="pick-ranking-area">
            <div class="ranking-box">
                <div class="header">
                    <h1>픽 순위</h1>
                </div>
                <div class="leaderboard">
                    <div class="ribbon"></div>
                    <table>
                        <c:forEach var="store2" items="${rankByPick}" varStatus="status">
                            <tr>
                                <td class="number">${status.index + 1}</td>
                                <td class="name">${store2.sname}</td>
                                <td class="points">
                                        ${store2.pickNum}찜
                                    <c:if test="${status.index ==0}">
                                        <img class="gold-medal"
                                             src="https://github.com/malunaridev/Challenges-iCodeThis/blob/master/4-leaderboard/assets/gold-medal.png?raw=true"
                                             alt="gold medal"/>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <div class="group-show-area">
            <h1 id="group-area-title">내가 참여한 모임</h1>
            <c:choose>
                <c:when test="${myMemberGroups==null}">
                    <p style="height: 100px; align-content: center">해당 서비스는 로그인 후 이용 가능합니다.</p>
                </c:when>
                <c:when test="${myMemberGroups=='모임방x'}">
                    <p style="height: 100px; align-content: center">참여한 모임방이 없습니다.<br>모임방에 참여해보세요!</p>
                </c:when>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-md-2 g-4 gy-4">
                        <c:forEach var="memberGroup" items="${myMemberGroups}">
                            <div class="col">
                                <div class="card h-100">
                                    <c:choose>
                                        <c:when test="${not empty memberGroup.group.gimage}">
                                            <img src="${pageContext.request.contextPath}${memberGroup.group.gimage}" class="card-img-top">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/default-group.png" class="card-img-top">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <c:if test="${memberGroup.jauth == 1}">
                                            <img src="${pageContext.request.contextPath}/resources/images/leader_icon2.png">
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/board?gno=${memberGroup.group.gno}">${memberGroup.group.gname}</a>
                                        </h5>
                                        <p class="card-text">
                                            <c:forEach var="entry" items="${allMemberList}">
                                                <c:if test="${entry.key == memberGroup.group.gno}">
                                                    ${entry.value}
                                                </c:if>
                                            </c:forEach>
                                        </p>
                                    </div>
                                    <div class="card-footer">
                                        <small class="text-muted">
                                            생성일: <tf:formatDateTime value="${memberGroup.group.gdate}" pattern="yyyy-MM-dd" /></small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>
<c:import url="/bottom.jsp"/>