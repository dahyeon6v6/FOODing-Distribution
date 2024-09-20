<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>FOODing 메인화면</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/viewMember.css">
</head>
<body>
<c:import url = "/top.jsp" />

<section>
    <div class="view-container">
    <h2 class="head">회원 정보 조회</h2>
        <form class="form-container" action="${pageContext.request.contextPath}/member/view" method="post">
            <table>
                <tr>
                    <td><label for="mid">아이디</label></td>
                    <td><p>${member.mid}</p></td>
                </tr>
                <tr>
                    <td><label for="mname">이름</label></td>
                    <td><p>${member.mname}</p></td>
                </tr>
                <tr>
                    <td><label for="mtype">타입</label></td>
                    <td>
                        <p>
                            <c:choose>
                                <c:when test="${member.mtype == 0}">손님</c:when>
                                <c:when test="${member.mtype == 1}">사장님</c:when>
                            </c:choose>
                        </p>
                    </td>
                </tr>
                <%-------------- 프로필 파일을 표시하기 위해 추가(다혜)-------------%>
                <tr>
                    <td><label for="mimage">프로필 이미지</label></td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty member.mimage}">
                                <img src="${pageContext.request.contextPath}${member.mimage}" alt="회원 프로필 이미지" style="max-width: 150px; max-height: 150px;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/images/default-profile.png" alt="기본 프로필 이미지" style="max-width: 150px; max-height: 150px;">
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td><label for="mnick">닉네임</label></td>
                    <td><input type="text" id="mnick" value="${member.mnick}" readonly></td>
                </tr>
                <tr>
                    <td><label for="mbirth">생년월일</label></td>
                    <td><input type="text" id="mbirth" value="${member.mbirth}" readonly></td>
                </tr>
                <tr>
                    <td><label for="mphone">연락처</label></td>
                    <td><input type="text" id="mphone" value="${member.mphone}" readonly></td>
                </tr>
                <tr>
                    <td><label for="memail">이메일</label></td>
                    <td><input type="text" id="memail" value="${member.memail}" readonly></td>
                </tr>
                <tr>
                    <td><label for="maddr">주소</label></td>
                    <td><input type="text" id="maddr" value="${member.maddr}" readonly></td>
                </tr>
                <tr>
                    <td><label>가입일자</label></td>
                    <td><p>${member.mdate}</p></td>
                </tr>
                <tr>
                    <td colspan="2" class="button">
                        <a href="${pageContext.request.contextPath}/member/edit">
                            <button type="button">회원 정보 수정</button>
                        </a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</section>
<c:import url = "/bottom.jsp" />