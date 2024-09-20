<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<%@ include file="/WEB-INF/views/includes/cacheControl.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>회원 정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editMember.css">
    <script src="${pageContext.request.contextPath}/resources/js/validation.js"></script>
</head>
<body>
<c:import url = "/top.jsp" />

<section>
    <div class="edit-container">
        <h2 class="head">회원 정보 수정</h2>
        <form:form action="${pageContext.request.contextPath}/member/edit" enctype="multipart/form-data" modelAttribute="member" method="post">
            <table border="1" align="center">
                <tr>
                    <td><label for="mname">이름</label></td>
                    <td><p>${member.mname}</p></td>
                </tr>
                <tr>
                    <td><label>비밀번호</label></td>
                    <td> <a class="edit-button" href="${pageContext.request.contextPath}/editChangePass">비밀번호 변경</a></td>
                </tr>

                    <%-------------- 프로필 파일을 업로드하기 위해 추가(다혜)-------------%>
                <tr>
                    <td><form:label path="mimage">프로필 이미지</form:label></td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty member.mimage}">
                                <img src="${pageContext.request.contextPath}${member.mimage}" alt="Profile Image" style="max-width: 150px; max-height: 150px;">
                            </c:when>
                            <c:otherwise>
                                <!-- 이미지가 없을 경우 설정된 이미지가 나오도록 함(다혜) -->
                                <img src="${pageContext.request.contextPath}/resources/images/default-profile.png" alt="Default Profile Image" style="max-width: 150px; max-height: 150px;">
                            </c:otherwise>
                        </c:choose>
                        <input type="file" name="mimageFile" />
                    </td>
                </tr>
                <tr>
                    <td><form:label path="mnick">닉네임</form:label></td>
                    <td><form:input path="mnick" /></td>
                </tr>
                <tr>
                    <td><form:label path="mbirth">생년월일</form:label></td>
                    <td><form:input path="mbirth" /></td>
                </tr>
                <tr>
                    <td><form:label path="mphone">전화번호</form:label></td>
                    <td><form:input path="mphone" /></td>
                </tr>
                <tr>
                    <td><form:label path="memail">이메일</form:label></td>
                    <td><form:input path="memail" /></td>
                </tr>
                <tr>
                    <td><form:label path="maddr">주소</form:label></td>
                    <td><form:input path="maddr" /></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="수정" /></td>
                </tr>
            </table>
            <form:hidden path="mid" />
        </form:form>
        <form action="${pageContext.request.contextPath}/delete${loggedInMember.mno}" method="post">
            <input type="hidden" name="_method" value="delete">
            <input type="submit" value="회원탈퇴">
        </form>
    </div>
</section>
<c:import url = "/bottom.jsp" />
