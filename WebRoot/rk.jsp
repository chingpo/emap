<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
       <meta charset="utf-8">
    <title>ECharts</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
 <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

  </head> 
  <body>  


	<div id="rkBar" style="height:400px"></div>
	<!-- ECharts单文件引入 -->
	<script type="text/javascript">
		function nrkBarInit() {
        // 路径配置
        require.config({
            paths: {
            	echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
 
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/bar',
                'echarts/chart/line',
                'echarts/chart/pie',
                 'echarts/chart/funnel' // 使用柱状图就加载bar模块，按需加载
            ],
            DrawEChart
            );
            
        function DrawEChart(ec) {
            // 基于准备好的dom，初始化echarts图表
           var myChart = ec.init(document.getElementById('rkBar')); 
var option = {

					calculable : true,
					grid : {
						'y' : 80,
						'y2' : 100
					},
					calculable : true,
					timeline : {
						data : [ '1997', '2000', '2004', '2006' ],
						autoPlay : false,
					},
					options : [
							{
								title : {
									'text' : '1997全国调查经济数据',
									'subtext' : '数据来自CHNS'
								},
								tooltip : {
									show : true
								},
								legend : {
									data : [ '少年', '中年', '老年' ]
								},
								toolbox : {
									'show' : true,
									orient : 'vertical',
									x : 'right',
									y : 'center',
									'feature' : {
										'mark' : {
											'show' : true
										},
										'dataView' : {
											'show' : true,
											'readOnly' : false
										},
										'magicType' : {
											'show' : true,
											'type' : [ 'line', 'bar', 'stack',
													'tiled' ]
										},
										'restore' : {
											'show' : true
										},
										'saveAsImage' : {
											'show' : true
										}
									}
								},
								xAxis : [ {
									type : 'category',
								    data : ['黑龙江','山东','辽宁','贵州','河南','广西','湖北','湖南','江苏']
								} ],
								yAxis : [ {
									type : 'value'
								} ],
								series : [ {
									"name" : "少年",
									"type" : "bar",
									"data" : <%=request.getAttribute("snc97people")%>,
									markPoint : {
										data : [ {
											type : 'max',
											name : '最大值'
										}, {
											type : 'min',
											name : '最小值'
										} ]
									},
									markLine : {
										data : [ {
											type : 'average',
											name : '平均值'
										} ]
									}
								}, {
									"name" : "中年",
									"type" : "bar",
									"data" : <%=request.getAttribute("znc97people")%>,
									markPoint : {
										data : [ {
											type : 'max',
											name : '最大值'
										}, {
											type : 'min',
											name : '最小值'
										} ]
									},
									markLine : {
										data : [ {
											type : 'average',
											name : '平均值'
										} ]
									}
								}, {
									"name" : "老年",
									"type" : "bar",
									"data" : <%=request.getAttribute("lnc97people")%>,
									markPoint : {
										data : [ {
											type : 'max',
											name : '最大值'
										}, {
											type : 'min',
											name : '最小值'
										} ]
									},
									markLine : {
										data : [ {
											type : 'average',
											name : '平均值'
										} ]
									}
								} ]
							},{
								title : {
									'text' : '2000全国调查经济数据'
								},
								series : [ {
									"data" : <%=request.getAttribute("snc00people")%>,

								}, {
									"data" : <%=request.getAttribute("znc00people")%>,

								}, {
									"data" : <%=request.getAttribute("lnc00people")%>,

								} ]
							}, {
								title : {
									'text' : '2004全国调查经济数据'
								},
								series : [ {
									"data" : <%=request.getAttribute("snc04people")%>,

								}, {
									"data" : <%=request.getAttribute("znc04people")%>,

								}, {
									"data" : <%=request.getAttribute("lnc04people")%>,

								} ]
							}, {
								title : {
									'text' : '2006全国调查经济数据'
								},
								series : [ {
									"data" : <%=request.getAttribute("snc06people")%>,

								}, {
									"data" : <%=request.getAttribute("znc06people")%>,

								}, {
									"data" : <%=request.getAttribute("lnc06people")%>,

								} ]
							} ]
		};
                    
                    
            // 为echarts对象加载数据 
            myChart.setOption(option);        
        }
 
  }
</script>
<script type="text/javascript">
		nrkBarInit();
	</script>
</html>
