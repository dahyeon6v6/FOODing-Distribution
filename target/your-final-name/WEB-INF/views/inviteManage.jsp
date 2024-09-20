<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>FOODing 내 초대 관리</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/inviteManage.css">
    <link href = "https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<c:import url="/top.jsp"/>
<section>
    <div class="inviteManage-box">
        <div class="inviteManage-list-area">
            <h1>내 초대 관리</h1>
            <table class="inviteManage-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>초대한 회원</th>
                        <th>초대하는 모임명</th>
                        <th>초대 유형</th>
                        <th>수락 / 거절</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="invite" items="${invites}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${invite.memberGroup.member.mnick}</td>
                            <td>${invite.memberGroup.group.gname}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${invite.memberGroup.jauth == 1}">모임장 초대</c:when>
                                    <c:otherwise>일반 회원 초대</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${invite.itype == 0 || invite.itype == 6}">
                                    <form action="${pageContext.request.contextPath}/acceptInvite" method="post" style="display:inline;">
                                        <input type="hidden" name="inviteId" value="${invite.ino}" />
                                        <button type="submit" class="btn btn-success">수락</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/rejectInvite" method="post" style="display:inline;">
                                        <input type="hidden" name="inviteId" value="${invite.ino}" />
                                        <button type="submit" class="btn btn-warning">거절</button>
                                    </form>
                                </c:if>
                                <c:if test="${invite.itype == 1}">
                                    모임장 수락 대기
                                </c:if>
                                <c:if test="${invite.itype == 2 || invite.itype == 8}">
                                    초대 거절
                                </c:if>
                                <c:if test="${invite.itype == 3}">
                                    모임장 수락 완료
                                </c:if>
                                <c:if test="${invite.itype == 4}">
                                    모임장 수락 거절
                                </c:if>
                                <c:if test="${invite.itype == 7}">
                                    초대 수락
                                </c:if>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/deleteInvite" method="post" style="display:inline;">
                                    <input type="hidden" name="inviteId" value="${invite.ino}" />
                                    <button type="submit" class="btn btn-danger">X</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>
<c:import url="/bottom.jsp"/>
