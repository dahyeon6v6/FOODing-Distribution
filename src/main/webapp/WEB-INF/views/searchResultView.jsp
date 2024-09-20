<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>검색결과</title>
    <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/searchResultView.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<c:import url="/top.jsp" />
<section class="content">
    <div class="keyword-area">
        <h1><p id="nowKeyword">'${searchKeyword}'</p>
            <p>(으)로 검색한 결과입니다.</p></h1>
    </div>
    <div class="sort-area">
        <a class="sort-element ${sortStandard == 'pick' ? 'active' : ''}" id="sort_by_pick" href="#">찜 많은순</a>
        <p class="sort-element">|</p>
        <a class="sort-element ${sortStandard == 'score' ? 'active' : ''}" id="sort_by_score" href="#">별점 높은순</a>
    </div>
    <div class="container bootstrap snippets bootdey">
        <div id="store-list" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <c:forEach var="store" items="${stores}" varStatus="status">
                <div class="well search-result">
                    <div class="row">
                        <a href="${pageContext.request.contextPath}/storeDetail?sno=${store.sno}">
                            <div class="img-container col-xs-6 col-sm-3 col-md-3">
                                <c:choose>
                                    <c:when test="${store.sno == 1 || store.sno == 19 || store.sno == 82 || store.sno == 181}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/${store.sno}.jpg" alt="국밥">
                                    </c:when>
                                    <c:when test="${store.scate == '한식'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/korean_food.jpg" alt="한식">
                                    </c:when>
                                    <c:when test="${store.scate == '일식'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/japanese_food.jpg" alt="일식">
                                    </c:when>
                                    <c:when test="${store.scate == '중식'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/chinese_food.jpg" alt="중식">
                                    </c:when>
                                    <c:when test="${store.scate == '양식'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/western_food.jpg" alt="양식">
                                    </c:when>
                                    <c:when test="${store.scate == '세계요리'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/global_food.jpg" alt="세계요리">
                                    </c:when>
                                    <c:when test="${store.scate == '빵/디저트'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/dessert.jpg" alt="빵/디저트">
                                    </c:when>
                                    <c:when test="${store.scate == '차/커피'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/coffee.jpg" alt="차/커피">
                                    </c:when>
                                    <c:when test="${store.scate == '술집'}">
                                        <img src="${pageContext.request.contextPath}/resources/store_images/pub.jpg" alt="술집">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/resources/store_images/other_food_icon.png" alt="기타음식">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-xs-6 col-sm-9 col-md-9 title">
                                <h3>${store.sname}</h3>
                                <p>${store.seg}</p>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<c:import url="/bottom.jsp" />
<script>
    var sortStandard = '${sortStandard}';
    var searchKeyword = '${searchKeyword}';

    function loadStoreList(sortBy) {

        $('#waiting-comment').text('가게 목록을 불러오는 중입니다. 잠시만 기다려주세요...');
        $.ajax({
            url: '${pageContext.request.contextPath}/searchResultView',
            type: 'GET',
            data: {
                sortBy: sortBy,
                searchKeyword: searchKeyword
            },
            success: function (response) {
                $('#store-list').html($(response).find('#store-list').html());
                $('#sort-header').html($(response).find('#sort-header').html());

                // 정렬 기준에 따라 활성화된 버튼 상태 유지
                if (sortBy === 'score') {
                    $('#sort_by_score').addClass('active');
                    $('#sort_by_pick').removeClass('active');
                } else {
                    $('#sort_by_pick').addClass('active');
                    $('#sort_by_score').removeClass('active');
                }
                $('#waiting-comment').text('');
            },
            error: function (xhr, status, error) {
                console.log('Error loading stores:', status, error);
            }
        });
    }

    $('#sort_by_pick').click(function (event) {
        event.preventDefault();
        loadStoreList('pick');
    });

    $('#sort_by_score').click(function (event) {
        event.preventDefault();
        loadStoreList('score');
    });
</script>
</body>
</html>