<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>ECharts</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	function chose() {
		document.getElementById(
<%=request.getAttribute("sheng")%>
	).selected = "selected";
	}
</script>
<script type="text/javascript">
	var json = new Object();
	$(document).ready(function() {
		postEcData();
		$("#query").click(function() {
			postEcData();
		});
		function postEcData() {
			$.post("rk2.do", {
				nf : $("#nf").val(),
				type : $("#type").val()
			}, function(data, status) {
				json = JSON.parse(data);
				echartsInit();
			});
		}
	});
</script>
</head>
<body>
	<div class="select_box">

		<form action="rk2.do" id="form1" name="form1" method="post">
			<label for="sheng">请选择省份</label> <select name="sheng" id="sheng">
				<option value="23">黑龙江</option>
				<option value="21">辽宁</option>
				<option value="32">江苏</option>
				<option value="37">山东</option>
				<option value="41">河南</option>
				<option value="42">湖北</option>
				<option value="43">湖南</option>
				<option value="45">广西</option>
				<option value="52">贵州</option>
			</select> <input id="query" type="button"  value="查询" onclick="chose()">
		</form>

	</div>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="rk2" style="height:400px"></div>
	<!-- ECharts单文件引入 -->
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
	<script type="text/javascript">
		rk2Init();
		function rk2Init() {
			// 路径配置
			require.config({
				paths : {
					echarts : 'http://echarts.baidu.com/build/dist'
				}
			});

			// 使用
			require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line',
					'echarts/chart/pie', 'echarts/chart/funnel' // 使用柱状图就加载bar模块，按需加载
			], DrawEChart);

			function DrawEChart(ec) {
				// 基于准备好的dom，初始化echarts图表
				var myChart = ec.init(document.getElementById('rk2'));
				var option = {
					timeline : {
						data : [ '1997', '2000', '2004', '2006' ],
						autoPlay : false,
					},
					options : [
							{
								title : {
									text : '1997年该省调查人口',
									subtext : '数据来源CHNS'
								},
								tooltip : {
									trigger : 'item',
									formatter : "{a} <br/>{b} : {c} ({d}%)"
								},
								legend : {
									data : [ '<15','15-65','>65' ]
								},
								toolbox : {
									show : true,
									feature : {
										mark : {
											show : true
										},
										dataView : {
											show : true,
											readOnly : false
										},
										magicType : {
											show : true,
											type : [ 'pie', 'funnel' ],
											option : {
												funnel : {
													x : '25%',
													width : '50%',
													funnelAlign : 'left',
													max : 1700
												}
											}
										},
										restore : {
											show : true
										},
										saveAsImage : {
											show : true
										}
									}
								},
								series : [

								{
									name : '97年该省调查人口',
									type : 'pie',
									center : [ '50%', '45%' ],
									radius : '50%',
									data : function() {
										var json =
	<%=request.getAttribute("c97people")%>
		;
										return json;
									}()
								} ]
							},
							{
								title : {
									'text' : '2000全国调查经济数据'
								},
								series : [ {
									name : '00年该省调查人口',
									type : 'pie',
									data : function() {
										var json =
	<%=request.getAttribute("c00people")%>
		;
										return json;
									}()
								} ]
							},
							{
								title : {
									'text' : '2004全国调查经济数据'
								},
								series : [ {
									name : '04年该省调查人口',
									type : 'pie',
									data : function() {
										var json =
	<%=request.getAttribute("c04people")%>
		;
										return json;
									}()
								} ]
							},
							{
								title : {
									'text' : '2006全国调查经济数据'
								},
								series : [ {
									name : '06年该省调查人口',
									type : 'pie',
									data : function() {
										var json =
	<%=request.getAttribute("c06people")%>;
										return json;
									}()
								} ]
							} ]
				};

				// 为echarts对象加载数据 
				myChart.setOption(option);
			}

		}
	</script>
	<script type="text/javascript" language="javascript">
	echartsInit();
</script>
</html>
