<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'head.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="css/head.css" rel="stylesheet" type="text/css" /> 
	
</head>
  
  <body>
 <ul id="nav"> 
<li><a href="#">首页</a></li> 
<li><a href="#">A</a></li> 
<li><a href="#">B</a></li> 
<li><a href="#">C</a></li> 
<li><a href="#">D</a></li> 
<li><a href="#">E</a></li> 
</ul> 
  </body>
</html>
