package com.gn.sungha.mqtt;

import lombok.Data;

@Data
public class PumpInfoVO {
    /** 사용자ID */
    private String userId;
    /** 사용자 이름 */
    private String userNm;
    /** 제어일자 **/
    private String controlDate;
    /** 제어시간 **/
    private String controlTime;
    /** 제어최소값 **/
    private String valueMin;
    /** 제어최대값 **/
    private String  valueMax;
    /** 기기ID **/
    private String deviceId;
    /** 기기명 **/
    private String device;
    /** on off 상태 값 **/
    private String state;
    /** 제어설정 **/
    private String autoControl;
    /** 총 갯수 */
    private int totcnt;
}
