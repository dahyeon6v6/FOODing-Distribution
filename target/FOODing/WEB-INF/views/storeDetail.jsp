<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FOODing 가게 디테일</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storeDetail.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=573fb4487497eb28636a2f91b5ca8f70&libraries=services"></script>
</head>
<body>
<!-- 상단 내비게이션 바 -->
<c:import url="/top.jsp" />

<section>
    <div class="store-div">
        <!-- 가게 정보 섹션 -->
        <c:choose>
            <c:when test="${store.sno == 1 || store.sno == 19 || store.sno == 82 || store.sno == 181}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/${store.sno}.jpg" alt="국밥">
            </c:when>
            <c:when test="${store.scate == '한식'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/korean_food.jpg" alt="한식">
            </c:when>
            <c:when test="${store.scate == '일식'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/japanese_food.jpg" alt="일식">
            </c:when>
            <c:when test="${store.scate == '중식'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/chinese_food.jpg" alt="중식">
            </c:when>
            <c:when test="${store.scate == '양식'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/western_food.jpg" alt="양식">
            </c:when>
            <c:when test="${store.scate == '세계요리'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/global_food.jpg" alt="세계요리">
            </c:when>
            <c:when test="${store.scate == '빵/디저트'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/dessert.jpg" alt="빵/디저트">
            </c:when>
            <c:when test="${store.scate == '차/커피'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/coffee.jpg" alt="차/커피">
            </c:when>
            <c:when test="${store.scate == '술집'}">
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/pub.jpg" alt="술집">
            </c:when>
            <c:otherwise>
                <img id="store-img" src="${pageContext.request.contextPath}/resources/store_images/other_food_icon.png" alt="기타음식">
            </c:otherwise>
        </c:choose>
        <div class="store-head">
            <div class="head-elements">
                <div class="s-first-area">
                <a id="star-area" class="star-area">
                    <img class="pickStar" src="${pageContext.request.contextPath}/resources/images/bookmark_icon.png" alt="StarE"/>
                </a>
                <div class ="title-area">
                    <p id="store-title">${store.sname}</p>
                    <c:choose>
                        <c:when test="${store.scoreArg != 0}">
                            <img id="score-img" src="${pageContext.request.contextPath}/resources/images/score_icon.png"/>
                            <p id="store-score"><fmt:formatNumber value="${store.scoreArg}" pattern="0.0"/>점</p>
                        </c:when>
                    </c:choose>
                </div>
                </div>
                <div class="pickNum-area">
                    <img src="${pageContext.request.contextPath}/resources/images/pickNum_icon2.png">
                    <p>${store.pickNum}찜</p>
                </div>
            </div>
            <div class="stag-area">
                <c:forEach var="stag" items="${storeTags}">
                    <c:if test="${stag.tagCount > (rCount*0.3)}">
                        <button type="button" class="main-tag-button">${stag.tag.ttag}</button>
                    </c:if>
                </c:forEach>
            </div>
            <p id="store-explain">${store.seg}</p>
        </div>

        <!-- 탭 바 -->
        <div class="tab-bar">
            <button id="store-info-tab" class="tab active">가게 정보</button>
            <button id="reviews-tab" class="tab">리뷰</button>
        </div>

        <!-- 가게 정보 및 리뷰 섹션 -->
        <div id="content-container" class="store-info-map">
            <c:import url="/WEB-INF/views/storeInfo.jsp" />
        </div>
    </div>
</section>

<script>
    function initializeMap(address) {
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 3
            };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var geocoder = new kakao.maps.services.Geocoder();

        geocoder.addressSearch(address, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">${store.sname}</div>'
                });
                infowindow.open(map, marker);
                map.setCenter(coords);
            }
        });

        function adjustMapHeight() {
            var storeInfo = document.querySelector('.store-info');
            var mapContainer = document.getElementById('map-container');
            var map = document.getElementById('map');
            var storeAddress = document.getElementById('store-address');
            if (storeInfo && mapContainer && map && storeAddress) {
                var storeInfoHeight = storeInfo.offsetHeight;
                var storeAddressHeight = storeAddress.offsetHeight;
                mapContainer.style.height = storeInfoHeight + 'px';
                map.style.height = (storeInfoHeight - storeAddressHeight - 10) + 'px';
            }
        }

        adjustMapHeight();
        window.addEventListener('resize', adjustMapHeight);
    }


    /*document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('review').addEventListener('submit', function(event) {
            var starSelected = document.querySelector('input[name="rstar"]:checked');
            if (!starSelected) {
                alert("별점을 선택하세요.");
                event.preventDefault(); // 폼 제출을 막음
            }
        });
    });*/
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
    function initializeReviewScript() {
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.star').forEach(star => {
                star.addEventListener('mouseover', function() {
                    resetStars();
                    let previousStar = this.previousElementSibling;
                    while (previousStar) {
                        if (previousStar.classList.contains('star')) {
                            previousStar.classList.add('hover');
                        }
                        previousStar = previousStar.previousElementSibling;
                    }
                });

                star.addEventListener('mouseout', function() {
                    resetStars();
                });

                star.addEventListener('click', function() {
                    resetStars();
                    this.classList.add('selected');
                    let previousStar = this.previousElementSibling;
                    while (previousStar) {
                        if (previousStar.classList.contains('star')) {
                            previousStar.classList.add('selected');
                        }
                        previousStar = previousStar.previousElementSibling;
                    }
                    document.querySelector('input[name="rstar"][value="' + this.value + '"]').checked = true;
                });
            });

            function resetStars() {
                document.querySelectorAll('.star').forEach(star => {
                    star.classList.remove('hover', 'selected');
                });
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        var urlParams = new URLSearchParams(window.location.search);
        var message = urlParams.get('message');
        if (message === 'deleted') {
            alert('삭제가 완료되었습니다.');
        }
        if (message === 'login_required') {
            alert('로그인 후 이용 가능합니다.');
        }
        /*if (message === 'rstar_required') {
            alert('별점을 선택해야 합니다.')
        }*/
    });

    function openEditWindow(rno) {
        var url = "${pageContext.request.contextPath}/review/edit?rno=" + rno;
        var name = "editReview";
        var specs = "width=850, height=850";
        window.open(url, name, specs);
    }

    function openReportWindow(rno, sno) {
        var url = "${pageContext.request.contextPath}/review/report?rno=" + rno +  "&sno=" + sno;
        var name = "reportReview";
        var specs = "width=500,height=350";
        window.open(url, name, specs);
    }

