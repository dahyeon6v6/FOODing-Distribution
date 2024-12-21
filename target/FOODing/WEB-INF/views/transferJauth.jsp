<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOODing 모임장 권한 위임</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/transferJauth.css">
    <script type="text/javascript">
        function setMemberNick(nick) {
            document.getElementById('transferJauth').value = nick;
        }

        function submitGroupForm(event) {
            event.preventDefault(); // 폼 기본 제출 막기
            var formData = $("#transferJauthForm").serialize();
            console.log("제출된 데이터: ", formData);
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/transferJauth",
                data: formData,
                success: function(response) {
                    console.log("AJAX success response: ", response);
                    window.opener.location.reload(); // 부모 창 새로고침
                    window.close(); // 팝업 창 닫기
                },
                error: function(xhr, status, error) {
                    console.log("AJAX error response: ", xhr, status, error);
                    alert("모임장 권한 위임 중 오류가 발생했습니다: " + error);
                }
            });
        }

        $(document).ready(function() {
            $("#transferJauthForm").on("submit", submitGroupForm);
        });
    </script>
</head>
<body>
    <section>
        <div class="transfer-area">
            <h1>모임장 권한 위임 - ${memberGroup.group.gname}</h1>
            <form action="${pageContext.request.contextPath}/transferJauth" method="post" id="transferJauthForm">
            <table class="transfer-table">
                <tr>
                    <td colspan="2" align="">현재 모임장 : ${memberGroup.member.mnick}</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <c:forEach var="rg" items="${regularMembers}">
                            <p class="clickable-nickname" onclick="setMemberNick('${rg.memberNick}')">${rg.memberNick}</p>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        모임장 권한 위임 회원 : <input type="text" id="transferJauth" name="memberNick" required/>
                    </td>
                </tr>
            </table>
                <input type="hidden" name="gno" value="${memberGroup.group.gno}"/>
                <input type="submit" value="위임"/>
            </form>
        </div>
    </section>
</body>
</html>
