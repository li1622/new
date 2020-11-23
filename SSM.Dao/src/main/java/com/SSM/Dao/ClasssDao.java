package com.SSM.Dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.SSM.Entity.Classs;
import com.SSM.Mapper.ClasssMapper;

@Repository
public class ClasssDao{
	@Autowired
	private ClasssMapper classsMapper;
	  
	
	public List<Classs> getClasss(){
		List<Classs> list=classsMapper.getClasss();
		return list;
	}

	
	
}
