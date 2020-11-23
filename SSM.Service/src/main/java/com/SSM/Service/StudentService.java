package com.SSM.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.SSM.Dao.StudentDao;
import com.SSM.Entity.Student;
import com.SSM.Util.Page;

@Service
public class StudentService{
	@Autowired
	private StudentDao studentDao;
	
	
	@Transactional
	public void query(Page<Student>page) {
		studentDao.getPage(page);
	}
//	@Transactional
//	public List<Student> getStudentAll() {
//		
//		
//		List<Student>list =studentDao.getStudent();
//		return list;
//	}
	
	//添加
	@Transactional
	public int add(Student student) {
		
		//int id=studentDao.add(student);
		//.getId();
		studentDao.addStudent(student);
		return  student.getId();
		
	}
	//删除
	@Transactional
	public void delete(int id) {
		studentDao.deleteStudent(id);
	}
	//跟id回显修改
	@Transactional
	public Student updateById(int id) {
		return studentDao.getById(id);
	}
	//修改
	 @Transactional
	public void update(Student student) {
		studentDao.updateStudent(student);
	}

	 @Transactional
		public List<Student> getStudent() {
			List<Student> student= studentDao.getStudent();
			return student;
		}
	 
}
