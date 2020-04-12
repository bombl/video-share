package com.asimple.entity;

import java.io.Serializable;

/**
 * @ProjectName video
 * @description 年份实体类
 * @author Asimple
 */
public class Decade implements Serializable {
    /**
     * 主键id
     */
    private String id;
    /**
     * 是否在使用
     */
    private int isUse;
    /**
     * 名称
     */
    private String name;

    public Decade() {
    }

    public Decade(int isUse, String name) {
        this.isUse = isUse;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getIsUse() {
        return isUse;
    }

    public void setIsUse(int isUse) {
        this.isUse = isUse;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Decade{" +
                "id='" + id + '\'' +
                ", isUse=" + isUse +
                ", name='" + name + '\'' +
                '}';
    }
}
