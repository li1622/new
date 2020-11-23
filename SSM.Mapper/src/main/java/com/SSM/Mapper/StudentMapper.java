package com.SSM.Mapper;

import java.util.List;

import com.SSM.Entity.Student;
import com.SSM.Util.Page;

public interface StudentMapper {
	
	
	//增加
	public int add(Student student);
	
	//删除
	public void delete(int id);
	
	//根据id回显
	public Student updateById(int id);
	
	//修改
	public void update(Student student);
	
	
	//分页查询
	public List<Student> getPage(Page<Student> page);
	
	//查总数
	public int getCout();
	
	
	public List<Student>  getStudent();
	
	
	
	
}