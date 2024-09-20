<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>사장님 회원가입</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/checkOwner.css">
    <style>
        .required-label::after {
            content: "(필수)";
            font-size: small;
            color: gray;
            margin-left: 5px;
        }
        .message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<c:import url = "/topNoneNav.jsp" />

<section>
    <div class="check-container">
    <h2 class="head">사업자 등록번호 조회</h2>
    <form:form action="${pageContext.request.contextPath}/checkBusiness" modelAttribute="business" method="post">
        <table class="table-form">
            <tr>
                <td><label class="required-label">사업자 번호:</label></td>
                <td><form:input path="b_no" disabled="${disabled}" /></td>
            </tr>
            <tr>
                <td><label class="required-label">개업 일자:</label></td>
                <td><form:input path="start_dt" disabled="${disabled}" /></td>
            </tr>
            <tr>
                <td><label class="required-label">대표자 이름:</label></td>
                <td><form:input path="p_nm" disabled="${disabled}" /></td>
            </tr>
            <tr>
                <td colspan="2" ><input id="button" type="submit" value="조회" /></td>
            </tr>
        </table>
    </form:form>

    <c:if test="${not empty message}">
        <h2 class="head">조회 결과</h2>
        <p id="result" class="${messageType}">${message}</p>
    </c:if>
    <c:if test="${messageType == 'success'}">
        <form action="${pageContext.request.contextPath}/register/owner" method="get">
            <input type="submit" value="다음">
        </form>
    </c:if>
    <c:if test="${messageType == 'error'}">
        <form action="${pageContext.request.contextPath}/checkBusiness" method="get">
            <input type="submit" value="다시 입력하기">
        </form>
    </c:if>
    </div>
</section>


<c:import url = "/bottom.jsp" />
