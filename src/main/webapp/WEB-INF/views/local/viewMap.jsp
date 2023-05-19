<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/static/js/common/moment.min.js"></script>
<script src="/static/js/filtering.js"></script>
<script src="/static/js/common/utils.js"></script>
<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=fbfe7816953095f8e8b87ef1e7967ffc&libraries=services,clusterer&charset=utf-8"></script>
<script type="text/javascript" src="/static/js/map.js"></script>
<link href="/static/css/map.css" rel="stylesheet">

<title>성하 조감도</title>
    <style>
        #mapwrap{position:relative;overflow:hidden;}
        .category, .category *{margin:0;padding:0;color:#000;}
        .category {position:absolute;overflow:hidden;top:10px;left:10px;width:100px;height:25px;z-index:10;border:1px solid black;font-family:'Malgun Gothic','맑은 고딕',sans-serif;font-size:12px;text-align:center;background-color:#fff;}
        .category .menu_selected {background:#219C76;color:#fff;border-left:1px solid #915B2F;border-right:1px solid #915B2F;margin:0 -1px;}
        .category li{list-style:none;float:left;width:50px;height:25px;padding-top:5px;cursor:pointer;}
    </style>
</head>
<body id="body">
<div id="mapwrap"> 
    <!-- 지도가 표시될 div -->
	<div id="map" style="width:100%; height:90vh;"></div>
	<!-- 지도 위에 표시될 마커 카테고리 -->
    <div class="category">
        <ul>
            <li id="sensorMenu" onclick="getMenu('sensor')">
                <span class="ico_comm ico_store"></span>
                센서<p><span id="sensorCnt"></span>
            </li>
            <li id="irrMenu" onclick="getMenu('irr')">
                <span class="ico_comm ico_carpark"></span>
                관수<p><span id="irrigationCnt"></span>
            </li>
        </ul>
    </div>
    <br>
    <input type="button" id="save" onclick="fnSave()" value="저장" />
    <input type="button" id="close" onclick="window.close()" value="닫기" />
	<%--<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de0cdd11b58eb6b48d9b752e8243b940&libraries=services,clusterer,drawing"></script>--%>
    <script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=fbfe7816953095f8e8b87ef1e7967ffc&libraries=services,clusterer,drawing&charset=utf-8"></script>
</div>
</body>
</html>
<script type="text/javascript">
    let map;
    let sensorMarkers = [];
    let irrMarkers = [];
    let localId = window.opener.document.getElementById('viewMapLocalId').value;
    $((e)=>{
        // 지도 정보를 가져온다
        fnInitMap();
        getMenu('sensor');
    });
    function getMenu(id){
        let sensorMenu = document.getElementById('sensorMenu');
        let irrMenu = document.getElementById('irrMenu');

        if(id=='sensor'){
            sensorMenu.className = 'menu_selected';
            irrMenu.className = '';
            // 마커 초기화
            removeMarker('irr');
            // 마커인포 초기화
            closeMarkerInfo();
            // 센서 가져오기
            fnGetSensorInfo();
        }else if(id=='irr'){
            irrMenu.className = 'menu_selected';
            sensorMenu.className = '';
            // 마커 초기화
            removeMarker();
            // 마커인포 초기화
            closeMarkerInfo();
            // 관수 가져오기
            fnGetIrrigationInfo();

        }
    }
    // 센서 정보를 가져온다
    function fnGetSensorInfo() {
        //센서정보를 초기화 한다
        // 마커 초기화
        removeMarker();
        // 마커인포 초기화
        closeMarkerInfo();
        let data = JSON.stringify({ localId :localId})
        let url ="<c:url value='/dashboard/dashSensorList.ajax'/>"
        $.ajax({
            url: url,
            data: data,
            dataType:'json',
            processData:false,
            contentType:'application/json; charset=UTF-8',
            type:'POST',
            traditional :true,
            success: function(data){
                createSensorMarkersByData(data);
                changeMarker(map);
                // 마커 인포스타일을 변경한다
                fnSetMarkerInfoStyle();
            }
        });
        return false;
    }
    // 센서 정보를 가져온다
    function fnGetIrrigationInfo() {
        //센서정보를 초기화 한다
        // 마커 초기화
        removeMarker('irr');
        // 마커인포 초기화
        closeMarkerInfo();
        let data = JSON.stringify({ localId :localId})
        let url ="<c:url value='/dashboard/dashIrrigationList.ajax'/>"
        $.ajax({
            url: url,
            data: data,
            dataType:'json',
            processData:false,
            contentType:'application/json; charset=UTF-8',
            type:'POST',
            traditional :true,
            success: function(data){
                createIrrigationMarkersByData(data);
                setIrrMarkers(map);
                // 마커 인포스타일을 변경한다
                fnSetMarkerInfoStyle();
            }
        });
        return false;
    }
	
</script>
