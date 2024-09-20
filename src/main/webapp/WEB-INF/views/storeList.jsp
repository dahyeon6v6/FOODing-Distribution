<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
 <title>FOODing 가게리스트</title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storeList.css">
</head>
<body>
<c:import url="/top.jsp" />
<section class="content">
 <c:choose>
  <c:when test="${scate == null}">
   <h1>전체 맛집</h1>
  </c:when>
  <c:otherwise>
   <h1>${scate} 맛집</h1>
  </c:otherwise>
 </c:choose>
 <table class="store-table">
  <thead>
  <tr>
   <th>순위</th>
   <th>가게명</th>
   <th>음식점 종류</th>
   <th>주소</th>
   <th>영업시간</th>
   <th>주차장</th>
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
   </tr>
  </c:forEach>
  </tbody>
 </table>
</section>
<c:import url="/bottom.jsp" />

