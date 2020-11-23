package com.SSM.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.SSM.Dao.ClasssDao;
import com.SSM.Entity.Classs;

@Service
public class ClasssService {
	@Autowired
	private ClasssDao classsDao;
	
	@Transactional
	public List<Classs> getClasss(){
		return classsDao.getClasss();
	}
}
