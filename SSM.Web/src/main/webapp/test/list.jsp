<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/serializeObject.js"></script> 
<script type="text/javascript">
	
	$(function(){
		query(1);
		getClasss();
		 
		//新增
		$("#addButton").click(function(){
			  var formData = new FormData();//这里需要实例化一个FormData来进行文件上传
				formData.append("file",$("#head")[0].files[0]);	
				//序列化表单不会序列化file字段.
				var student = $("#addForm").serializeObject();
				//把json转换成formdate
			 	Object.keys(student).forEach((key) =>{
					formData.append(key, student[key]);
				});
			
			    $.ajax({
			    	url:"<%=request.getContextPath()%>/addStu",
			    	type:"post",
			    	dateType:"json",
			    	data:formData,
			    	processData: false,//默认true,会转换成字符串,因为我们需要提交流,所以不能使用True
	                contentType: false,//这个必须有，不然会报错
			    	success:function(idObject)
			    	{
			    		$("#table").append("<tr><td>"+idObject.id+"</td><td>"+student.name+"</td><td><img  alt='无' src='fileX?headPath="+idObject.headPath+"' height='50px' weight='50px'</td><td>"+student.sex+"</td><td>"+student.age+"</td><td>"+student.date+"</td><td>"+student.salary+"</td><td>"+student.classs+"</td><td><a class='update' href='emp/"+idObject.id+"'>修改</a></td><td><a class='delete' href='emp/"+idObject.id+"'>删除</a></td></tr>");
			    		$("#addDiv").hide();
			    		cal();//清空新增框里面的值
			    		query(1);
			    		up();
			    	},
			    	error:function(){
			    		alert("发生错误");
			    	}
			    });
			});	
		
	  	function deletee(){
	 		 $(".delete").click(function(){
	 			 var Httpurl=$(this).attr("href");
	 			 var tr=$(this).parent().parent();
	 		   $.ajax({
	 		    	url:Httpurl,
	 		    	type:"delete",
	 		    	//date:{"_method":"DELETE"},
	 		    	dataType:"text",
	 		    	success:function(result)
	 		    	{
	 		    		 tr.remove();
	 				    	query(1);
	 		    	},
	 		    	error:function(){
	 		    		alert("发生错误");
	 		    	}
	 		    });
	 			return false;
	 		});
	 	}
	  	
	  	//把新增的div出来
	  	$("#addUser").click(function(){
	  		$("#addDiv").show();
	  		$("#addButton").show();
			$("#calUser").show();
	  		$("#updateButton").hide();
	  		$("#calUpdate").hide();
	  	});
	  	
	  	//隐藏新增的div
	  	$("#calUser").click(function(){
			$("#addDiv").hide();
			cal();//清空新增框里面的值
		});
	  	//取消修改
	  	$("#calUpdate").click(function(){
			$("#addDiv").hide();
		})
	  	
	  	//清空新增里面的值
	  	function cal()
		{
			$("#name").val("");
			$("#headPath").val("");
			$("#age").val("");
			$("#date").val("");
			$("#salary").val("");
			$("input[type='radio'][name='sex']").each(function(){
				$(this).prop("checked",false);
			});
			
			$("#classId").val("一班");
		}
	  	
	  	function up(){
	  	//修改回显
	  	 $(".update").click(function(){
			 var updateUrl = $(this).attr("href");
				$("#addDiv").show();
				$("#updateButton").show();
		  		$("#calUpdate").show();
				$("#addButton").hide();
				$("#calUser").hide();
				//通过ID查询对要修改的对象,进行数据回显
				 $.ajax({
				    	url:updateUrl,
				    	type:"get",
				    	dataType:"json",
				    	success:function(stu)
				    	{
				    		$("#id").val(stu.id);//修改,是根据ID来修改
				    		$("#name").val(stu.name);
				    		$("#age").val(stu.age);
				    		var head= "fileX?headPath="+stu.headPath;
				    		//$("#updateSex").val(user.sex);
				    		$("#po").attr('src',head);
				    		$(":radio[name='sex'][value="+stu.sex+"]").prop("checked",true);
				    		$("#date").val(stu.date);
				    		$("#salary").val(stu.salary);
				    		$("select option[value='"+stu.classs.id+"']").prop("selected",true);
				    	},
				    	error:function(){
				    		alert("发生错误");
				    	}
				    });
				return false;
		 });
	  	 
	  	 
	  	 
	  	$("#updateButton").click(function(){
	  	  var formData = new FormData();//这里需要实例化一个FormData来进行文件上传
			formData.append("file",$("#head")[0].files[0]);	
			//序列化表单不会序列化file字段.
			var student = $("#addForm").serializeObject();
			//把json转换成formdate
			Object.keys(student).forEach((key) =>{
				//alert(key   +"   "+student[key])
				formData.append(key, student[key]);
			});
				 $.ajax({
				    	url:"<%=request.getContextPath()%>/empUpdate",
				    	type:"put",
				    	dateType:"json",
				    	data:formData,
				    	processData:false,//默认true,会转换成字符串,因为我们需要提交流,所以不能使用True
		                contentType:false,//这个必须有，不然会报错
				    	success:function(stu)
				    	{
				    		$("#table tr").find("td:eq(0)").each(function(){
								if($(this).text() == stu.id)
								{
									$(this).parent().find("td:eq(1)").text(stu.name);
									$(this).parent().find("td:eq(2)").html("<img alt='头像' width=50 height=50 src='fileX?headPath="+stu.headPath+"'>");
									$(this).parent().find("td:eq(3)").html((stu.sex==1?'男':'女'));
									$(this).parent().find("td:eq(4)").text(stu.age);
									$(this).parent().find("td:eq(5)").text(stu.date);
									$(this).parent().find("td:eq(6)").text(stu.salary);
									$(this).parent().find("td:eq(7)").text(stu.classs.classsName);
								}
							});
				    		$("#addDiv").hide();
				    		cal();
				    	},
				    	error:function(){	
				    		alert("发生错误");	
				    	}
				    });
			});
	  	}
	  	
	  	function query(pageNo)
	  	{
	  		var pageSize =$("#pageSize").val();
	  		 $.ajax({
				 url:"query",
				 dataType:"json",
				 type:"get",
				 data:{"pageSize":pageSize,"pageNo":pageNo},
				 success:function(page){ 
					 
					 $("#pageSize").val(page.pageSize);
					 $("#pageNo").val(page.pageNo);
					 $("#pageCount").val(page.pageCount);
					 $("#sum").val(page.sum);
					 $("#ps").val(page.pageSize);
					 $("#a").text(page.pageSize);
					 $("#b").text(page.pageNo);
					 $("#c").text(page.pageCount);
					 
					 if(page.pageNo ==page.pageCount){
						 $("#down").css("backgroun-color","gray");
					 }else{
						 $("#down").css("background-color","")
					 }
					 if(page.pageNo ==1){
						 $("#up").css("background-color","gray");
					 }else{
						 $("#up").css("background-color","");
					 }
					 $("#table").empty();//清空
					 $("#table").append("<tr><td>id</td><td>名字</td><td>头像</td><td>性别</td><td>年龄</td><td>时间</td><td>工资</td><td>班级</td><td>修改	</td><td>删除</td></tr>");
					 var stu = page.list;
					for(var i = 0;i<stu.length;i++){
						$("#table").append("<tr><td>"+stu[i].id+"</td><td>"+stu[i].name+"</td><td><img width=50px height=50px alt='头像' src='fileX?headPath="+stu[i].headPath+"'></td><td>"+(stu[i].sex==1?'男':'女')+"</td><td>"+stu[i].age+"</td><td>"+stu[i].date+"</td><td>"+stu[i].salary+"</td><td>"+stu[i].classs.classsName+"</td><td><a class='update' href='emp/"+stu[i].id+"'>修改</a></td><td><a class='delete' href='emp/"+stu[i].id+"'>删除</a></td></tr>");
						}
					deletee();
					up();
				 },
				 error:function(){
					 alert("失败");
				 }
	  		 });
	  		return false; 
	  	}
	  //首页
		$("#first").click(function() {
	 		query(1);
		}); 

		//尾页
		$("#last").click(function() {
			//获取最后一页
			var count = $("#pageCount").val();
			query(count);
		});

		//上页
	 	$("#up").click(function() {
			var pageNo = $("#pageNo").val();
			if (pageNo != "1")
			{
				query(parseInt(pageNo) - 1);
			}
	 	});

		//下页
	 	$("#down").click(function() {
			var pageNo = $("#pageNo").val();
			var pageCount = $("#pageCount").val();
			if (pageNo != pageCount) {
				query(parseInt(pageNo) + 1);
			}
		}); 
		//改变每页显示多少条记录
		$("#ps").change(function() {
			var pageSize = $("#ps").val();//获取下拉框选中的值
			$("#pageSize").val(pageSize);
			query(1);
		});
	  	
		
		function getClasss(){
			$("select[name='classs.id']").empty();
			//$("#classs.id").empty();
			$.ajax({
				url:"classs",
				dataType:"json",
				success:function(classs){
					for (var i = 0; i < classs.length; i++) {
						var cla=classs[i];
						$("select[name='classs.id']").append("<option value ="+cla.id+">"+cla.classsName +"</option>");
					}
				},
				error:function(){
				alert("失败");
				}
			});
		}
	});
