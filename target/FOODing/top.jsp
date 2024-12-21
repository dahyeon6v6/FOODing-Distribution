<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/resources/css/main_style_header.css" type = "text/css">
<link href = "https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/resources/css/main_style_nav.css" type = "text/css">
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/resources/css/main_style_footer.css" type = "text/css">
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src = "${pageContext.request.contextPath}/resources/js/nav_hover.js"></script>

<header>
    <div class = "header-div">
        <div class = "hello1"></div>
        <a class = "header1" href = "${pageContext.request.contextPath}/main">FOOD</a>
        <a class = "header2" href = "${pageContext.request.contextPath}/main">ing</a>
        <a class = "header2" href = "${pageContext.request.contextPath}/main">
            <img src = "${pageContext.request.contextPath}/resources/images/chefudding.png" width = "100px" height = "100px">

            <!-- 알림 기능 추가(희진) -->
            <div class="anb">
                <c:choose>
                    <c:when test="${hasAlarms}">
                        <c:forEach items="${alarms}" var="alarm">
                            <div class="subalarm">
                                <div>
                                    <c:choose>
                                        <c:when test="${alarm.atype == '모임장 초대'}">
                                            <a href="${pageContext.request.contextPath}/inviteManage">
                                                <c:out value="${alarm.message} (모임장)" escapeXml="false"/>
                                            </a>
                                        </c:when>
                                        <c:when test="${alarm.atype == '일반 회원 초대'}">
                                            <a href="${pageContext.request.contextPath}/inviteManage">
                                                <c:out value="${alarm.message} (일반회원)" escapeXml="false"/></a>
                                        </c:when>
                                        <c:when test="${alarm.atype == '초대 거절'}">
                                            <c:out value="${alarm.message}" escapeXml="false"/>
                                        </c:when>
                                        <c:when test="${alarm.atype == '모임장 수락 대기'}">
                                            <a href="${pageContext.request.contextPath}/groupManage">
                                                <c:out value="${alarm.message}" escapeXml="false"/>
                                            </a>
                                        </c:when>
                                        <%--     모임장 수락을 위해 추가한 부분(다혜)--%>
                                        <c:when test="${alarm.atype == '모임장 수락'}">
                                            <a href="${pageContext.request.contextPath}/groupList">
                                                <c:out value="${alarm.message}" escapeXml="false"/>
                                            </a>
                                        </c:when>
                                        <c:when test="${alarm.atype == '모임장 수락 거절1' || alarm.atype == '모임장 수락 거절2'}">
                                            <a href="#">
                                                <c:out value="${alarm.message}" escapeXml="false"/>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a style="color: dimgray">메세지를 불러오지 못 하였습니다</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- 확인 및 삭제 버튼 추가 -->
                                <div class="alarmButton-area">
                                    <script>
                                        function setReturnUrl(form) {
                                            var currentPage = window.location.href; // 현재 페이지 URL을 가져옵니다.
                                            form.returnUrl.value = currentPage; // 히든 필드에 현재 페이지 URL을 설정합니다.
                                            form.submit(); // 폼을 제출합니다.
                                        }
                                    </script>

                                    <!-- 알림 확인 버튼 -->
                                    <c:choose>
                                        <c:when test="${alarm.isChecked == 0}">
                                            <form action="${pageContext.request.contextPath}/alarmChecked" method="post" style="display:inline;" onsubmit="setReturnUrl(this);">
                                                <input type="hidden" name="alarmId" value="${alarm.ano}"/>
                                                <input type="hidden" name="returnUrl" value=""/>
                                                <button type="submit" class="alarmButton">
                                                    <img src="${pageContext.request.contextPath}/resources/images/check-icon.png"/>
                                                </button>
                                            </form>
                                        </c:when>
                                    </c:choose>

                                    <!-- 알림 삭제 버튼 -->
                                    <form action="${pageContext.request.contextPath}/alarmDelete" method="post" style="display:inline;" onsubmit="setReturnUrl(this);">
                                        <input type="hidden" name="alarmId" value="${alarm.ano}"/>
                                        <input type="hidden" name="returnUrl" value=""/>
                                        <button type="submit" class="alarmButton">
                                            <img src="${pageContext.request.contextPath}/resources/images/delete-icon.png"/>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="subalarm">
                            <div>알림이 없습니다.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </a>
        <div class = "hello2">
            <table border = "0" align = "center">
                <tr>
                    <td align = "center">
                        <c:if test="${sessionScope.loggedInMember != null}">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInMember.mimage}">
                                    <!-- 설정된 이미지가 있을 경우 -->
                                    <img class="login-image" src="${pageContext.request.contextPath}${sessionScope.loggedInMember.mimage}" alt="Profile Image" style="max-width: 150px; max-height: 150px;">
                                </c:when>
                                <c:otherwise>
                                    <!-- 기본 이미지(빈 이미지)를 표시 -->
                                    <img class="login-image" src="${pageContext.request.contextPath}/resources/images/default-profile.png" alt="Default Profile Image" style="max-width: 150px; max-height: 150px;">
                                </c:otherwise>
                            </c:choose>
                            ${sessionScope.loggedInMember.mname}님, 안녕하세요!
                        </c:if>
                        <c:if test="${sessionScope.loggedInMember == null}">
                            어서오세요!
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td align = "center">

                        <!-- 알림 기능 추가(희진) -->
                        <c:if test="${sessionScope.loggedInMember != null}">
                            <span>
                                <a class = "bell" href = "#">
                                    <c:choose>
                                        <c:when test="${alarmChecked == false}">
                                            <img src = "${pageContext.request.contextPath}/resources/images/non-check-bell.png" width = "30px" height = "30px">
                                        </c:when>
                                        <c:otherwise>
                                            <img src = "${pageContext.request.contextPath}/resources/images/bell.png" width = "30px" height = "30px">
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </span>
                            <span>|</span>
                        </c:if>

                        <span>
                             <c:if test="${sessionScope.loggedInMember != null}">
                                 <a class="helloBox" href="<%= request.getContextPath() %>/myPage">마이페이지</a>
                             </c:if>
                            <c:if test="${sessionScope.loggedInMember == null}">
                                <a class="helloBox" href = "<%= request.getContextPath() %>/registerSelect">회원가입</a>
                            </c:if>
                        </span>
                        <span>|</span>
                        <span>
                           <c:if test="${sessionScope.loggedInMember != null}">
                               <a class="helloBox" href="<%= request.getContextPath() %>/logout">로그아웃</a>
                           </c:if>
                            <c:if test="${sessionScope.loggedInMember == null}">
                                <a class="helloBox" href="<%= request.getContextPath() %>/login">로그인</a>
                            </c:if>
                        </span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</header>
