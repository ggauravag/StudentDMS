<%@page import="java.sql.ResultSet"%>
<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	
	boolean isStudent = false;
	Connection con = DBInfo.getConn();
	int id = 0;
	try
	{
		String type = (String)session.getAttribute("type");
		if(type != null && type.equals("student"))
		{
			isStudent = true;
		
		}
		else
		{
			response.sendRedirect("/TechStar/Unauthorize.jsp");
		}
%>	

<!DOCTYPE html>
<html lang="en">
  
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="./favicon.ico">

    <title>Test Panel :: Tech Innova Club</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../css/dashboard.css" rel="stylesheet">

    <script src="../js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../js/ie10-viewport-bug-workaround.js"></script>

    
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Tech Innova Club</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Welcome ! <%=session.getAttribute("name") %></a></li>
          </ul>
          
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#"> <span class="glyphicon glyphicon-star"></span> &nbsp;INSTRUCTIONS </a></li>
            
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">Performance Assessment Test</h1>
		    <br>
		    <li> <h4>This is a Performance Assessment Test. It will not have any effect on your Certificate Of Participation. </h4></li>
			<li> <h4>This test will be of 15 minutes in duration. </h4></li>
			<li> <h4>It will be comprising of two sections (1) Normal Edition (2) Hacker's Edition </h4></li>
			<li> <h4>Only those students who will be able to qualify in Normal Edition will take Hacker's Edition</h4></li>
			<li> <h4>There would be 15 questions in Normal Edition </h4></li>
			<li> <h4>Each Question will carry equal weightage. </h4></li>
			<li> <h4><strong>Please do not take mouse out of <u><i>test window</i></u>, else you will be noticed by System & disqualified from test.<strong></strong> </h4></li>
			<li> <h4>Please do not press any key, use only mouse to select any option. </h4></li>
			<li> <h4><strong>Every question is <u><i>compulsory to attempt</i></u> & hence there will be no <u><i>negative marking</i></u>. </strong></h4></li>
          
		  
		<form class="form-horizontal" role="form"><br><br>
		<%
			String query = "select * from result where exam_name = ? and st_id = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, "PAE-Normal:1");
			ps.setInt(2,(Integer)session.getAttribute("id"));
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
			%> <input type="checkbox" id="agree" onchange="enable(this.id)" disabled><%
			}
			else
			{
				query = "select * from exam where exam_name = 'PAE-Normal:1'";
				ps.close();
				ps = con.prepareStatement(query);
				ResultSet res = ps.executeQuery();
				if(res.next() && res.getString(3).equals("N"))
				{
				%><input type="checkbox" id="agree" onchange="enable(this.id)" disabled><%
				
				}
				else
				{
				
				%><input type="checkbox" id="agree" onchange="enable(this.id);"><%
				}
			}
		 %>
		
		I have read the instructions carefully and I am ready to take test.
		
			<br><br><button class="btn btn-lg btn-success col-sm-offset-4" id="agreebtn" type=button name="continue" onclick="startTest()" disabled>Start Test</button>
		</form>
        </div>
		
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript">
    function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
    
    
    function enable(cboxid)
    {
    	var cbox = document.getElementById(cboxid);
    	//alert("Function call ")
    	if(cbox.checked == true)
    	{
    		//alert("Checkbox selected")
    		document.getElementById("agreebtn").disabled = false;
    	}
    	else
    	{
    		//alert("Checkbox deselected")
    		document.getElementById("agreebtn").disabled = true;
    	}
    }
    
    var win;
    function startTest()
    {
    	//alert("Screen width is : "+screen.width)
    	win = window.open("/TechStar/student/Test.jsp","_blank","width="+screen.width+",height="+screen.height+"");
    	myInterval = window.setInterval("checkWindow()",0);
    }
    
    function checkWindow()
    {
    	if(win.closed)
    	{
    		alert("Your Test is over ! Thanks for attempting and wait for your detailed result.")
    		window.clearInterval(myInterval);
    		window.location="<%=basePath%>"+"student/TestResult.jsp";
    	}
    }
    
    
    
    </script>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/docs.min.js"></script>
  </body>
<%
	
	}
	catch(Exception e)
	{
	
		e.printStackTrace();
	}
	finally
	{
	  if (con != null)
	  {
	     try 
	     { 
	     	con.close(); 
	     } 
	     catch (Exception e) 
	     { 
	     	e.printStackTrace();
	     } 
	  }
	}


 %>
</html>