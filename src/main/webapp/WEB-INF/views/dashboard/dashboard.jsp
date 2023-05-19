<%--
  Created by IntelliJ IDEA.
  User: LEY
  Date: 2023-02-03
  Time: 오전 12:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <title>현장정보</title>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
    <script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=fbfe7816953095f8e8b87ef1e7967ffc&libraries=services,clusterer&charset=utf-8"></script>
    <script type="text/javascript" src="/static/js/map.js"></script>
    <script type="text/javascript" src="/static/js/common/moment.min.js"></script>
    <link href="/static/css/map.css" rel="stylesheet">

    <!--퍼블 적용-->
    <link rel="stylesheet" href="/static/assets/css/site/list.css">
    <link rel="stylesheet" href="/static/assets/css/common.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/assets/css/site/sidebar_right.css">
    <link rel="stylesheet" href="/static/assets/css/modal_pc.css" />


    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="/static/assets/js/common.js"></script>
    <style>
        .condition-search-site{
            align-items: baseline!important;
        }

    </style>
    <!-- -->
</head>
<body >

<div class="talk-msg"><span>끌어 올리시면 더 많은 정보를 볼 수 있습니다.</span></div>
<input type="checkbox" class="openSidebarMenu3" id="openSidebarMenu3" style="position: absolute;">
<div id="sidebarMenu3" >
    <div class="res-sidemenu3-draw"></div>

    <label for="openSidebarMenu3" class="sidebarIconToggle3" >
        <div class="spinner spinner-bottom diagonal part-1"></div>
        <div class="spinner spinner-bottom  horizontal"></div>
        <div class="spinner spinner-bottom  diagonal part-2"></div>
    </label>

    <div class="search-sidemenu">
        <div>
            <select class="search-sidemenu-select" name="sensor" id="sensorListSelecBox" onchange="fnGetSensorInfo(this)">
                <option>전체</option>
            </select>
        </div>
        <div class="mr-3 count">
            <%--<span class="circle-black sidemenu-top-txt"  id="disConn">0</span>--%>
            <span class="circle-red sidemenu-top-txt"    id="emergency">0</span>
            <span class="circle-orange sidemenu-top-txt" id="warning">0</span>
            <span class="circle-green sidemenu-top-txt"  id="good">0</span>
        </div>
    </div>

<%--    <select name="sensor" id="sensorListSelecBox" onchange="fnGetSensorInfo(this)">
        <option value="">전체</option>
    </select>
    <div class="count a z">
        <div id="disConn">0</div>
        <div id="emergency">0</div>
        <div id="warning">0</div>
        <div id="good">0</div>
    </div>
    <br id="sensorBr"/>
    <div id="sensorBox"></div>--%>


    <div class="sidemenu-top-line"></div>
    <p class="sidemenu-desc condition-desc-type3" data-toggle="modal" data-target="#use_guide" >이용안내</p>
    <div id="style-4" class="sidemenu-scroll">
        <div id="sensorBox"></div>

     <%--   <div class="sidemenu-content-head">
            <span class="circle-red sidemenu-head-txt">센서명1</span>
            <span class="sidemenu-head-txt-right">40%</span>
        </div>

        <div class="sidemenu-content">
            <table class="sidemenu-table">
                <thead>
                <tr>
                    <th>온도</th>
                    <th>수분함량</th>
                    <th style="text-align:center;">산도</th>
                    <th style="text-align:center;">전도도</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>17℃</td>
                    <td style="text-align:center;">40%</td>
                    <td>10.0PH</td>
                    <td>10.56ds/m</td>
                </tr>
                </tbody>
            </table>

            <div class="sidemenu-content-line"></div>

            <table class="sidemenu-table">
                <thead>
                <tr>
                    <th>질소</th>
                    <th>인</th>
                    <th>칼륨</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>10.0mg/kg</td>
                    <td>8.56mg/kg</td>
                    <td>8.56cmol/kg</td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 2-->
        <div class="sidemenu-space-content"></div>
        <div class="sidemenu-content-head">
            <span class="circle-red sidemenu-head-txt">센서명2</span>
            <span class="sidemenu-head-txt-right">40%</span>
        </div>

        <div class="sidemenu-content">
            <table class="sidemenu-table">
                <thead>
                <tr>
                    <th>온도</th>
                    <th>수분함량</th>
                    <th style="text-align:center;">산도</th>
                    <th style="text-align:center;">전도도</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>17℃</td>
                    <td style="text-align:center;">40%</td>
                    <td>10.0PH</td>
                    <td>10.56ds/m</td>
                </tr>
                </tbody>
            </table>

            <div class="sidemenu-content-line"></div>

            <table class="sidemenu-table">
                <thead>
                <tr>
                    <th>질소</th>
                    <th>인</th>
                    <th>칼륨</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>10.0mg/kg</td>
                    <td>8.56mg/kg</td>
                    <td>8.56cmol/kg</td>
                </tr>
                </tbody>
            </table>

        </div>--%>


    </div>

