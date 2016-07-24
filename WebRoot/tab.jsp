<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>中国经济十年时空漫游</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="China">
    <meta name="author" content="kener.linfeng@gmail.com">

    <link href="buju_files/bootstrap.css" rel="stylesheet">
    <link href="buju_files/bootstrap-responsive.css" rel="stylesheet">
    <style type="text/css">

        footer {
            height: 100px;
            background-image: url(../../../asset/img/tweed.png);
            background-repeat: repeat;
            font-size: 14px;
            color: #CCC;
            text-align: center;
            padding-top: 15px;
            margin-top:15px;
        }

        .ctrl-wrap {
            padding:5px 20px 20px 20px;
            text-align: center;
        }

        .g2wrap {
            height:300px;
            width:33%;
            float:left;
        }


    </style>
<body>
    <div class="container">
        <!-- CONTAINER -->
        <div class="row">
            <div id="graphic" class="span12">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs nav-justified">
                  <li class="active"><a id="tab1" href="#main1" data-toggle="tab">当经济成果摊到每个人身上…</a></li>
                  <li class=""><a id="tab2" href="#main2" data-toggle="tab">经济发展有多不平衡？</a></li>
                  <li class=""><a id="tab3" href="#main3" data-toggle="tab">房地产支撑GDP？</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="main1">
                        <p>人均指标选择：
                            <label>
                                <input name="optionsRadios" id="optionsRadios1" value="GDP" checked="checked" type="radio">GDP
                            </label>
                            <label>
                                <input name="optionsRadios" id="optionsRadios2" value="Financial" type="radio">金融
                            </label>
                            <label>
                                <input name="optionsRadios" id="optionsRadios3" value="Estate" type="radio">房地产
                            </label>
                            <label>
                                <input name="optionsRadios" id="optionsRadios4" value="PI" type="radio">第一产业
                            </label>
                            <label>
                                <input name="optionsRadios" id="optionsRadios5" value="SI" type="radio">第二产业
                            </label>
                            <label>
                                <input name="optionsRadios" id="optionsRadios6" value="TI" type="radio">第三产业
                            </label>
                        </p>
                        <jsp:include page="emap.jsp"></jsp:include>
                    </div>
                    <div class="tab-pane" id="main2">
                        <div class="ctrl-wrap">
                            <div class="ctrl-content">
                                <button type="button" class="btn btn-success" id="2002">2002</button>
                                <button type="button" class="btn btn-info" id="2003">2003</button>
                                <button type="button" class="btn btn-info" id="2004">2004</button>
                                <button type="button" class="btn btn-info" id="2005">2005</button>
                                <button type="button" class="btn btn-info" id="2006">2006</button>
                                <button type="button" class="btn btn-info" id="2007">2007</button>
                                <button type="button" class="btn btn-info" id="2008">2008</button>
                                <button type="button" class="btn btn-info" id="2009">2009</button>
                                <button type="button" class="btn btn-info" id="2010">2010</button>
                                <button type="button" class="btn btn-info" id="2011">2011</button>
                            </div>
                        </div>
                        <jsp:include page="bar.jsp"></jsp:include>
                    </div>
                    <div class="tab-pane" id="main3">
                        <jsp:include page="emap.jsp"></jsp:include>
                    </div>
                </div>
            </div><!--/span-->
        </div><!--/row-->
    </div>

	<!--my-->
	<script src="buju_files/jquery.js"></script>
	<script src="buju_files/bootstrap-tab.js"></script>
	<script src="buju_files/djws.js"></script>
</body></html>