<nav>
    <div class = "nav-div">
        <a class = "nav" href="${pageContext.request.contextPath}/storeListByScate">카테고리별 맛집</a>
        <a class = "nav" href="${pageContext.request.contextPath}/storeList">맛집 찾기</a>
        <a class = "nav" href = "${pageContext.request.contextPath}/groupList">모임</a>
        <a class = "nav" href = "${pageContext.request.contextPath}/pickList">찜</a>
        <form action="${pageContext.request.contextPath}/searchResultView" method="GET" class="d-flex">
            <div class="search-form">
                <input class="form-control me-2" name="searchKeyword" type="search" placeholder="가게를 검색하세욧" aria-label="Search">
                <button type="submit" class="btn btn-link">
                    <img src="${pageContext.request.contextPath}/resources/images/search.png" alt="Search">
                </button>
            </div>
        </form>
        <ul class = "snb">
            <div class = "submenu">
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=한식">한식</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=일식">일식</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=중식">중식</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=양식">양식</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=세계요리">세계요리</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=빵/디저트">빵/디저트</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=차/커피">차/커피</a></li>
                <li><a href = "${pageContext.request.contextPath}/storeList?scate=술집">술집</a></li>
            </div>
            <div class="submenu">
                <li><a href="${pageContext.request.contextPath}/storeListByLocation">위치별</a></li>
                <li><a href="${pageContext.request.contextPath}/storeListByRank">순위별</a></li>
                <li><a href="${pageContext.request.contextPath}/storeListByTag">태그별</a></li>
            </div>
            <div class = "submenu">
                <li><a href = "${pageContext.request.contextPath}/groupList">내 모임</a></li>
                <li><a href = "${pageContext.request.contextPath}/groupManage">모임 관리</a></li>
                <li><a href = "${pageContext.request.contextPath}/inviteManage">내 초대 관리</a></li>
            </div>
            <div class = "submenu">
                <li><a href = "${pageContext.request.contextPath}/pickList">찜 폴더 관리</a></li>
                <li><a href = "#"></a></li>
                <li><a href = "#"></a></li>
            </div>
        </ul>
    </div>
</nav>
