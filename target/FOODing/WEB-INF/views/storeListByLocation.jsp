<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOODing 가게리스트 - 위치별</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main_style_header.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main_style_nav.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main_style_footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storeList.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/nav_hover.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc442228556bbf4d02c4a71483482345&libraries=services"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address; // 최종 주소 변수

                    // 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("inputAddr").value = addr;
                }
            }).open();
        }

        function validateAndSubmitForm() {
            var addr = document.getElementById("inputAddr").value;
            if (addr.trim() === "") {
                alert("주소를 입력하세요.");
            } else {
                $('#waiting-comment').text('가게 목록을 불러오는 중입니다. 잠시만 기다려주세요...');
                document.getElementById("inputLocationForm").submit();
            }
        }


        function getLocationAndSubmit() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var lat = position.coords.latitude;
                    var lon = position.coords.longitude;
                    document.getElementById('userLat').value = lat;
                    document.getElementById('userLon').value = lon;
                    $('#waiting-comment').text('가게 목록을 불러오는 중입니다. 잠시만 기다려주세요...');
                    document.getElementById('userLocationForm').submit();
                });
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        }
    </script>
</head>
<body>
<c:import url="/top.jsp" />
<section class="content">
    <h1>위치별 맛집</h1>
    <div class="now-location-area">
        <img src="${pageContext.request.contextPath}/resources/store_images/where_now.png"><p>현재 위치 :</p><p style="font-weight: bolder">${nowAddr}<p>
    </div>
    <div class="location-set">
        <form id="inputLocationForm" action="${pageContext.request.contextPath}/storeListByLocation" method="get">
            <input type="text" id="inputAddr" name="inputAddr" placeholder="주소"/>
            <button class="location-btn" type="button" onclick="sample5_execDaumPostcode()">
                <img src="${pageContext.request.contextPath}/resources/store_images/addr_setting_icon.png">
                <p>주소 찾기</p>
            </button>
            <button class="location-btn" type="button" onclick="validateAndSubmitForm()">
                <img src="${pageContext.request.contextPath}/resources/store_images/addr_search_icon.png">
                <p>해당 주소로 검색</p>
            </button>
        </form>
        <form id="userLocationForm" action="${pageContext.request.contextPath}/storeListByLocation" method="get">
            <input type="hidden" id="userLat" name="userLat" value="${defaultLat}"/>
            <input type="hidden" id="userLon" name="userLon" value="${defaultLon}"/>
            <button class="location-btn" type="button" onclick="getLocationAndSubmit()">
                <img src="${pageContext.request.contextPath}/resources/store_images/gps_icon.png">
                <p>내 위치로 검색</p>
            </button>
        </form>
    </div>
    <p id="waiting-comment"> </p>
    <table class="store-table">
        <thead>
        <tr>
            <th>순위</th>
            <th>가게명</th>
            <th>음식점 종류</th>
            <th>주소</th>
            <th>영업시간</th>
            <th>주차장</th>
            <th>거리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="store" items="${stores}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td><a href="${pageContext.request.contextPath}/storeDetail?sno=${store.sno}">${store.sname}</a></td>
                <td>
                    <c:choose>
                        <c:when test="${store.scate == '한식'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/korean_food_icon.png" alt="한식">
                        </c:when>
                        <c:when test="${store.scate == '일식'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/japanese_food_icon.png" alt="일식">
                        </c:when>
                        <c:when test="${store.scate == '중식'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/chinese_food_icon.png" alt="중식">
                        </c:when>
                        <c:when test="${store.scate == '양식'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/western_food_icon.png" alt="양식">
                        </c:when>
                        <c:when test="${store.scate == '세계요리'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/global_food_icon.png" alt="세계요리">
                        </c:when>
                        <c:when test="${store.scate == '빵/디저트'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/dessert_icon.png" alt="빵/디저트">
                        </c:when>
                        <c:when test="${store.scate == '차/커피'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/coffee_icon.png" alt="차/커피">
                        </c:when>
                        <c:when test="${store.scate == '술집'}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/pub_icon.png" alt="술집">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/store_images/other_food_icon.png" alt="기타음식">
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${store.saddr}</td>
                <td>${store.stime}</td>
                <td>
                    <c:choose>
                        <c:when test="${fn:contains(store.spark, '없음') or fn:contains(store.spark, '불가')}">
                            <img src="${pageContext.request.contextPath}/resources/store_images/non_parking2.png" alt="주차 불가">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/store_images/parking.png" alt="주차 가능">
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><fmt:formatNumber value="${store.distance}" pattern="0.00"/>km</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
<c:import url="/bottom.jsp" />
