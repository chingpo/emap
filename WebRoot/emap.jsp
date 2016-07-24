<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'test3.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
	var json = new Object();
	$(document).ready(function() {
		postEcData();
		$("#query").click(function() {
			postEcData();
		});
		function postEcData() {
			$.post("emap.do", {
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
		<form method="post" name="form1" id="form1">
			<div align="center">
				<tr>
					<td width="154">选择年份: <select name="nf" id="nf">
							<option value="1991">1991</option>
							<option value="1993">1993</option>
							<option value="1997">1997</option>
							<option value="2000">2000</option>
							<option value="2004">2004</option>
							<option value="2006">2006</option>
							<!-- 注明人口不可选择91年和93年 -->
					</select>
					</td>
					<td width="154">数据类型: <select name="type" id="type">
							<option value="fi">家庭年总收入</option>
							<option value="fc">家庭年总消费</option>
							<option value="pi">个人年总收入</option>
							<option value="pc">个人年总消费</option>
							<option value="rs">分省调查人数</option>
					</select>
					</td>		
					<td width="113"><input id="query" type="button" value="查询"></td>
				</tr>
			</div>
		</form>
	</div>


	<div id="popuEmap"
		style="height: 400px; width: 1200px; border: 1px solid #ccc; padding: 10px;margin-right:auto;margin-left:auto;">
	</div>
</body>
<script type="text/javascript">
	function echartsInit() {
		//声明js包的路径
		require.config({
			paths : {
				echarts : 'http://echarts.baidu.com/build/dist'
			}
		});
		// Step:4 require echarts and use it in the callback.
		// Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
		require([ 'echarts', 'echarts/chart/map' //按需加载图表关于地图相关的js文件
		], DrawEChart //异步加载的回调函数绘制图表
		);

		//创建ECharts图表方法
		function DrawEChart(ec) {
			var myChart = ec.init(document.getElementById('popuEmap'));
			//定义图表options
			var option = {
				title : {
					text : '数据来自chns',

					x : 'center'
				},
				tooltip : {
					trigger : 'item'
				},
				legend : {
					orient : 'vertical',
					x : 'left',
					data : []
				},
				dataRange : {
					min : 0,
					max : 2500,
					x : 'left',
					y : 'bottom',
					text : [ '高', '低' ], // 文本，默认为数值文本
					calculable : true
				},
				toolbox : {
					show : true,
					orient : 'vertical',
					x : 'right',
					y : 'center',
					feature : {
						mark : {
							show : true
						},
						dataView : {
							show : true,
							readOnly : false
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
				},
				roamController : {
					show : true,
					x : 'right',
					mapTypeControl : {
						'china' : true
					}
				},		
				series : [ {
					name : 'iphone3',
					type : 'map',
					mapType : 'china',
					roam : false,
					itemStyle : {
						normal : {
							label : {
								show : true
							}
						},
						emphasis : {
							label : {
								show : true
							}
						}
					},
					data : json
				},

				]
			};

			myChart.setOption(option);
		}
	}
</script>
<script type="text/javascript" language="javascript">
	echartsInit();
</script>
</html>