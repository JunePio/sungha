package com.gn.sungha.irrigationInfo;

import lombok.Data;

/**
 * @Class Name : IrrigationVO.java
 * @Description : 관수정보 VO
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.08  CHLEE      최초생성
 * @version 1.0
 */

@Data
public class IrrigationInfoVO {
	private int rownum;
	private String irrigationId;
	private String irrigation;
	private int streamTime;
	private int streamFlow;
	private int nutrientTime;
	private int nutrientSolution;
	private String organizationId;
	private String regDate;
	private int totcnt;
	
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public String getIrrigationId() {
		return irrigationId;
	}
	public void setIrrigationId(String irrigationId) {
		this.irrigationId = irrigationId;
	}
	public String getIrrigation() {
		return irrigation;
	}
	public void setIrrigation(String irrigation) {
		this.irrigation = irrigation;
	}
	public int getStreamTime() {
		return streamTime;
	}
	public void setStreamTime(int streamTime) {
		this.streamTime = streamTime;
	}
	public int getStreamFlow() {
		return streamFlow;
	}
	public void setStreamFlow(int streamFlow) {
		this.streamFlow = streamFlow;
	}
	public int getNutrientTime() {
		return nutrientTime;
	}
	public void setNutrientTime(int nutrientTime) {
		this.nutrientTime = nutrientTime;
	}
	public int getNutrientSolution() {
		return nutrientSolution;
	}
	public void setNutrientSolution(int nutrientSolution) {
		this.nutrientSolution = nutrientSolution;
	}
	public String getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(String organizationId) {
		this.organizationId = organizationId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getTotcnt() {
		return totcnt;
	}
	public void setTotcnt(int totcnt) {
		this.totcnt = totcnt;
	}
	
}
