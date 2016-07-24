<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'foot.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
 <style type="text/css">
.footer {
    height: 100px;
    background-color:#00A2CA;
    background-repeat: repeat;
    font-family: "Microsoft YaHei";
    font-size: 14px;
    color: #CCC;
    text-align: center;
    padding-top: 1px;
}
.footer a:hover {
    color:#62C462
}
</style>
  </head>
  
  <body>
<div class="footer" >
    <p>经济地图小组      16.6.17</p> 
    <p><a href="http://echarts.baidu.com" target="_blank">Data Visualization by Emap</a></p>
</div>	
  </body>
</html>