</script>
</head>
<body>
	<!-- 分页一页多少 -->
	<input type="hidden" name="pageSize" id="pageSize" value="5">
	<input type="hidden" name="pageNo" id="pageNo">
	<input type="hidden" name="pageCount" id="pageCount">
	<input type="hidden" name="sum" id="sum">
	<select id="cutZhEn">
		<option value="zh_CH">中文</option>
		<option value="en_US">英文</option>
	</select>
		<table border="1"  cellpadding="10" cellspacing="0" id="table">
			<tr>
				<th><fmt:message key="i18n.id"></fmt:message></th>
				<th><fmt:message key="i18n.aaa"></fmt:message></th>
				<th><fmt:message key="i18n.headPath"></fmt:message></th>
				<th><fmt:message key="i18n.sex"></fmt:message></th>
				<th><fmt:message key="i18n.age"></fmt:message></th>
				<th><fmt:message key="i18n.time"></fmt:message></th>
				<th><fmt:message key="i18n.salary"></fmt:message></th>
				<th><fmt:message key="i18n.bang"></fmt:message></th>
				<th><fmt:message key="i18n.compile"></fmt:message></th>
				<th><fmt:message key="i18n.delete"></fmt:message></th>
			</tr>
		</table>
		<input type="button"  id="addUser"  value="新增"/>
		<br>
	每页<span style="color: red" id="a"></span>条 &nbsp;&nbsp;&nbsp;
	第<span style="color: red" id="b"></span>页&nbsp;&nbsp;&nbsp;
	总共<span style="color: red" id="c"></span>页&nbsp;&nbsp;&nbsp;
	<br>
		<input type="button" id="first" value="首页">
		<input type="button" id="up" value="上页">
		<input type="button" id="down" value="下页">
		<input type="button" id="last"  value="尾页">
	<select id="ps">
		<option value="5">5</option>
		<option value="4">4</option>
		<option value="3">3</option>
		<option value="2">2</option>
		<option value="1">1</option>
	</select>条数据 
		
		
		
		<div id="addDiv"  style="display: none;">
	<!-- 修改回显图片 -->
		<img width="40" height="60" alt="" src="" id="po">
		<form id="addForm" >
			<input type="hidden" name="id" id="id">
		姓名:<input type="text" name="name" id="name" ><br>
		
		头像:<input type="file" name="file" id="head" >
	 	<br>
		
		性别:
			<input type="radio" name="sex" value="0">女
			<input type="radio" name="sex" value="1">男
		<br>
		
			年龄:<input type="text" name="age" id="age" ><br>
		
		生日:<input type="text" name="date" id="date"  onClick="WdatePicker()" ><br>
		
		工资：<input type="text" name="salary" id="salary" ><br>
		
		班级:<select  id="classs.id" name="classs.id">
		
		</select>
		<br>
		
		<input type="button" value="新增" id="addButton">
		<input type="button" value="取消新增" id="calUser">
		<input type="button" value="修改" id="updateButton">
		<input type="button" value="取消修改" id="calUpdate">
		</form>
	</div>
	
  
		
</body>
</html>