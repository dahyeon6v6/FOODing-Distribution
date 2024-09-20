<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/report.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function submitReview(event) {
        event.preventDefault(); // 폼 기본 제출 막기
        var formData = $("#review").serialize();
        console.log("Submitting review with data: ", formData);
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/review/reportConfirm",
            data: formData,
            success: function(response) {
                console.log("AJAX success response: ", response);
                alert("신고가 접수되었습니다");
                window.opener.location.reload(); // 부모 창 새로고침
                window.close(); // 팝업 창 닫기
            },
            error: function(xhr, status, error) {
                console.log("AJAX error response: ", xhr, status, error);
                alert("신고 접수 중 오류가 발생했습니다: " + error);
            }
        });
    }

    $(document).ready(function() {
        $("#review").on("submit", submitReview);
    });

</script>
<div class = "report-container">
    <h2>신고 사유를 선택하세요.</h2>
    <form:form method="post" action="${pageContext.request.contextPath}/review/reportConfirm" modelAttribute="review" id="review">
        <input type="hidden" name="rno" value="${param.rno}" />
        <input type="hidden" name="sno" value="${param.sno}" />
        <div class="form-group">
            <div class="report-type">
                <c:forEach var="report" items="${reportTypes}">
                    <input type="radio" name="rptype" value="${report.rpno}">${report.rptype}</label><br>
                </c:forEach>
            </div>
        </div>
        <div class="form-group">
            <button type="submit" class="submit-button">신고 접수</button>
        </div>
    </form:form>
</div>