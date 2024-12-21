<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pick.css">

<h2>${pfolder.pfname} 폴더 내용</h2>

<table class="folder-content-table">
    <c:forEach var="pick" items="${picks}">
        <tr>
            <td>
                <input type="checkbox" name="selectedStore" value="${pick.store.sno}" />
                <span>${pick.store.sname}</span>
            </td>
        </tr>
    </c:forEach>
</table>

<div>
    <button type="button" onclick="window.history.back()">목록으로 돌아가기</button>
</div>