</div>

<div class="sh-app-site" >
    <div class="sh-sidebar" style="z-index:99">
        <div style="background: black;"></div>

        <!-- responsive menu -->
        <%@ include file="/WEB-INF/views/menu.jsp" %>
        <!-- responsive menu end -->

        <div class="sh-main-site" >
            <div id="backdrop_on" class="res-backdrop fade"></div>
            <input type="checkbox" class="openSidebarMenu2" id="openSidebarMenu2">
            <div id="sidebarMenu2">
                <label for="openSidebarMenu2" class="sidebarIconToggle2" >

                </label>
                <span class="ml-4"></span>
                <span class="site-title">천안신방삼부르르...</span><span class="site-percent">0%</span>
                <span class="site-title">천안구룡지구도도...</span><span class="site-percent">15%</span>
                <span class="site-title">천안신방삼부르르...</span><span class="site-percent">0%</span>
                <span class="site-title">천안구룡지구도도...</span><span class="site-percent">15%</span>
            </div>
            <div class="sidemenu-top-hidden">
                <span class="ml-4"></span>
                <span class="site-title">천안신방삼부르르...</span><span class="site-percent">0%</span>
                <span class="site-title">천안구룡지구도도...</span><span class="site-percent">15%</span>

                <div class="mt-4"></div>
                <span class="ml-4"></span>
                <span class="site-title">천안신방삼부르르...</span><span class="site-percent">0%</span>
                <span class="site-title">천안구룡지구도도...</span><span class="site-percent">15%</span>

                <div class="mt-4"></div>
                <span class="ml-4"></span>
                <span class="site-title">천안신방삼부르르...</span><span class="site-percent">0%</span>
                <span class="site-title">천안구룡지구도도...</span><span class="site-percent">15%</span>

                <div class="mt-4"></div>
                <span class="ml-4"></span>
                <span class="site-title">천안신방삼부르르...</span><span class="site-percent">0%</span>
                <span class="site-title">천안구룡지구도도...</span><span class="site-percent">15%</span>
            </div>
        </div>

        <form id="mainSerch">
            <div class="sh-content-site" style="z-index: 1;">
                <div class="condition-search-site">
                    <div>
                        <select class="select-srch-site mb-1" name="organizationId" id="orgList" onchange="fnGetLocalInfo(this)">
                            <option value="">전체</option>
                        </select>
                    </div>
                    <div>
                        <select class="select-srch-site " name="localId" id="localList">
                            <option value="">전체</option>
                        </select>
                    </div>
                    <div >
                        <button class="icon-primary-small btn-search srch-btn" type="button" onclick="fnMainSearch()">검색</button>
                    </div>
                </div>
            </div>
        </form>
         <%--<div class="located-desc">
            <div class="mt-1"></div>
            <span class="located-title">현장명</span>
            <div class="located-line"></div>
            <div class="mt-2"></div>
            <span class="circle-red">17</span>
            <span class="circle-orange sidemenu-top-txt">10</span>
            <span class="circle-green sidemenu-top-txt">10</span>
        </div>
        <div class="located-desc-simple located-title">현장명</div>--%>
        <div class="map-area" id="map"></div>
    </div>
</div>
</body>


