package com.gn.sungha.dashboard;

import lombok.Data;

@Data
public class SelectListVO {
    private String name;
    private String id;

    public SelectListVO(String name, String id){
        this.name = name;
        this.id = id;
    }
}