/*    function openPickWindow(sno, pfno) {
        var url = "${pageContext.request.contextPath}/pick?sno=" + sno + "&pfno=" + pfno;
        var name = "pickFolder";
        var specs = "width=500,height=350";
        window.open(url, name, specs);
    }*/
    initializeReviewScript();

    document.addEventListener("DOMContentLoaded", function() {
        initializeMap('${store.saddr}');
        initializeReviewScript();

        $('#store-info-tab').click(function() {
            console.log('가게 정보 탭 클릭');
            loadContent('${pageContext.request.contextPath}/storeInfo?sno=${store.sno}', function() {
                initializeMap('${store.saddr}');
            });
            $('.tab').removeClass('active');
            $(this).addClass('active');
        });

        $('#reviews-tab').click(function() {
            console.log('리뷰 탭 클릭');
            loadContent('${pageContext.request.contextPath}/review?sno=${store.sno}', function() {
                initializeReviewScript();
            });
            $('.tab').removeClass('active');
            $(this).addClass('active');
        });

        function loadContent(url, callback) {
            console.log('Loading content from:', url);
            $('#content-container').load(url, function(response, status, xhr) {
                if (status === 'error') {
                    console.log("Error loading content: " + xhr.status + " " + xhr.statusText);
                } else {
                    console.log('Content loaded successfully from:', url);
                    console.log('Response:', response); // storeInfo 데이터 전달 확인용
                    if (callback) {
                        callback();
                    }
                }
            });
        }

        const starArea = document.getElementById("star-area");
        const sno = "${store.sno}"; // 가게 sno 값 할당
        const pfno = 1;

        // 초기 상태 확인
        $.post("${pageContext.request.contextPath}/checkPick", { sno: sno }, function(response) {
            if (response === "picked") {
                // star.classList.add("picked");
                starArea.innerHTML = '<img class="pickStar" src="${pageContext.request.contextPath}/resources/images/bookmark_icon_full.png" alt="Star"/>'; // 꽉 찬 별 모양
            } else {
                // star.classList.remove("picked");
                starArea.innerHTML = '<img class="pickStar" src="${pageContext.request.contextPath}/resources/images/bookmark_icon.png" alt="StarE"/>'; // 빈 별 모양
            }
        });

        starArea.addEventListener("click", function() {
            // AJAX 요청으로 서버에 찜 상태 저장 요청
            $.post("${pageContext.request.contextPath}/pick", { sno: sno, pfno: pfno }, function(response) {
                if (response === "picked") {
                    // starArea.classList.add("picked");
                    starArea.innerHTML = '<img class="pickStar" src="${pageContext.request.contextPath}/resources/images/bookmark_icon_full.png" alt="Star"/>'; // 꽉 찬 별 모양
                } else if (response === "unpicked") {
                    // star.classList.remove("picked");
                    starArea.innerHTML = '<img class="pickStar" src="${pageContext.request.contextPath}/resources/images/bookmark_icon.png" alt="StarE"/>'; // 빈 별 모양
                } else {
                    alert("찜 기능을 사용하려면 로그인이 필요합니다.");
                    window.location.href = "${pageContext.request.contextPath}/login";
                }
            }).fail(function(xhr, status, error) {
                console.error("Error occurred:", error);
                console.error("Status:", status);
                console.error("Response:", xhr.responseText);
            });
        });
    });
</script>
<!-- 하단 내비게이션 바 -->
<c:import url="/bottom.jsp" />