<%--<body>
    <div id="wapper">
       &lt;%&ndash; <%@ include file="/WEB-INF/views/includes/nav.jsp" %>&ndash;%&gt;
        <%@ include file="/WEB-INF/views/menu.jsp" %>
        <section>
            <div class="map-wrap">
                <div class="map-head">
                    <!-- 지도 위에 표시될 마커 카테고리 -->
                    <div class="category">
                        <form id="mainSerch">
                            <select name="organizationId" id="orgList" onchange="fnGetLocalInfo(this)">
                                <option value="">전체</option>
                            </select>
                            <select name="localId" id="localList">
                                <option value="">전체</option>
                            </select>
                            <button class="map-button" type="button" onclick="fnMainSearch()">
                               검색
                            </button>
                        </form>
                    </div>
                </div>
                <!-- GIS 배경지도 -->
                <div class="map-area" id="map"></div>
            </div>
        </section>
        <aside>
            <select name="sensor" id="sensorListSelecBox" onchange="fnGetSensorInfo(this)">
                <option value="">전체</option>
            </select>
            <div class="count a z">
                <div id="disConn">0</div>
                <div id="emergency">0</div>
                <div id="warning">0</div>
                <div id="good">0</div>
            </div>
            <br id="sensorBr"/>
            <div id="sensorBox"></div>
        </aside>
    </div>
