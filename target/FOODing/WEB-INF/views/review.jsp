<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class = "all-review-div">
    <form:form method="post" action="${pageContext.request.contextPath}/review" modelAttribute="review" id="review">
        <input type="hidden" name="sno" id="sno" value="${sno}" />
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
        <div class="form-group">
            <button type="button" class="toggle-button" onclick="toggleTagList()">태그를 선택하세요 ▼</button>
            <button type="submit" class="submit-button">리뷰 작성</button>
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
        <input type="hidden" name="tnos" id="tnos" />
    </form:form>


    <div class="sort-area">
        <select id="sort-options" class="sort-element">
            <option value="latest">최신순</option>
            <option value="oldest">작성순</option>
            <option value="highest">별점 높은 순</option>
            <option value="lowest">별점 낮은 순</option>
        </select>
    </div>


    <c:choose>
        <c:when test="${not empty reviews}">
            <div id="review-list">
                <c:forEach var="review" items="${reviews}">
                    <div class="review-container">
                        <div class="review-item review-item-left">${review.dateToString}</div>
                        <div class="review-item review-item-left" style="top: 35px;"><strong>${review.member.mnick}</strong></div>
                        <div class="review-item review-item-left" style="top: 60px;">
                            <span class="star-rating">
                                <c:forEach begin="${review.rstar + 1}" end="5" var="i">☆</c:forEach><!--
                                --><c:forEach begin="1" end="${review.rstar}" var="i">★</c:forEach>
                            </span>
                        </div>
                        <div class="review-item-content">
                            <div class="review-item review-content">${review.rcomm}</div>
                            <div class="review-actions-right">
                                <c:if test="${loggedInMember != null && review.member.mno == loggedInMember.mno}">
                                    <button type="button" onclick="openEditWindow(${review.rno})">수정</button>
                                    <form method="post" action="${pageContext.request.contextPath}/review/delete" style="display: inline;">
                                        <input type="hidden" name="rno" value="${review.rno}" />
                                        <button type="submit" onclick="return confirmDelete()">삭제</button>
                                    </form>
                                </c:if>
                                <c:if test="${loggedInMember != null && review.member.mno != loggedInMember.mno}">
                                        <button type="button" onclick="openReportWindow(${review.rno}, ${sno})">신고</button>
                                </c:if>
                                <c:if test="${loggedInMember == null}">
                                    <button type="submit" onclick="alert('로그인 후 이용 가능합니다.'); window.location.href='${pageContext.request.contextPath}/login';">신고</button>
                                </c:if>
                            </div>
                        </div>
                        <div class="review-tags">
                            <c:forEach var="tag" items="${review.tags}">
                                <span class="tag-label">${tag.ttag}</span>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p class="no-reviews-message">작성된 리뷰가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>
<script>
    /*document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('review').addEventListener('submit', function(event) {
            var starSelected = document.querySelector('input[name="rstar"]:checked');
            if (!starSelected) {
                alert("별점을 선택하세요.");
                event.preventDefault(); // 폼 제출을 막음
            }
        });
    });*/

    $(document).ready(function() {
        function loadReviewList(sortBy) {
            const sno = '${store.sno}';
            $.ajax({
                url: '${pageContext.request.contextPath}/review',
                type: 'GET',
                data: { sno: sno, sortBy: sortBy },
                success: function(response) {
                    // 받은 전체 페이지에서 필요한 부분만 추출하여 업데이트
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(response, 'text/html');
                    const reviewList = doc.querySelector('#review-list').innerHTML;
                    $('#review-list').html(reviewList);
                    initializeReviewScript();
                },
                error: function(xhr, status, error) {
                    console.log('Error loading reviews:', status, error);
                }
            });
        }

        // 새로운 select 태그의 change 이벤트 리스너
        $('#sort-options').change(function() {
            const sortBy = $(this).val();
            loadReviewList(sortBy);
        });
    });

    function confirmDelete() {
        return confirm("정말 삭제하시겠습니까?");
    }

    function confirmReport(){
        return confirm("리뷰를 신고하시겠습니까?");
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('review').addEventListener('submit', function(event) {
            var starSelected = document.querySelector('input[name="rstar"]:checked');
            if (!starSelected) {
                alert("별점을 선택하세요.");
                event.preventDefault(); // 폼 제출을 막음
            }

            // 선택된 태그 값을 히든 필드에 설정 (이미 toggleTag 함수에서 설정하고 있지만 추가로 확인)
            var selectedTags = [];
            document.querySelectorAll('.tag-button.selected').forEach(function(button) {
                selectedTags.push(button.getAttribute('data-tno'));
            });
            document.getElementById('tnos').value = selectedTags.join(',');
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        var urlParams = new URLSearchParams(window.location.search);
        var message = urlParams.get('message');
        if (message === 'report_completed') {
            alert('신고가 접수되었습니다.');
        }
    });

</script>


