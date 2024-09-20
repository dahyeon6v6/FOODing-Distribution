<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="store-info-map">
    <div class="store-info">
        <h2 class="menu-title">메뉴</h2>
        <table class="menu-table">
            <thead>
            <tr>
                <td>메뉴이름</td>
                <td>가격</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="menu" items="${menus}">
                <tr>
                    <td>${menu.mnname}</td>
                    <td>${menu.mnprice}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <h2>영업시간</h2>
        <p>${store.stime}</p>
        <h2>주차</h2>
        <p>${store.spark}</p>
        <h2>전화번호</h2>
        <p>${store.stel}</p>
    </div>
    <div id="map-container">
        <p id="store-address">${store.saddr}</p>
        <div id="map" style="width:100%;height:400px;"></div>
    </div>
</div>