</body>--%>
<script>
    let map;
    let sensorMarkers = []
    let totCount = {
        disConn: 0,
        emergency:0,
        warning: 0,
        good: 0
    };

    // satrt
    $(function(e){
        // 초기화
        fnIit();
        // 지도 정보를 가져온다
        fnInitMap();
        // 센서정보 전체를 가져온다
        fnMainSearch();
        // 기관정보를 가져온다
        fnGetOrgInfo();

        fnGetLocalInfo();

    });
    function fnIit(){
        $(".sidemenu-top-hidden").hide();


        $('#openSidebarMenu2').click(function() {
            if (!$(this).is(':checked')) {
                $('.sidebarIconToggle2').css('transform','rotate(0deg)');
                $(".sidemenu-top-hidden").hide();

            }else{
                $('.sidebarIconToggle2').css('width','30px');
                $('.sidebarIconToggle2').css('left','98.6%');
                $('.sidebarIconToggle2').css('transform','rotate(180deg)');

                //open
                $(".sidemenu-top-hidden").show();
            }
        });
    }
    // 기관정보를 가져온다
    function fnGetOrgInfo() {
        let url ="<c:url value='/dashboard/orgList.ajax'/>"
        let data = JSON.stringify({ organizationId : ""})
        $.ajax({
            url: url,
            data: data,
            dataType:'json',
            processData:false,
            contentType:'application/json; charset=UTF-8',
            type:'POST',
            traditional :true,
            success: function(data){
                $("#orgList option").remove();
                $("#orgList").append('<option value="">전체</option>');
                $.each(data, function(index, value){
                    $("#orgList").append('<option value="'+value.organizationId+'">'+value.organization+'</option>');
                });
            }
        });
        return false;
    }
    // 지역정보를 가져온다
    function fnGetLocalInfo(o) {
        let orgId = "";
        if(o){
            orgId = o.value;
        }
        let data = JSON.stringify({ organizationId : orgId})
        let url ="<c:url value='/dashboard/localList.ajax'/>"
        $.ajax({
            url: url,
            data: data,
            dataType:'json',
            processData:false,
            contentType:'application/json; charset=UTF-8',
            type:'POST',
            traditional :true,
            success: function(data){
                $("#localList option").remove();
                $("#localList").append('<option value="">전체</option>');
                $.each(data, function(index, value){
                    $("#localList").append('<option value="'+value.localId+'">'+value.local+'</option>');
                });
            }
        });
        return false;
    }
    // 메인 검색 버튼
    function fnMainSearch(o){
        let form_data =	$('#mainSerch').serializeArray();
        let data = JSON.stringify(objectifyForm(form_data));
        let url ="<c:url value='/dashboard/mainSearch.ajax'/>"
        $.ajax({
            url: url,
            data: data,
            dataType:'json',
            processData:false,
            contentType:'application/json; charset=UTF-8',
            type:'POST',
            traditional :true,
            success: function(data){
                $("#sensorListSelecBox option").remove();
                $("#sensorListSelecBox").append('<option value="">전체</option>');
                $.each(data, function(index, value){
                    if(value!=null) {
                        $("#sensorListSelecBox").append('<option value="' + value.id + '">' + value.name + '</option>');
                    }
                });
                // 센서 정보를 가져온다
                fnGetSensorInfo();
            }
        });
        return false;
    }
    // 센서 정보를 가져온다
    function fnGetSensorInfo(o) {
        //센서정보를 초기화 한다
        fnSensorInfoInit()
        let form_data =	$('#mainSerch').serializeArray();
        let obj = objectifyForm(form_data)
        // 센서 셀렉트 박스에서 센서를 선택한 경우
        if(o){
            obj.sensorId = o.value;
        }
        let data = JSON.stringify(obj);
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
                $.each(data, function(index, value) {
                    if(value!=null) {
                        let conStat = fnConStat(value.regDateTime);
                        let cNm = '';
                        // 통신 연결 상태이면 (24간 안에 측정값이 있으면)
                        if (conStat) {
                            // 연결상태
                            cNm = fnFinMarkerClassNm(Number(value.humi))
                        } else {
                            // 통신 두절
                            cNm = 'circle-black'
                        }
                        $("#sensorBox").append(
                            '<div class="sidemenu-content-head">' +
                                '<span class="'+ cNm+' sidemenu-head-txt">' + value.sensor + '</span>'+
                                '<span class="sidemenu-head-txt-right">' + fnNullVale(value.humi) + '</span>'+
                            '</div>'+
                            '<div class="sidemenu-content">'+
                                '<table class="sidemenu-table">'+
                                    '<thead>'+
                                    '<tr>'+
                                        '<th>온도</th>'+
                                        '<th>수분함량</th>'+
                                        '<th style="text-align:center;">산도</th>'+
                                        '<th style="text-align:center;">전도도</th>'+
                                    '</tr>'+
                                    '</thead>'+
                                    '<tbody>'+
                                    '<tr>'+
                                        '<td>' + fnNullVale(value.temp) + '</td>'+
                                        '<td style="text-align:center;">' + fnNullVale(value.humi) + '%</td>'+
                                        '<td>' + fnNullVale(value.ph) + 'PH</td>'+
                                        '<td>' + fnNullVale(value.conduc) + 'ds/m</td>'+
                                    '</tr>'+
                                    '</tbody>'+
                                '</table>'+
                                '<div class="sidemenu-content-line"></div>'+
                                '<table class="sidemenu-table">'+
                                    '<thead>'+
                                    '<tr>'+
                                        '<th>질소</th>'+
                                        '<th>인</th>'+
                                        '<th>칼륨</th>'+
                                    '</tr>'+
                                    '</thead>'+
                                    '<tbody>'+
                                    '<tr>'+
                                        '<td>(-)mg/kg</td>'+
                                        '<td>' + fnNullVale(value.nitro) + 'mg/kg</td>'+
                                        '<td>' + fnNullVale(value.phos) + 'cmol/kg</td>'+
                                    '</tr>'+
                                    '</tbody>'+
                                '</table>'+
                            '</div>'+
                        '<div class="sidemenu-space-content"></div>');
                    }
                });
                createSensorMarkersByData(data);
                changeMarker(map);
                // 마커 인포스타일을 변경한다
                fnSetMarkerInfoStyle();
                fnSetTotCount(data);
            }
        });
        return false;
    }
    // 조건에 따라 센서 색이 변함
    // 습도(수분함량) 7% 미만시 적색 / 11% 미만시 주황색 /11% 이상 시 녹색
    // 통신상태 : 24시간 동안 데이터 미 수신시 적색
    function fnFinMarkerClassNm(humi){
       let classNm =  'circle-green';
        if(humi<11){
            classNm =  'circle-orange';
        }
        if(humi<7){
            classNm =  'circle-red';
        }
        // console.log(img)
        return classNm;
    }
    function fnSensorInfoInit(){
        // totCount json 값 초기화
        $.each(totCount, (key, value)=>{
            totCount[key] = 0;
        });
        // 센서카드 초기화
        $("#sensorBox").empty();
        // 마커 초기화
        removeMarker();
        // 마커인포 초기화
        closeMarkerInfo();
    }
    // count 수를 셋팅한다
    function fnSetTotCount(data){
        $.each(data, function(i, value) {
            if(data[i]!=null) {
                let stat = fnConStat(data[i].regDateTime);
                // 통신 연결 상태이면 (24간 안에 측정값이 있으면)
                if (stat) {
                    // 연결상태
                    totCount.emergency = fnEmergency(Number(data[i].humi)) + totCount.emergency
                    totCount.warning = fnWarning(Number(data[i].humi)) + totCount.warning
                    totCount.good = fnGood(Number(data[i].humi)) + totCount.good
                } else {
                    // 통신두절
                    totCount.disConn = ++totCount.disConn
                }
            }
        })
        $('.count #emergency').text(totCount.emergency);
        $('.count #warning').text(totCount.warning);
        $('.count #good').text(totCount.good);
        $('.count #disConn').text(totCount.disConn);
        // console.log(totCount);
    }
    // 위험 count
    function fnEmergency(humi){
        let count = 0;
        if(humi<7){
            count = 1
        }
        return count;
    }
    // 경고 count
    function fnWarning(humi){
        let count = 0;
        if(7<=humi&&humi<11){
            count = 1
        }
        return count;
    }
    // 경고 count
    function fnGood(humi){
        let count = 0;
        if(11<=humi){
            count = 1
        }
        return count;
    }
