<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>测试</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="buju_files/bootstrap.css" rel="stylesheet">
    <link href="buju_files/bootstrap-responsive.css" rel="stylesheet">
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
	<!-- 
	    	   $.post("bar.do",function(data,status){
 		      if(status="success"){
 		    	  $("#con2").html($(data).find("body").html());
 		    	  }
 		    });
	 -->
	<script type="text/javascript">
       $(document).ready(function(){
           $("#tab1").click(function(){
    	   $(this).parent().siblings().attr("class","");
    	   $(this).parent().attr("class","active");
    	   $($(this).attr("name")).siblings().attr("class","tab-pane");
    	   $($(this).attr("name")).attr("class","tab-pane active");
           });
           
           
    	   $("#tab2").click(function(){
    	   $(this).parent().siblings().attr("class","");
    	   $(this).parent().attr("class","active");
    	   $($(this).attr("name")).siblings().attr("class","tab-pane");
    	   $($(this).attr("name")).attr("class","tab-pane active");
    	   nrkBarInit();
           });
    	   
    	   
    	   $("#tab3").click(function(){
    	   $(this).parent().siblings().attr("class","");
    	   $(this).parent().attr("class","active");
    	   $($(this).attr("name")).siblings().attr("class","tab-pane");
    	   $($(this).attr("name")).attr("class","tab-pane active");
    	   rkthemeInit();
           }); 
    });
       tBarInit();
       
	 
</script>
<body>
<iframe src="chns.html"  width="100%" height="160px" frameborder="0" scrolling="no"></iframe>
<div><jsp:include page="emapbar.jsp"></jsp:include></div>
    <div class="container">
        <!-- CONTAINER -->
        <div class="row">
            <div id="graphic" class="span12">
                <ul class="nav nav-tabs nav-justified">
                  <li class="active"><a id="tab1" name="#main1" >第一部分</a></li>
                  <li class=""><a id="tab2" name="#main2" >第二部分</a></li>
                  <li class=""><a id="tab3" name="#main3" >第三部分</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="main1">

					    <div id="con1"><jsp:include page="barTest.jsp"></jsp:include></div>
                    </div>
                    <div class="tab-pane" id="main2">

                        <div id="con2"><jsp:include page="rk.jsp"></jsp:include></div>
                    </div>
                    <div class="tab-pane" id="main3">
						<div id="con3"><jsp:include page="rktheme.jsp"></jsp:include></div>
                    </div>
                </div>
            </div><!--/span-->
        </div><!--/row-->
    </div>
    <jsp:include page="foot.jsp"></jsp:include>
</body></html>
