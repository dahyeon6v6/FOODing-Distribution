<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>모임 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/editGroup.css">
    <script type="text/javascript">
        function submitGroupForm(event) {
            event.preventDefault();

            var formData = new FormData($("#editGroupForm")[0]);

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/editGroup",
                data: formData,
                contentType: false,
                processData: false,
                success: function(response) {
                    window.opener.location.href = "${pageContext.request.contextPath}/groupManage";
                    window.close();
                },
                error: function(xhr, status, error) {
                    alert("모임 정보 수정 중 오류가 발생했습니다: " + error);
                }
            });
        }

        $(document).ready(function() {
            $("#editGroupForm").on("submit", submitGroupForm);
        });
    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 추가 -->
</head>
<body>
    <section>
        <div class="editGroup-area">
            <h1>모임 정보 수정</h1>
            <form id="editGroupForm" action="${pageContext.request.contextPath}/editGroup" enctype="multipart/form-data" method="post" >
                <table class="editGroup-table">
                    <tr>
                        <td>모임 이름</td>
                        <td><input type="text" name="gname" value="${group.gname}"/></td>
                        <input type="hidden" name="gno" value="${group.gno}"/>
                    </tr>
                    <tr>
                        <td>모임 이미지</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty group.gimage}">
                                    <img src="${pageContext.request.contextPath}${group.gimage}" alt="Group Image"
                                        style="max-width: 150px; max-height: 150px;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/resources/images/default-group.png"
                                        alt="Default Group Image" style="max-width: 150px; max-height: 150px;">
                                </c:otherwise>
                            </c:choose>
                            <input type="file" name="gimageFile"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="수정">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </section>
</body>
</html>