<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원등록 화면</title>
</head>
<body>

<section>
<h2>회원등록</h2>
<form:form action="register" modelAttribute="member" method="post">
    <form:label path="mid">ID</form:label>
    <form:input path="mid" /><br/>

    <form:label path="mname">성명</form:label>
    <form:input path="mname" /><br/>

    <form:label path="mpass">비밀번호</form:label>
    <form:input path="mpass" type="password" /><br/>

    <form:label path="mtype">회원유형</form:label>
    <form:radiobuttons path="mtype" items="${{'1':'일반회원', '2':'사장님'}}"/><br/>

    <form:label path="mnick">닉네임</form:label>
    <form:input path="mnick" /><br/>

    <form:label path="mbirth">생년월일</form:label>
    <form:input path="mbirth" /><br/>

    <form:label path="mphone">전화번호</form:label>
    <form:input path="mphone" /><br/>

    <form:label path="memail">이메일</form:label>
    <form:input path="memail" /><br/>

    <form:label path="maddr">주소</form:label>
    <form:input path="maddr" /><br/>

    <input type="submit" value="등록" />
</form:form>
</section>