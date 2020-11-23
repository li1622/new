package com.SSM.Dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.SSM.Entity.Student;
import com.SSM.Mapper.StudentMapper;
import com.SSM.Util.Page;

@Repository
public class StudentDao {
	@Autowired
	private StudentMapper studentMapper;
 
public void  getPage(Page<Student> page) {
	int sum=studentMapper.getCout();
	
	int cou=((page.getPageNo()-1)*page.getPageSize());
	//int cou1=cou +1;
	page.setStart(cou);
	page.setSum(sum);
	List<Student> list=studentMapper.getPage(page);
	page.setList(list);
}

public int addStudent(Student student) {
	studentMapper.add(student);
	return student.getId();
}

public void deleteStudent(int id) {
	studentMapper.delete(id);
}

public Student getById(int id) {
	Student student =new Student();
	student= studentMapper.updateById(id);
	return student;
}

public Student updateStudent(Student student) {
	studentMapper.update(student);
	return student;
}

public List<Student> getStudent(){
	List<Student> student= studentMapper.getStudent();
	
	return student;
}

}