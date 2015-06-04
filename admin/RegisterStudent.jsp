<%@page import="com.login.SendMail"%>
<%@page import="com.login.SmsLane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con = DBInfo.getConn();
boolean isAdmin = false;
try
{
	String type = (String)session.getAttribute("type");
	if(type != null && type.equals("admin"))
	{
		isAdmin = true;
	
	}
	else
	{
		response.sendRedirect("/TechStar/Unauthorize.jsp");
	}
	
}
catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect("/TechStar/Error.jsp");
}






String isSuccess = "";
try
{
	if(request.getParameter("register")!=null)
	{
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String branch = request.getParameter("branch");
		String sem = request.getParameter("sem");
		String dob = request.getParameter("dob");
		String shift = request.getParameter("shift");
		String father = request.getParameter("father");
		String name = request.getParameter("fname");
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = sdf1.parse(dob);
		java.sql.Date sqldob = new java.sql.Date(date.getTime());
		
		
		String query = "insert into student(st_name,dob,f_name,branch,semester,shift,mobile,email,address) values(?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1,name);
		ps.setDate(2,sqldob);
		ps.setString(3,father);
		ps.setString(4,branch);	
		ps.setString(5, sem);
		ps.setString(6, shift);
		ps.setString(7, mobile);
		ps.setString(8, email);
		ps.setString(9, address);
		
		String pass = "";
		String values = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ1234567890";
		Random r = new Random();
		
		for(int i = 0; i < 6;i++)
		{
			pass = pass + values.charAt(r.nextInt(60));
		}
		
		
		
		int result = ps.executeUpdate();
		if(result == 1)
		{
			  isSuccess = "true";
			  String sql = "{call InsertLogin (?,?,?)}";
		      CallableStatement stmt = con.prepareCall(sql);
		      stmt.setString(1, email);
		      stmt.setString(2, pass);
		      stmt.setString(3, mobile);
		      stmt.execute();
		      
		       String mess = "Dear " + name.split(" ")[0] + ", you are now registered at Tech-Star Portal.";
                mess += "\nLogin ID : " + email + "\n";
                mess += "Password : " + pass + "\nNever share your password.";
                mess += "\n- Tech Innova Club";
                
               if(mess.length() >= 160)
               {
               		mess = "Dear " + name.split(" ")[0] + ", you are now registered at Tech-Star Portal.";
	                mess += "\nLogin ID : " + email + "\n";
	                mess += "Password : " + pass + "\n";
	                mess += "\n- Tech Innova Club";
               }
                
                SmsLane.sendSMS(mobile, mess);
                SendMail.sendWelcome(name, email, pass);	
		}
		else
		{
			isSuccess = "false";
		}
		
	
	}
	
	
}
catch(Exception e)
{
	isSuccess = "false";
	e.printStackTrace();
}
finally
{
	con.close();
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Student Registration</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
	function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
        
        function redirect()
        {
        <%
        	if(isSuccess.equals("true"))
        	{
        	
        	%>
        	
        	alert("Student has been successfully registered !");
        	<%
        	}
        	else if(isSuccess.equals("false"))
        	{
        	%>
        	alert("Duplicate Entry for student !");
        	<%
        	
        	}
        %>
            
            window.location = "<%=basePath%>admin/Home.jsp";
        }

        setTimeout("redirect()", 0);
	</script>

  </head>
  
  <body>
    
  </body>
</html>
