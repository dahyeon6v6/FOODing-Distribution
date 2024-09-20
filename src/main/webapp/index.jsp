<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix = "c"%>
<c:import url = "index_top.jsp" />
<section>
    <div class = "section-div">
        <table border = "0" align = "center">
            <tr>
                <td align = "center">
                    <a class = "head" href = "main">시작하기</a>
                </td>
            </tr>
            <tr>
                <td align = "center">
                    <span>
                        <c:if test="${sessionScope.loggedInMember != null}">
                            <a class="head" href="<%= request.getContextPath() %>/main">로그인</a>
                        </c:if>
                        <c:if test="${sessionScope.loggedInMember == null}">
                            <a class="head" href="<%= request.getContextPath() %>/login">로그인</a>
                        </c:if>
                    </span>
                    <span>/</span>
                    <span>
                        <a class = "head" href = "registerSelect">회원가입</a>
                    </span>
                </td>
            </tr>
        </table>
    </div>
</section>
<c:import url = "index_bottom.jsp" />