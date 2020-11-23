package com.SSM.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.SSM.Entity.Classs;
import com.SSM.Entity.Student;
import com.SSM.Service.ClasssService;
import com.SSM.Service.StudentService;
import com.SSM.Util.Page;

@SessionAttributes(value = {"locale"})
@Controller("studentController")
public class StudentController {
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private ClasssService classsService;
	/**
	 * 修改时查询对象 把没有修改的字段进行覆盖
	 * @param id
	 * @param map
	 */
	@ModelAttribute
	public void getEmployee(@RequestParam(value="id",required=false) Integer id,Map<String, Object> map){
		if(id != null){
			map.put("student", studentService.updateById(id));
		}
	}
//	/**
//	 * 查询
//	 * @param map
//	 * @return
//	 */
//	 @ResponseBody
//	@RequestMapping(value = "/studentList")
//	public List<Student> get(Map<String, Object>map,Locale locale){
//		 return studentService.getStudentAll();
//	}
	 
	 /**
	  * 分页查询
	  */
	 
	 @ResponseBody
		@RequestMapping(value = "/query",method=RequestMethod.GET)
		public Page<Student> query(Page<Student> page){
			  studentService.query(page);
			  return page;
		}
	 
	/**
	 * 删除
	 * @param id
	 * @return 
	 */
	 @ResponseBody
	@RequestMapping(value="/emp/{id}", method=RequestMethod.DELETE)
	public String delete(@PathVariable("id") Integer id){
		studentService.delete(id);
		return "删除成功";
	}
	
//	/**
//	 * 查询所有班级
//	 * @param map
//	 * @return
//	 */
//	@RequestMapping( value = "/emp",method=RequestMethod.GET)
//	public String add(Map<String, Object>map) {
//		Map<String,String> sex=new HashMap<>();		
//		sex.put("1","男");
//		sex.put("0","女");	
//		map.put("sex1", sex);		
//			
//		map.put("student", new Student());
//		return "input";
//	}
	/**
	 * 添加
	 * @param student
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/addStu", method=RequestMethod.POST)
	public Student save( @RequestParam("file") MultipartFile file,Student student )throws Exception{
		 
			InputStream inputStream = file.getInputStream();	 	 
			String headName= System.currentTimeMillis()+".jpg";
			// 输出流,保存文件的
			OutputStream out = new FileOutputStream(new File("D:\\worksp\\\\SpringMVC\\spring-springmvc\\WebContent\\abc\\"+headName));
			byte b[] = new byte[1024 * 1024 * 10];
			int i = inputStream.read(b);
			while (i != -1) {
				out.write(b, 0, i);
				i = inputStream.read(b);
			}	
			  out.close();
			  inputStream.close();
			  //将文件名放入head
			 // map.put("locale", locale)
			student.setHeadPath(headName);
			int id= studentService.add(student);
			String jsonStr="{\"id\":"+id+"}";
			return  student;
	}
	
	@ResponseBody
	@RequestMapping(value="/classs")
	public List<Classs> getClasAll(){
		return classsService.getClasss();
	}
	
	/**
	 * 修改 回显
	 * @param id
	 * @param map
	 * @return
	 */
	 @ResponseBody
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	public Student inpua(@PathVariable("id") Integer id, Map<String, Object> map){
		 Student student= studentService.updateById(id);
		 return student;
	}
	
	/**
	 * 修改
	 * @param student	
	 * @return
	 */
	 @ResponseBody
	@RequestMapping(value="/empUpdate", method=RequestMethod.PUT)
	public Student update(@RequestParam("file") MultipartFile file,@Valid Student student)throws Exception{
			InputStream inputStream = file.getInputStream();
			String headName= System.currentTimeMillis()+".jpg";
			// 输出流,保存文件的
			OutputStream out = new FileOutputStream(new File("D:\\worksp\\SpringMVC\\spring-springmvc\\WebContent\\abc\\"+headName));
			
			byte b[] = new byte[1024 * 1024 * 10];
			int i = inputStream.read(b);
			while (i != -1) {
				out.write(b, 0, i);
				i = inputStream.read(b);
			}
			  out.close();
			  inputStream.close();
			  //将文件名放入head
			student.setHeadPath(headName);
			studentService.update(student);
			return studentService.updateById(student.getId());
	}
	
	
	/**
	 * 文件下载    有限制   超出一定的m就会报错
	 * @param session
	 * @param headName
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "fileX")
	public ResponseEntity<byte[]> testResponseEntity(HttpSession session,@RequestParam("headPath") String headName) throws IOException {
		String headPath="D:\\worksp\\SpringMVC\\spring-springmvc\\WebContent\\abc\\"+headName;
			byte[] body = null;
			// 获取当前项目的路径
			// InputStream in = servletContext.getResourceAsStream("/files/abc.txt");

			InputStream in=new FileInputStream(new File(headPath)); 
	
			body = new byte[in.available()];
			in.read(body);
	
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Disposition", "attachment;filename="+headName.split("\\\\")[+headName.split("\\\\").length-1]);
	
			HttpStatus statusCode = HttpStatus.OK;
	
			ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(body, headers, statusCode);
			return response;
		}
}