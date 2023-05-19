package com.gn.sungha.weatherInfo;

import lombok.Data;

@Data
public class UserInfoVO {
    /** 사용자ID */
    private String userId;
    /** 사용자 이름 */
    private String userNm;
    /** 사용자 암호 */
    private String userPw;
    /** 사용자 레벨 */
    private String userLevel;
    /** 사용자 상태 */
    private String userState;
    /** 기관ID */
    private String organizationId;
    /** 기관명 */
    private String organization;
    /** 기관지역명 */
    private String organizationLocal;
    /** 지역 X좌표 */
    private String localNx;
    /** 지역 Y좌표 */
    private String localNy;
    /** 지역 ID */
    private String localId;
    /** 총 갯수 */
    private int totcnt;
    /** auth 사용자ID */
    private String authUserId;
}
