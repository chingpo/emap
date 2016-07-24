<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
	
</head>
<body>

	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="popuBar" style="height:400px"></div>
	<!-- ECharts单文件引入 -->
	<script type="text/javascript">
		function popuBarInit() {
			// 路径配置
			require.config({
				paths : {
					echarts : 'http://echarts.baidu.com/build/dist'
				}
			});

			// 使用
			require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line',
					'echarts/chart/pie'
			// 使用柱状图就加载bar模块，按需加载
			], DrawEChart);
			function DrawEChart(ec) {
				// 基于准备好的dom，初始化echarts图表
				var myChart = ec.init(document.getElementById('popuBar'));
				var option = {

					calculable : true,
					grid : {
						'y' : 80,
						'y2' : 100
					},
					calculable : true,
					timeline : {
						data : [ '1991', '1993', '1997', '2000', '2004', '2006' ],
						autoPlay : false,
					},
					options : [
							{
								title : {
									'text' : '1991全国调查经济数据',
									'subtext' : '数据来自CHNS'
								},
								tooltip : {
									show : true
								},
								legend : {
									data : [ '第一职业收入', '耕种', '渔业' ]
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
									data : getDataByKey("1991", "income1")
								} ],
								yAxis : [ {
									type : 'value'
								} ],
								series : [ {
									"name" : "第一职业收入",
									"type" : "bar",
									"data" : getDataByKey("1991", "income1"),
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
									"name" : "耕种",
									"type" : "bar",
									"data" : getDataByKey("1991", "t_farm"),
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
									"name" : "渔业",
									"type" : "bar",
									"data" : getDataByKey("1991", "t_fish"),
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
							}, {
								title : {
									'text' : '1993全国调查经济数据'
								},
								series : [ {
									"data" : getDataByKey("1993", "income1"),

								}, {
									"data" : getDataByKey("1993", "t_farm"),

								}, {
									"data" : getDataByKey("1993", "t_fish"),

								} ]
							}, {
								title : {
									'text' : '1997全国调查经济数据'
								},
								series : [ {
									"data" : getDataByKey("1997", "income1"),

								}, {
									"data" : getDataByKey("1997", "t_farm"),

								}, {
									"data" : getDataByKey("1997", "t_fish"),

								} ]
							}, {
								title : {
									'text' : '2000全国调查经济数据'
								},
								series : [ {
									"data" : getDataByKey("2000", "income1"),

								}, {
									"data" : getDataByKey("2000", "t_farm"),

								}, {
									"data" : getDataByKey("2000", "t_fish"),

								} ]
							}, {
								title : {
									'text' : '2004全国调查经济数据'
								},
								series : [ {
									"data" : getDataByKey("2004", "income1"),

								}, {
									"data" : getDataByKey("2004", "t_farm"),

								}, {
									"data" : getDataByKey("2004", "t_fish"),

								} ]
							}, {
								title : {
									'text' : '2006全国调查经济数据'
								},
								series : [ {
									"data" : getDataByKey("2006", "income1"),

								}, {
									"data" : getDataByKey("2006", "t_farm"),

								}, {
									"data" : getDataByKey("2006", "t_fish"),

								} ]
							} ]

				};
				// 为echarts对象加载数据 
				myChart.setOption(option);
			}
		}
	</script>
<script type="text/javascript">
		function getDataByKey(qYear, qType) {
			var barJson = {};
			$.ajax({
				type : "get",
				url : "bar.do",
				data : {
					year : qYear,
					type : qType
				},
				async : false,
				success : function(data, status) {
					if (status = "success") {
						barJson = JSON.parse(data);
					}
				}
			});
			return barJson;
		}
		popuBarInit();
	</script>
</body>