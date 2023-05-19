package com.gn.sungha.mqtt;

import lombok.Data;

@Data
public class ControlInfoVO {
    /** 매설지점ID */
    private String devicePlotId;
    /** 매설위치 */
    private String devicePlot;
    /** 기기ID */
    private String deviceId;
    /** 기기명 */
    private String device;
    /** 기관ID */
    private String organizationId;
    /** 제어일자 */
    private String controlDate;
    /** 제어일시 */
    private String controlTime;
    /** 제어최소값 */
    private String valueMin;
    /** 제어최대값 */
    private String valueMax;
    /** 사용자 ID*/
    private String userId;
    /** 펌프 on off*/
    private String state;
    /** 설정 유지 **/
    private String autoControl;
}
