<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/editReview.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var selectedTags = [];

    function toggleTagList() {
        var tagList = document.getElementById('tagList');
        if (tagList.style.display === 'none' || tagList.style.display === '') {
            tagList.style.display = 'block';
        } else {
            tagList.style.display = 'none';
        }
    }

    var selectedTags = [];

    function toggleTag(tno, button) {
        var index = selectedTags.indexOf(tno);
        if (index === -1) {
            // 태그가 선택되지 않았으면 추가
            selectedTags.push(tno);
            button.classList.add('selected');
        } else {
            // 태그가 이미 선택되었으면 제거
            selectedTags.splice(index, 1);
            button.classList.remove('selected');
        }
        // 선택된 태그 ID를 hidden input에 설정
        document.getElementById('tnos').value = selectedTags.join(',');
    }

    function submitReview(event) {
        event.preventDefault(); // 폼 기본 제출 막기
        var formData = $("#review").serialize();
        console.log("Submitting review with data: ", formData);
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/review/update",
            data: formData,
            success: function(response) {
                console.log("AJAX success response: ", response);
                alert("수정이 완료되었습니다");
                window.opener.location.reload(); // 부모 창 새로고침
                window.close(); // 팝업 창 닫기
            },
            error: function(xhr, status, error) {
                console.log("AJAX error response: ", xhr, status, error);
                alert("리뷰 수정 중 오류가 발생했습니다: " + error);
            }
        });
    }

    $(document).ready(function() {
        $("#review").on("submit", submitReview);
    });

</script>
<div class = "edit-container">
    <h2>리뷰 수정</h2>
    <form:form method="post" action="${pageContext.request.contextPath}/review/update" modelAttribute="review" id="review">
        <input type="hidden" name="rno" value="${review.rno}" />
        <div class="form-group">
            <div class="star-rating">
                <input type="radio" name="rstar" class="star" id="star5" value="5"><label for="star5"></label>
                <input type="radio" name="rstar" class="star" id="star4" value="4"><label for="star4"></label>
                <input type="radio" name="rstar" class="star" id="star3" value="3"><label for="star3"></label>
                <input type="radio" name="rstar" class="star" id="star2" value="2"><label for="star2"></label>
                <input type="radio" name="rstar" class="star" id="star1" value="1"><label for="star1"></label>
            </div>
        </div>
        <div class="form-group">
            <form:textarea path="rcomm" id="rcomm" class="custom-textarea" placeholder="리뷰 내용을 입력하세요."></form:textarea>
        </div>
        <div class="form group">
            <button type="button" class="toggle-button" onclick="toggleTagList()">태그를 선택하세요 ▼</button>
            <div class="tag-buttons" id="tagList">
                <div class="tag-group">
                    <c:forEach var="tag" items="${tags}">
                        <c:if test="${tag.tno >=101 && tag.tno <=107}">
                            <button type="button" class="tag-button" onclick="toggleTag(${tag.tno}, this)">
                                <img src="${pageContext.request.contextPath}/resources/tag_images/${tag.tno}.svg" class="tag-icon">${tag.ttag}</button>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="tag-group">
                    <c:forEach var="tag" items="${tags}">
                        <c:if test="${tag.tno >=201 && tag.tno <=207}">
                            <button type="button" class="tag-button" onclick="toggleTag(${tag.tno}, this)">
                                <img src="${pageContext.request.contextPath}/resources/tag_images/${tag.tno}.svg" class="tag-icon">${tag.ttag}</button>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="tag-group">
                    <c:forEach var="tag" items="${tags}">
                        <c:if test="${tag.tno >=301 && tag.tno <=307}">
                            <button type="button" class="tag-button" onclick="toggleTag(${tag.tno}, this)">
                                <img src="${pageContext.request.contextPath}/resources/tag_images/${tag.tno}.svg" class="tag-icon">${tag.ttag}</button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="form-group">
            <button type="submit" class="submit-button">리뷰 수정</button>
        </div>
        <input type="hidden" name="tnos" id="tnos" />
    </form:form>
</div>