<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
</head>
<body>
<div class="sh-app">
    <div style="background: black;"></div>
    <div class="sh-sidebar">
     <div class="logo"> 
      <img src="/static/assets/css/data/assets/logo-vertical.png">
    </div>
    <div class="res-logo"> 
      <img src="/static/assets/css/img_common/mo/logo-vertical.png">
    </div>

  <!-- responsive menu -->
  <div class="res-menu">
   <input type="checkbox" class="openSidebarMenu" id="openSidebarMenu">
  <label for="openSidebarMenu" class="sidebarIconToggle">
    <div class="spinner diagonal part-1"></div>
    <div class="spinner horizontal"></div>
    <div class="spinner diagonal part-2"></div>
  </label>
  <div id="sidebarMenu" class="res-menu-header">
    <ul class="sidebarMenuInner">
      <li class="res-li-header"> <span class="body-3-bold logout" >로그아웃</span></li>
      
      <li class="res-menu-site dropdown" >
        <a href="#" data-toggle="dropdown"  >현장정보</a>
        <div class="res-menu-border"></div>
      </li>
      
      <li class="res-menu-data dropdown">
        <a href="#" data-toggle="dropdown" >데이터
       </a>
         <ul class="dropdown-menu dropdown-menu-ul">
          <li class="dropdown-li"><a href="#">전체현장</a></li>
          <li class="dropdown-li"><a href="#">전체 데이터</a></li>
        </ul>
        <div class="res-menu-border"></div>
      </li>

      <li class="res-menu-sensor dropdown">
        <a href="/sensor/sensorList.do" data-toggle="dropdown">센서
      </a>
        <div class="res-menu-border"></div>
      </li>

      <li class="res-menu-irr dropdown">
        <a href="/irrigation/irrigationList.do" data-toggle="dropdown">관수</a>
        <div class="res-menu-border"></div>
      </li>

      <li class="res-menu-setting dropdown">
       <a href="/sensorControl/sensorControlList.do" data-toggle="dropdown">설정</a>
       <div class="res-menu-border"></div>
     </li>

      <li class="res-menu-user dropdown">
        <a href="#" data-toggle="dropdown">개인정보관리</a>
        <div class="res-menu-border"></div>
      </li>
      
      <li class="res-menu-customer dropdown">
        <a href="#" data-toggle="dropdown">고객센터</a>
        <div class="res-menu-border"></div>
      </li>
    </ul>


      <!-- responsive footer -->
  <div class="responsive-footer h4-bold">
    <div class="responsive-footer-content">
      <p>(주)성하</p>
      <p class="responsive-footer-content-sub">
        <span>대표이사 : 조정윤</span>
        <span>사업자등록번호 : 705-86-01108</span>
        <span>대표번호 : 02-596-2200</span>
        <span>팩스번호 : 02-512-5161</span>
        <span>이메일 : sungha0405@hanmail.net</span>
      </p>
    </div>
  </div>
  <!-- responsive footer end -->
  </div>
</div>
  <!-- responsive menu end -->

    <nav class="nav">
      <div class="nav__entry dropdown-site">
        <!-- <a href="../site_info/site_info_list.html"> -->
        <img src="/static/assets/css/img_common/icon-siteinfo.png">
        <div class="dropdown-content-site">
            <a href="/dashboard/main" class="menu-txt">현장정보<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
          </div>
      </div>

      <div class="nav__entry  dropdown-pc" id="nav_data">
        <img src="/static/assets/css/img_common/icon-data.png">
          <div class="dropdown-content">
            <a href="/sensorInfo/sensorInfoList.do" class="menu-txt">데이터<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <%--  <a href="../data_info/data_info_list_graph.html" class="menu-txt">전체현장<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="../data_info/data_info_list_detail.html" class="menu-txt">전체 데이터<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>--%>
      
          </div>
      </div>

      <div class="nav__entry dropdown-sensor" id="nav_sensor">
        <img src="/static/assets/css/img_common/icon-sensor.png">
        <div class="dropdown-content-sensor">
            <a href="/sensor/sensorList.do" class="menu-txt">센서<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="/sensor/sensorRegist.do" class="menu-txt">센서정보관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
          </div>

      </div>

      <div class="nav__entry  dropdown-irr" id="nav_irr">
        <img src="/static/assets/css/img_common/icon-irr.png">
          <div class="dropdown-content-irr">
            <a href="/irrigation/irrigationList.do" class="menu-txt">관수<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="/irrigation/irrigationRegist.do" class="menu-txt">관수정보관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
          </div>
      </div>

      <div class="nav__entry  dropdown-setting">
        <img src="/static/assets/css/img_common/icon-setting.png">
          <div class="dropdown-content-setting">
            <!-- <a href="../sensor_setting/sensor_setting_list.html" class="menu-txt">설정<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a> -->
            <a href="/sensorControl/sensorControlList.do" class="menu-txt">센서설정관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="/orgInfo/orgInfoList.do" class="menu-txt">기관관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="/local/localList.do" class="menu-txt">지역관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="/userMng/userMngList.do" class="menu-txt">사용자관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
          </div>
      </div>

      <div class="nav__entry  dropdown-user">
        <img src="/static/assets/css/img_common/icon-user.png">
        <div class="dropdown-content-user">
            <a href="../user_info/personal_info_manage.html" class="menu-txt">개인정보 관리<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="../user_info/personal_info_manage.html" class="menu-txt">회원정보 수정<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
          </div>
      </div>

      <div class="nav__entry  dropdown-customer">
        <img src="/static/assets/css/img_common/icon-customer.png">
        <div class="dropdown-content-customer">
            <!-- <a href="../customer_center/customer_center_list.html" class="menu-txt">고객센터<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a> -->
            <a href="/notice/noticeList.do" class="menu-txt">공지사항<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
            <a href="/board/boardList.do" class="menu-txt">1:1 문의<span class="sub-menu-hover"><i class="fa-solid fa-angle-right paging-next-i"></i></span></a>
          </div>
      </div>
    </nav>
  </div>
	
</body>
</html>
