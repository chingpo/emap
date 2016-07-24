<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> 
 <!DOCTYPE html>
<head>
    <meta charset="utf-8">
    

   
 <script src="./js/esl.js"></script>
  <script src="./js/timelineOption.js"></script>
    <script src="./js/echartsHome.js"></script>
        <script src="./js/bootstrap.min.js"></script>
          <script src="./js/echartsExample.js"></script>
   <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
   <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    
    
   
</head>
<body>

    <div id="abc" style="height:500px"></div>
               
    <script type="text/javascript">
    
        require.config({
            paths: {
            	  echarts: 'http://echarts.baidu.com/build/dist'
            	  
            }
        });
 

        require(
            [
                'echarts',
                'echarts/chart/pie',
                'echarts/chart/bar',
                'echarts/chart/line'      
            ],
                DrawEChart
            );
             function DrawEChart(ec){

                var myChart = ec.init(document.getElementById('abc'));
var option = {
    options:[
        {
            title : {
                'text':'2000',
                'subtext':'数据来自chns'
            },
            tooltip : {'trigger':'axis'},
            legend : {
                x:'right',
                'data':['第一职业收入','耕种','渔业'],
                'selected':{
                    '第一职业收入':true,
                    '耕种':true,
                    '渔业':true,
                
                }
            },
            toolbox : {
                'show':true, 
                orient : 'vertical',
                x: 'right', 
                y: 'center',
                'feature':{
                    'mark':{'show':true},
                    'dataView':{'show':true,'readOnly':false},
                    'magicType':{'show':true,'type':['line','bar','stack','tiled']},
                    'restore':{'show':true},
                    'saveAsImage':{'show':true}
                }
            },
            calculable : true,
            grid : {'y':80,'y2':100},
            xAxis : [{
                'type':'category',
                'axisLabel':{'interval':0},
                'data': function(){
                                var json= <%=request.getAttribute("income") %>;  
                                  var arr=[];
                                   for(var i=0;i<json.length;i++){
                                              arr.push(json[i].name);
                                            }                       
                                return arr;
                            }()
            }],
            yAxis : [
                {
                    'type':'value',
                    'name':'收入（元）',
                   
                }
               
            ],
            series : [
                {
                    'name':'第一职业收入',
                    'type':'bar',
                    'markLine':{
                        symbol : ['arrow','none'],
                        symbolSize : [4, 2],
                        itemStyle : {
                            normal: {
                                lineStyle: {color:'orange'},
                                barBorderColor:'orange',
                                label:{
                                    position:'left',
                                    formatter:function(params){
                                        return Math.round(params.value);
                                    },
                                    textStyle:{color:'orange'}
                                }
                            }
                        },
                        'data':[{'type':'average','name':'平均值'}]
                    },
                    'data': function(){
                                var json= <%=request.getAttribute("income") %>;  
                                  var arr=[];
                                   for(var i=0;i<json.length;i++){
                                              arr.push(json[i].value);
                                            }                       
                                return arr;
                            }()
                },
                {
                    'name':'耕种','yAxisIndex':1,'type':'bar',
                    'data': function(){
                                var json= <%=request.getAttribute("farm") %>;  
                                  var arr=[];
                                   for(var i=0;i<json.length;i++){
                                              arr.push(json[i].value);
                                            }                       
                                return arr;
                            }()
                },
                {
                    'name':'渔业','yAxisIndex':1,'type':'bar',
                    'data': function(){
                                var json= <%=request.getAttribute("fish") %>;  
                                  var arr=[];
                                   for(var i=0;i<json.length;i++){
                                              arr.push(json[i].value);
                                            }                       
                                return arr;
                            }()
                }
              
            ]
        },
      
    ]
};
                             
                    
                    
                              
                myChart.setOption(option,true);
            }

    </script>
    

</body>