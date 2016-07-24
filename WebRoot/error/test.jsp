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
<script type="text/javascript">
function chose(){
document.getElementById(<%=request.getAttribute("year")%>).selected="selected";
}
</script> 

  </head>
  
  <body>  
  <h1>基于chns的人口结构调查</h1>
<p>
人口结构，又称人口构成，是指将人口以不同的标准划分而得到的一种结果。其反映一定地区、一定时点人口总体内部各种不同质的规定性的数量比例关系，主要有性别结构和年龄结构。构成这些标准的因素主要包括年龄、性别、人种、民族、宗教、教育程度、职业、收入、家庭人数等。</p>
<p>2013年，我国人口结构已严重失调，少子化与老龄化加剧，人口结构性矛盾也日益显现。</p>
<div class="select_box">

<form action="map.do" id="form1" name="form1" method="post" >
  <label for="year">请选择年份</label>
  <select name="year" id="year">   
    <option value="1997">1997</option>
    <option value="2000">2000</option>
    <option value="2004">2004</option>
    <option value="2006">2006</option>
    </select>
    <input type="submit" name="query" value="查询" onclick="chose()">
</form>

</div>
  <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>
    <!-- ECharts单文件引入 -->
  
      <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    <script type="text/javascript">
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
                'echarts/chart/pie',
                'echarts/chart/map' ,
                'echarts/chart/bar' ,// 使用柱状图就加载bar模块，按需加载
            ],
            DrawEChart
            );
        function DrawEChart(ec) {
            // 基于准备好的dom，初始化echarts图表
           var myChart = ec.init(document.getElementById('main')); 
            var option = {
                  title : {
        text: 'population',
        subtext: 'chns'
    },
    tooltip : {
        trigger: 'item'
    },
    legend: {
        x:'right',
        selectedMode:false,
        data:[]
    },
    dataRange: {
        orient: 'horizontal',
        min: 0,
        max:1569,
        text:['高','低'],           // 文本，默认为数值文本
        splitNumber:0
    },
    toolbox: {
        show : true,
        orient: 'vertical',
        x:'right',
        y:'center',
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false}
        }
    },
    series : [
        {
            name: 'population',
            type: 'map',
            mapType: 'china',
            mapLocation: {
                x: 'left'
            },
            selectedMode : 'multiple',
            itemStyle:{
                normal:{label:{show:true}},
                emphasis:{label:{show:true}}
            },
            data:
               function(){
                                  var json= <%=request.getAttribute("data") %>;                       
                               return json;
                            }()
            
        },
        {
            name:'population',
            type:'bar',
            roseType : 'area',
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            center: [document.getElementById('main').offsetWidth - 250, 225],
            radius: [30, 120],
          xAxis : [
        {
            type : 'value'
          
        }
    ],
    yAxis : [
        {
            type : 'category',
            data :function(){
            		                                var json= <%=request.getAttribute("data") %>;  
            		                                  var arr=[];
            		                                   for(var i=0;i<json.length;i++){
            		                                              arr.push(json[i].name);
            		                                            }                       
            		                                return arr;
            		                            }(),
        }
    ],
    series : [
        {
            name:'2011年',
            type:'bar',
            data:[]
        },
     
    ]
        }
    ],
    animation: false
};

var ecConfig = require('echarts/config');
myChart.on(ecConfig.EVENT.MAP_SELECTED, function (param){
    var selected = param.selected;
    var mapSeries = option.series[0];
    var data = [];
    var legendData = [];
    var name;
    for (var p = 0, len = mapSeries.data.length; p < len; p++) {
        name = mapSeries.data[p].name;
        //mapSeries.data[p].selected = selected[name];
       if (selected[name]) {
                //option.yAxis[0].name = name + ' 人口流动情况';
                var tarIdx;
                for (var i = 0, l = pList.length; i < l; i++) {
                    if (pList[i] == name) {
                        tarIdx = i;
                        break;
                    }
                }
                for (var i = 1987; i <= 2011; i++) {
                    data.push(data[i][tarIdx]);
                }
                option.series.push({
                    name : name,
                    type:'bar',
                    tooltip: {
                        trigger: 'axis'
                    },
                    data: data
                });
                legendData.push(name);
                data = [];
            }
    }
    option.legend.data = legendData;
    option.series[1].data = data;
    myChart.setOption(option, true);
});
                    
                    
                     
            // 为echarts对象加载数据 
            myChart.setOption(option);        
        }
 
  
</script>

</html>
