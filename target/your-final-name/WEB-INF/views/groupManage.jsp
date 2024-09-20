<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOODing 모임 관리</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/groupManage.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/alertHandler.js"></script>
</head>
<body>
<c:import url="/top.jsp"/>
<section>
    <div class = "groupManage-box">
        <div class="groupManage-list-area">
            <h1>관리할 모임 리스트</h1>
            <table class="groupManage-table">
                <thead>
                <%------그룹 이미지를 띄워주는 것으로 수정(다혜)------%>
                <tr>
                    <th>번호</th>
                    <th>그룹 이미지</th>
                    <th colspan="2" align="center">모임명</th>
                    <th>모임 생성 날짜</th>
                </tr>
                </thead>
                <%--------------희진씨의 원래 모임이름 수정 코드---------------%>
                <tbody>
                <c:forEach var="group" items="${leaderGroups}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty group.gimage}">
                                    <img src="${pageContext.request.contextPath}${group.gimage}" alt="Group Image" style="max-width: 100px; max-height: 100px;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/resources/images/default-group.png" alt="Default Group Image" style="max-width: 100px; max-height: 100px;">
                                </c:otherwise>
                            </c:choose>
                        </td>
                            <td>${group.gname}</td>
                            <%--------------희진씨의 원래 모임이름 수정 코드---------------%>
                            <%--<td>
                                <form action="${pageContext.request.contextPath}/updateGroupName" method="post">
                                    <input type="hidden" name="gno" value="${group.gno}">
                                    <input type="text" name="newGname" value="${group.gname}" required>
                                    <input type="submit" value="수정">
                                </form>
                            </td>
                            <td>${group.gdate}</td>--%>
                            <td>
                                <form id="editForm${group.gno}">
                                    <input type="hidden" name="gno" value="${group.gno}">
                                    <input type="button" value="수정" onclick="openEditWindow(${group.gno});">
                                </form>
                            </td>
                        <td><tf:formatDateTime value="${group.gdate}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <c:set var="mnickString" value=""/>
                        <c:forEach var="memberGroup" items="${allMemberGroups}">
                                <c:if test="${memberGroup.group.gno == group.gno}">
                                    <c:choose>
                                        <c:when test="${empty mnickString}">
                                            <c:set var="mnickString" value="${memberGroup.member.mnick}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="mnickString" value="${mnickString} / ${memberGroup.member.mnick}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                        </c:forEach>
                        <tr>
                            <td colspan="5" align="center">
                                    ${mnickString}
                            </td>
                        </tr>
                    <c:forEach var="invite" items="${invites}">
                        <c:if test="${invite.memberGroup.group.gno == group.gno}">
                            <tr>
                                <td>초대 대상</td>
                                <td>${invite.member.mnick}</td>
                                <td colspan="3">
                                        <form action="${pageContext.request.contextPath}/leaderAcceptInvite" method="post"
                                              style="display:inline;">
                                            <input type="hidden" name="inviteId" value="${invite.ino}"/>
                                            <button type="submit" class="btn btn-success">모임장 수락</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/leaderRejectInvite" method="post"
                                              style="display:inline;">
                                            <input type="hidden" name="inviteId" value="${invite.ino}"/>
                                            <button type="submit" class="btn btn-warning">모임장 거절</button>
                                        </form>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${not empty error}">
                <p id="temporaryText" class="error-message">
                    <c:out value="${error}" />
                </p>
            </c:if>
        </div>
        <div class="groupManage-delete-area">
            <h1>모임 회원 삭제</h1>
            <form action="${pageContext.request.contextPath}/deleteMemberToGroup" method="post">
                <table class="groupManage-delete-table">
                    <tr>
                        <td>모임명</td>
                        <td>
                            <select name="gno" id="deleteGroup">
                                <c:forEach var="group" items="${leaderGroups}">
                                    <option value="${group.gno}">${group.gname}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>회원ID</td>
                        <td><input type="text" id="deleteMid" name="mid" required/></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="삭제"/>
                        </td>
                    </tr>
                </table>
            </form>
            <c:if test="${not empty errorMessage}">
                <p id="temporaryText" class="error-message">
                    <c:out value="${errorMessage}" />
                </p>
            </c:if>
        </div>
        <div class="groupManage-delete-group-area">
            <h1>모임 삭제</h1>
            <form action="${pageContext.request.contextPath}/deleteGroup" method="post">
                <table class="groupManage-delete-group-table">
                    <tr>
                        <td>삭제할 모임</td>
                        <td>
                            <select name="gno" id="delete-group">
                                <c:forEach var="group" items="${leaderGroups}">
                                    <option value="${group.gno}">${group.gname}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="삭제"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</section>
<%--모임방 프로필 설정을 위해 추가한 부분(다혜)--%>
<script>
    function openEditWindow(gno) {
        var url = "${pageContext.request.contextPath}/editGroup?gno=" + gno;
        var name = "editGroup";
        var specs = "width=750,height=400";
        window.open(url, name, specs);
    }

</script>
<c:import url="/bottom.jsp"/>
