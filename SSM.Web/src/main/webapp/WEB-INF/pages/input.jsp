<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>

</head>
<body>
	
	<%-- <form:form action="${pageContext.request.contextPath}/emp" method="POST" 
		modelAttribute="student" enctype="multipart/form-data">
		<br>
		<c:if test="${student.id == 0 }">
			<!-- path 属性对应 html 表单标签的 name 属性值 -->
			名字:<form:input path="name"/>
			<form:errors path="name"></form:errors>
				</c:if>
		<br>
		<c:if test="${student.id != 0 }">
			<form:hidden path="id"></form:hidden>
			 <input type="hidden" name="_method" value="PUT"/> 
			
			对于 _method 不能使用 form:hidden 标签, 因为 modelAttribute 对应的 bean 中没有 _method 这个属性
			
			
				<form:hidden path="_method" value="PUT"/>
			
		</c:if>
			
	 	头像:<input type="file" name="aaa">
	 	<br>
			<c:if test="${student.id!=0 }">
				<form:hidden path="id"/>
				<input type="hidden" name="_method" value="PUT"/>
				<img alt="" src="<%=request.getContextPath() %>/fileX?headPath=${student.headPath}" height="50px" width="50px">
			</c:if>
			<br>
		年龄:<form:input path="age"/>		<form:errors path="age"></form:errors>
			<br>		
		性别:<form:radiobuttons path="sex" items="${sex1}"/>		<form:errors path="sex"></form:errors>		
			<br>
		邮箱	<form:errors path="eilme"></form:errors>
				<br>
		时间:<form:input path="date"/>		<form:errors path="date"></form:errors>
			<br>
		零花钱:<form:input path="salary"/>		<form:errors path="salary"></form:errors>
		<br>
		班级:<form:select path="className.id" items="${clas}" itemLabel="name" itemValue="id"></form:select>
		<br>
		<input type="submit" value="add"/>
	</form:form> --%>
	
</body>
</html>