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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Student Panel :: Tech Innova Club</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  
   

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/navbar-fixed-top.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="./js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="./js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>

 <body>

    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" >Tech Innova Club </a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="student/Home.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;Home</a></li>
          
           
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span>&nbsp;My Account <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="student/ViewProfile.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;View Personal Details</a></li>
               
                <li><a href="#"></a></li>
                <li class="divider"></li>
                <li class="dropdown-header">Attendance</li>
                <li><a href="student/Home.jsp"><span class="glyphicon glyphicon-ok"></span>&nbsp;Mark Attendance</a></li>
                <li><a href="student/ViewMyAttendance.jsp"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;View My Attendance</a></li>
                
              </ul>
            </li>
            
            <li ><a href="student/AttemptTest.jsp"><span class="glyphicon glyphicon-pencil"></span>&nbsp;Attempt Test</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
           <li><a style="color: blue">Welcome ! <%=session.getAttribute("name") %></a></li>
            <li><a href="Logout.jsp"><span class="glyphicon glyphicon-off"></span>&nbsp;Log Out</a></li>
          
           
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
      <fieldset>
       <legend> <h2>Mark Attendance</h2></legend>
        </fieldset>
        <form class="form-horizontal" role="form" action="" method="post">
		  <div class="form-group">
		    <%
		    	int sid = Integer.parseInt(String.valueOf(session.getAttribute("id")));
		    	//System.out.println("the session id is : "+session.getAttribute("id"));
		    	if(request.getParameter("attend")!=null)
		    	{
		    		  String sql = "{call InsertAttend (?,?,?)}";
				      CallableStatement stmt = con.prepareCall(sql);
				      stmt.setInt(1, sid);
				      stmt.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
				      stmt.setString(3, request.getRemoteAddr());
				      stmt.execute();
				      response.sendRedirect("Home.jsp");
				      %>
			    		<input type="submit" name="attend" class="btn btn-lg btn-primary col-sm-offset-5" value="Your attendance is marked" disabled>
			    	  <% 

		    	}
		    	else
		    	{
			    	
			    	String query = "select * from attendance where id=? and date=?";
			    	PreparedStatement ps = con.prepareStatement(query);
			    	ps.setInt(1, sid);
			    	java.util.Date d = new java.util.Date();
			    	java.sql.Date sqldate = new java.sql.Date(d.getTime());
			    	ps.setDate(2, sqldate);
			    	//System.out.println(ps);
			    	ResultSet res = ps.executeQuery();
			    	if(res.next()) 
			    	{
			    	%>
			    		<input type="submit" name="attend" class="btn btn-lg btn-primary col-sm-offset-5" value="Your attendance is marked" disabled>
			    	<% 
			    	}
			    	else
			    	{
			    	%>
			    		<input type="submit" name="attend" class="btn btn-lg btn-success col-sm-offset-5" value="Mark Attendance">
			   		<%
			    	}
		    	
		    	}
		     %>
		  </div>
		  
	</form>
         
        </p>
        <div>
        	<fieldset>
        	<legend><h2>Give Feedback</h2></legend>
        	<%
        		if(request.getParameter("feed")!=null)
        		{
        			String q = "insert into feedback values(?,?,?)";
        			PreparedStatement pes = con.prepareStatement(q);
        			pes.setInt(1, sid);
        			pes.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
        			pes.setString(3, request.getParameter("feedback"));
        			int i = pes.executeUpdate();
        			if(i==1)
        			{
        			%>
        				<div class="alert alert-success" role="alert">
        				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        				<strong>Great !</strong> Your feedback has been successfully submitted.</div>
        				<%
        			}
        			else
        			{
        			%>
        				<div class="alert alert-danger" role="alert">
        				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        				<strong>Oh Snap !</strong> There was some error while submitting feedback.</div>
        			<%
        			}
        		
        		}
        	
        	 %>
        	</fieldset>
        	<form class="form-horizontal" role="form" action="" method="post">
		  <div class="form-group">
		  
		   <textarea class="form-control" maxlength="495" name="feedback" rows="4"  placeholder="Write down your experience, like which topics were clearly understood by you, and which are not yet clear. Give feedback about pace of teaching, is it fast ?" required="true" ></textarea>
		  
		  </div>
		  <div class="form-group">
		  
		  <input type="submit" name="feed" class="btn btn-lg btn-success col-sm-offset-4" >
		  <input type="reset" class="btn btn-lg btn-default col-sm-offset-2">
	  </div>
		  </form>
        
        
        </div>
        
        
      </div>

    </div> <!-- /container -->
	<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
		response.sendRedirect("/TechStar/Error.jsp");
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

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>
    
    
  </body>
</html>
