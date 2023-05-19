let sensorPositions;
let markerImageSrc;
let infowindow = new kakao.maps.InfoWindow({removable: true});
let infoArray = [];
//var clusterer;

function fnInitMap() {
    let mapContainer = document.getElementById('map');
    let mapOption  = {
        center: new kakao.maps.LatLng(37.57630458539637, 127.00198108605709),
        level: 7
    };
    map = new kakao.maps.Map(mapContainer, mapOption );

    markerImageSrc= '/static/img/mar01.png';  // 마커이미지의 위치입니다.
    sensorPositions= [];
}

// 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
function createMarkerImage(src, size, options) {
    let markerImage = new kakao.maps.MarkerImage(src, size, options);
    return markerImage;
}

// 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
function createMarker(position, image) {
    let marker = new kakao.maps.Marker({
        position: position,
        image: image
    });

    return marker;
}


function createSensorMarkersByData(data) {
    let bounds = new kakao.maps.LatLngBounds();
    for (let i = 0; i < data.length; i++) {
        if(!isEmpty(data[i])&&!isEmpty(data[i].latitudeY)&&!isEmpty(data[i].longitudeX)) {
            // 마커 이미지의 이미지 크기 입니다
            let imageSize = new kakao.maps.Size(24, 35);
            // 옵션설정
            let imageOptions = {
                spriteOrigin: new kakao.maps.Point(0, 0),
                spriteSize: new kakao.maps.Size(31, 31)
            };
            let conStat = fnConStat(data[i].regDateTime);
            // 통신 연결 상태이면 (24간 안에 측정값이 있으면)
            if (conStat) {
                // 연결상태
                markerImageSrc = fnFinMarkerImg(Number(data[i].humi))
            } else {
                // 통신 두절
                markerImageSrc = '/static/img/mar04.png'
            }
            // 마커이미지와 마커를 생성합니다
            let markerImage = createMarkerImage(markerImageSrc, imageSize)
            let placePosition = new kakao.maps.LatLng(data[i].latitudeY, data[i].longitudeX)
            let marker = createMarker(placePosition, markerImage);
            // 인포윈도우를 생성합니다
            infowindow = new kakao.maps.InfoWindow({
                position: placePosition,
                content: '<span class="area">' + data[i].sensor + '</span>'
            });
            infoArray.push(infowindow)
            // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
            infowindow.open(map, marker);
            // 생성된 마커를  센서마커 배열에 추가합니다
            sensorMarkers.push(marker);
            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);
            //marker.setMap(map)
        }
    }
    //데이터가 있을경우만 실행
    if(data.length > 0) {
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }
}
function createIrrigationMarkersByData(data) {
    let bounds = new kakao.maps.LatLngBounds();
    for (let i = 0; i < data.length; i++) {
        // 마커 이미지의 이미지 크기 입니다
        let imageSize = new kakao.maps.Size(24, 35);
        // 옵션설정
        let imageOptions = {
            spriteOrigin: new kakao.maps.Point(0, 0),
            spriteSize: new kakao.maps.Size(31, 31)
        };
        // 관수 표시
        markerImageSrc ='/static/img/markerStar.png'

        // 마커이미지와 마커를 생성합니다
        let markerImage = createMarkerImage(markerImageSrc, imageSize)
        let placePosition = new kakao.maps.LatLng(data[i].latitudeY, data[i].longitudeX)
        console.log(placePosition)
        let marker = createMarker(placePosition, markerImage);
        // 인포윈도우를 생성합니다
        infowindow = new kakao.maps.InfoWindow({
            position : placePosition,
            content : '<span class="area">'+data[i].irrigationName+'</span>'
        });
        infoArray.push(infowindow)
        // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
        infowindow.open(map, marker);
        // 생성된 마커를  센서마커 배열에 추가합니다
        irrMarkers.push(marker);
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
        //marker.setMap(map)
    }
    //데이터가 있을경우만 실행
    if(data.length > 0) {
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }
}

// 지도에 표시된 마커를 제거한다
function removeMarker(id){
    if(!id) {
        sensorMarkers.forEach(i => {
            i.setMap(null);
        })
        sensorMarkers = []
    }else{
        irrMarkers.forEach(i => {
            i.setMap(null);
        })
        irrMarkers = []
    }
}

// 센서 마커들의 지도 표시 여부를 설정하는 함수입니다
function setSensorMarkers(map) {
    for (let i = 0; i < sensorMarkers.length; i++) {
        sensorMarkers[i].setMap(map);
    }
}
// 센서 마커들의 지도 표시 여부를 설정하는 함수입니다
function setIrrMarkers(map) {
    for (let i = 0; i < irrMarkers.length; i++) {
        irrMarkers[i].setMap(map);
    }
}
function changeMarker(map){
    setSensorMarkers(map);
}
function fnSetMarkerInfoStyle(){
    let infoTitle = document.querySelectorAll('.area');
    infoTitle.forEach(function(e) {
        let w = e.offsetWidth+ 1;
        let ml = (w/2)-1;
        e.parentElement.style.top = "70px";
        e.parentElement.style.left = "50%";
        e.parentElement.style.marginLeft = -ml+"px";
        e.parentElement.style.width = w+"px";
        e.parentElement.previousSibling.style.display = "none";
        e.parentElement.parentElement.style.border = "0px";
        e.parentElement.parentElement.style.background = "unset";
    });
}
// 위도우 인포를 닫아준다
function closeMarkerInfo() {
    infoArray.forEach(a=>{
        a.close();
    })
    infoArray = [];
}

// 조건에 따라 센서 색이 변함
// 습도(수분함량) 7% 미만시 적색 / 11% 미만시 주황색 /11% 이상 시 녹색
// 통신상태 : 24시간 동안 데이터 미 수신시 적색
function fnFinMarkerImg(humi){
    img =  '/static/img/mar01.png';
    if(humi<11){
        img =  '/static/img/mar02.png';
    }
    if(humi<7){
        img =  '/static/img/mar03.png';
    }
    // console.log(img)
    return img;
}
// 연결 상태 확인 마지막 log가
// 24 시간이 넘어 가면
// 검정색 표시
function fnConStat(dt){
    let res = false;
    if(!isEmpty(dt)) {
        let d = []
        d.push(dt.slice(0, 4))
        d.push(dt.slice(4, 6))
        d.push(dt.slice(6, 8))
        d.push(dt.slice(8, 10))
        d.push(dt.slice(10, 12))
        d.push(dt.slice(12, 14))
        let ddt =  ''+d[0] + '-' + d[1] + '-' + d[2] + ' ' + d[3] + ':' + d[4] + ':' + d[5]+''
        let dateTime = moment(ddt)
        let date = new Date();
        let now = moment(date).format('YYYY-MM-DD HH:mm:ss');
        let nowRe = moment(now);
        let diff = moment.duration(nowRe.diff(dateTime)).asHours()
        if(moment.duration(nowRe.diff(dateTime)).asHours()<24){
            res = true
        }
    }
    return res;
}





