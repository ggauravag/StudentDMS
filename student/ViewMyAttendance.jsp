<%@ page language="java" import="java.util.*,java.sql.*,com.login.*" pageEncoding="ISO-8859-1"%>
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
          <a class="navbar-brand">Tech Innova Club </a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li ><a href="student/Home.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;Home</a></li>
          
           
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
       <legend> <h3>My Attendance</h3></legend>
        </fieldset>
        <form class="form-horizontal" role="form" action="" method="post">
		  <div class="form-group">
		  <table class="table table-hover">
		  <tr>
		  
		  	<th>Attendance Status</th>
		  	<th>Date Of Attendance</th>
		  
		  
		  </tr>
		    <%
		    	int sid = Integer.parseInt(String.valueOf(session.getAttribute("id")));
		    	
		    	
			    	
			    	String query = "select * from attendance where id=?";
			    	PreparedStatement ps = con.prepareStatement(query);
			    	ps.setInt(1, sid);
			    	
			    	
			    	ResultSet res = ps.executeQuery();
			    	while(res.next())
			    	{
			    		%>
			    			<tr>
			    				<td><%=res.getString(2) %></td>
			    				<td><%=res.getDate(3) %></td>
			    			</tr>
			    		<% 
			    	}
		    	
		    	
		     %>
		     </table>
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