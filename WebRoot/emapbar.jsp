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

<title>My JSP 'emapbar.jsp' starting page</title>

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
	var jsonKey = new Array();
	var jsonValue = new Array();
	var tt = $("#type").find("option:selected").text();
	$(document).ready(function() {
		postEcData();
		$("#query").click(function() {
			tt = $("#type").find("option:selected").text();
			postEcData();
		});
		function postEcData() {
			$.post("emap.do", {
				nf : $("#nf").val(),
				type : $("#type").val()
			}, function(data, status) {
				json = JSON.parse(data);
				for ( var key in json) {
					jsonKey[key] = json[key].name;
					jsonValue[key] = json[key].value;
				}
				emapbar();
			});
		}
	});
</script>

</head>

<body>
	<div class="select_box">
		<form method="post" name="form1" id="form1">
			<div align="right" style="margin-right:120;">
				<tr>
					<td width="154">选择年份: <select name="nf" id="nf">
							<option value="1991">1991年</option>
							<option value="1993">1993年</option>
							<option value="1997">1997年</option>
							<option value="2000">2000年</option>
							<option value="2004">2004年</option>
							<option value="2006">2006年</option>
							<option value="2007">2007年</option>
							<option value="2008">2008年</option>
							<option value="2009">2009年</option>
							<option value="2010">2010年</option>
							<!-- 注明人口不可选择91年和93年 -->
					</select>
					</td>
					<td width="154">数据类型: <select name="type" id="type">
							<option value="fi">家庭年总收入（元）</option>
							<option value="fc">家庭年总消费（元）</option>
							<option value="pi">个人年总收入（元）</option>
							<option value="pc">个人年总消费（元）</option>
							<option value="rs">分省调查人数（元）</option>
							<option value="country">分省物流增加值（亿元）</option>
					</select>
					</td>
					<td width="113"><input id="query" type="button" value="查询"></td>
				</tr>
			</div>
		</form>
	</div>
	<div id="emapbar"
		style="height: 500px; width: 1200px; margin-right:auto;margin-left:auto;">
	</div>

</body>
<script type="text/javascript">
	emapbar();
	function emapbar() {
		// 路径配置
		require.config({
			paths : {
				echarts : 'http://echarts.baidu.com/build/dist'
			}
		});

		// 使用
		require(
				[ 'echarts', 'echarts/chart/map', 'echarts/chart/bar' ],
				function(ec) {
					// 基于准备好的dom，初始化echarts图表
					var myChart = ec.init(document.getElementById('emapbar'));
					// 地图事件响应
					var ecConfig = require('echarts/config');
					var curIndx = 0;
					var mapType = [ 'china',
					// 23个省
					'广东', '青海', '四川', '海南', '陕西', '甘肃', '云南', '湖南', '湖北',
							'黑龙江', '贵州', '山东', '江西', '河南', '河北', '山西', '安徽',
							'福建', '浙江', '江苏', '吉林', '辽宁', '台湾',
							// 5个自治区
							'新疆', '广西', '宁夏', '内蒙古', '西藏',
							// 4个直辖市
							'北京', '天津', '上海', '重庆',
							// 2个特别行政区
							'香港', '澳门' ];
					document.getElementById('emapbar').onmousewheel = function(
							e) {
						var event = e || window.event;
						curIndx += zrEvent.getDelta(event) > 0 ? (-1) : 1;
						if (curIndx < 0) {
							curIndx = mapType.length - 1;
						}
						var mt = mapType[curIndx % mapType.length];
						option.series[0].mapType = mt;
						myChart.setOption(option, true);
						zrEvent.stop(event);
					};
					myChart.on(ecConfig.EVENT.MAP_SELECTED, function(param) {
						var len = mapType.length;
						var mt = mapType[curIndx % len];
						if (mt == 'china') {
							// 全国选择时指定到选中的省份
							var selected = param.selected;
							for ( var i in selected) {
								if (selected[i]) {
									mt = i;
									while (len--) {
										if (mapType[len] == mt) {
											curIndx = len;
										}
									}
									break;
								}
							}
						} else {
							curIndx = 0;
							mt = 'china';
						}
						option.series[0].mapType = mt;
						myChart.setOption(option, true);
					});
					var option = {
						calculable : true,
						xAxis : [ {
							type : 'value',
							position : 'top',
							splitLine : {
								show : false
							},
							boundaryGap : [ 0, 0.01 ]
						} ],
						yAxis : [ {
							type : 'category',
							splitLine : {
								show : false
							},
							data : jsonKey
						} ],
						grid : {
							width : 700,
							height : 400,
							borderWidth : 0,
						},
						tooltip : {
							trigger : 'item'
						},
						toolbox : {
							'show' : true,
							orient : 'horizontal',
							x : 60,
							y : 'top',
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
									'type' : [ 'line', 'bar', 'stack', 'tiled' ]
								},
								'restore' : {
									'show' : true
								},
								'saveAsImage' : {
									'show' : true
								}
							}
						},
						dataRange : {
							min : jsonValue[0],
							max : jsonValue[jsonValue.length - 1],
							orient : 'horizontal',
							x : 'center',
							y : 'bottom',
							text : [ '高', '低' ], // 文本，默认为数值文本
							calculable : true,
							color : [ 'orangered', 'yellow', 'lightskyblue' ]
						},
						series : [
								{
									name : tt,
									type : 'map',
									mapType : 'china',
									mapLocation : {
										x : 'right'
									},
									selectedMode : 'multiple',
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
								{
									name : $("#nf").val(),
									type : 'bar',

									itemStyle : {
										normal : {
											color : function(params) {
												// build a color map as your need.
												var colorList = [ '#C1232B',
														'#B5C334', '#FCCE10',
														'#E87C25', '#27727B',
														'#FE8463', '#9BCA63',
														'#FAD860', '#F3A43B',
														'#60C0DD', '#D7504B',
														'#C6E579', '#F4E001',
														'#F0805A', '#26C0C0',
														'#C1232B', '#B5C334',
														'#FCCE10', '#E87C25',
														'#27727B', '#FE8463',
														'#9BCA63', '#FAD860',
														'#F3A43B', '#60C0DD',
														'#D7504B', '#C6E579',
														'#F4E001', '#F0805A',
														'#26C0C0', '#7AC5CD' ];
												return colorList[params.dataIndex]
											}
										}
									},
									selectedMode : 'multiple',
									data : jsonValue
								}
						]
					};

					// 为echarts对象加载数据 
					myChart.setOption(option);
				});
	}
</script>
</html>
