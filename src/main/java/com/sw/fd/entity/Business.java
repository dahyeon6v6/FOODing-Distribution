package com.sw.fd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class Business {
    private String b_no;
    private String start_dt;
    private String p_nm;
}