</script>
</html>

<!-- Modal -->
<div class="modal fade" id="use_guide" tabindex="-1" role="dialog" aria-labelledby="deluserLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-content-site">
            <div class="modal-header" style="border-bottom: 0px;">
                <h5 class="modal-title-del" id="exampleModalLabel">이용 안내</h5>
                <span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
            </div>

            <div class="modal-body modal-body-content-del">
                <p class="site-modal-head">
                    시그널트리 토양센서 계측항목 안내
                </p>
                <table class="modal-site-table">
                    <tr>
                        <td class="title"><li>배터리(0~100%)</li></td>
                        <td class="desc">잔여 배터리 상태</td>
                    </tr>
                    <tr>
                        <td class="title"><li>통신</li></td>
                        <td class="desc">24시간 데이터 미 수신시 응급상태 발생</td>
                    </tr>
                    <tr>
                        <td class="title"><li>온도(-40~80℃)</li></td>
                        <td class="desc">토양의 수분 보유량을 측정하는 것으로 양토 기준으로 11~18%가 적정</td>
                    </tr>
                    <tr>
                        <td class="title"><li>산도(0~14 PH)</li></td>
                        <td class="desc">토양 내 전기전도도를 측정하는 것으로 비료 농도가 높을수록 수치가 높게 측정되며,
                            0~0.5ds/m가 적정</td>
                    </tr>
                    <tr>
                        <td class="title"><li>질소(0~2000mg/kg)</li></td>
                        <td class="desc">광합성에 관여하는 엽록소의 구성요소로 식물 성장에 중요한 역할을 하며, 100~300mg/kg가
                            적정</td>
                    </tr>
                    <tr>
                        <td class="title"><li>인(0~2000mg/kg)</li></td>
                        <td class="desc">가지와 잎의 성장에 중요한 역할을 하며, 50~200mg/kg가 적정</td>
                    </tr>
                    <tr>
                        <td class="title"><li>칼륨(0~10cmol/kg)</li></td>
                        <td class="desc">뿌리와 줄기 성장에 중요한 역할을 하며, 0.25∼0.5cmol/kg가 적정</td>
                    </tr>

                </table>
            </div>

            <div class="line-modal-site"></div>
            <div class="line-modal-site-middle"></div>
            <div class="line-modal-site-bottom"></div>

            <div class=" modal-footer-fix-del">
                <button type="button" class="btn-confirm-modal" data-dismiss="modal" style="display:block;margin-left: 10px;">확인</button>
            </div>
        </div>
    </div>
</div>
