package com.SSM.Entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

public class Student {
	private Integer id;//id
	private String name;//姓名
	private String headPath;//
	private int sex;//
	private int age;//
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date date;//
	private Float salary;//
	
	private Classs classs;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public String getHeadPath() {
		return headPath;
	}


	public void setHeadPath(String headPath) {
		this.headPath = headPath;
	}


	public int getSex() {
		return sex;
	}


	public void setSex(int sex) {
		this.sex = sex;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}


	public Float getSalary() {
		return salary;
	}


	public void setSalary(Float salary) {
		this.salary = salary;
	}
	
	@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
	public Classs getClasss() {
		return classs;
	}

	public void setClasss(Classs classs) {
		this.classs = classs;
	}
	

	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", headPath=" + headPath + ", sex=" + sex + ", age=" + age
				+ ", date=" + date + ", salary=" + salary + ", classs=" + classs + "]";
	}
	
}