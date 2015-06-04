<%@ page language="java" import="java.util.*,java.sql.*,com.login.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	boolean isAdmin = false;
	Connection con = DBInfo.getConn();
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
		
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>:: Admin Panel ::</title>
    
	
	<!--
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
            <li ><a href="admin/Home.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;Home</a></li>
          
           
              <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;Manage Student <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="admin/Home.jsp"><span class="glyphicon glyphicon-file"></span>&nbsp;&nbsp;Register Student</a></li>
                <li><a href="admin/StudentRecord.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;View Students</a></li>
                <li><a href="admin/ViewFeedback.jsp"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;View Feedback</a></li>
                 <li><a href="admin/ClickPhoto.jsp"><span class="glyphicon glyphicon-camera"></span>&nbsp;&nbsp;Click Photo</a></li>
                <li><a href="#"></a></li>
                <li class="divider"></li>
                <li class="dropdown-header">Attendance</li>
                <li><a href="admin/ViewClass.jsp"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;View Class Attendance</a></li>
                <li><a href="admin/MarkAttend.jsp"><span class="glyphicon glyphicon-ok"></span>&nbsp;&nbsp;Mark Attendance</a></li>
              <li><a href="#"></a></li>
                <li class="divider">&nbsp;n</li>
              <li class="dropdown-header">Exams</li>
              <li><a href="admin/RankList.jsp"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;View Rank List</a>
              <li><a href="admin/ManageExam.jsp"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Manage Exams</a></li>
              </ul>
            </li>
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
       <legend> <h3>Exam Details</h3></legend>
        </fieldset>
        <form class="form-horizontal" role="form" action="" method="post">
		  <div>
		  <table class="table table-hover">
		 	<tr>
		 		<th>Exam Name</th>
		 		<th>Date</th>
		 		<th>Status</th>
		 		<th>Enable</th>
		 		<th>Disable</th>
		 		
		 	</tr>
		  
		  <%
		  
		  if(request.getParameter("enable")!=null)
		  {
		  	String query = "update exam set enable = 'Y',time=now(),`date`= now() where exam_name = ?";
		  	PreparedStatement ps = con.prepareStatement(query);
		  	ps.setString(1, request.getParameter("enable"));
		  	int j = ps.executeUpdate();
		  	response.sendRedirect("/TechStar/admin/ManageExam.jsp");
		  }
		  else if(request.getParameter("disable")!=null)
		  {
		  	String query = "update exam set enable = 'N',time=now(),`date`= now() where exam_name = ?";
		  	PreparedStatement ps = con.prepareStatement(query);
		  	ps.setString(1, request.getParameter("disable"));
		  	int j = ps.executeUpdate();
		  	response.sendRedirect("/TechStar/admin/ManageExam.jsp");
		  	return;
		  }
		  else
		  {
		  
		  }
		  	
		  	
		  
		  	String query = "select * from exam";
		  	PreparedStatement ps = con.prepareStatement(query);
		  
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
			%>
			<tr>
				
				
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getDate(4) %></td>
				<td><%=rs.getString(3) %></td>
				
				<td><input class="btn btn-success" type="submit" name="enable" value="<%=rs.getString(1)%>"></td>
				<td><input class="btn btn-danger" type="submit" name="disable" value="<%=rs.getString(1)%>"></td>
				
				
			</tr>
			
			<%
			}
		  	
		  	
		  	
		  	
		  
		  
		   %>
		  
		  
		  
		  </table>
		  
		  
		  </div>
		  <div>
		 
		  </div>
		  
		  
		  
	</form>
         
        </p>
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
		con.close();
	}



 %>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>

</html>

