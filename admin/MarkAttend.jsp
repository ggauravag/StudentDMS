<%@page import="com.login.DBInfo"%>
<%@ page language="java" import="java.util.*, java.sql.*,java.text.*" pageEncoding="ISO-8859-1"%>
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
	
}
catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect("/TechStar/Error.jsp");
}

	String update = "";
 if(request.getParameter("mark")!=null)
 {
 	String[] stid = request.getParameterValues("stid");
 	String param = "";
 	
 	if(stid!=null)
 	{
 	
 	
 	
		 	
		 	for(int i=0; i < stid.length;i++)
		 	{
		 	                  String sql = "{call InsertAttend (?,?,?)}";
						      CallableStatement stmt = con.prepareCall(sql);
						      stmt.setInt(1, Integer.parseInt(stid[i]));
						      if(request.getParameter("date")==null)
						      	stmt.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
						      else
						      {
						      	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
						      	String date = request.getParameter("date");
								java.util.Date d = sdf1.parse(date);
								java.sql.Date sqldob = new java.sql.Date(d.getTime());
						      	stmt.setDate(2, sqldob);
						      }
						      stmt.setString(3, "A-"+request.getRemoteAddr());
						      stmt.execute();
		 	}
		 	
		 	
		 	
		 	
		 	update = "Success";
		 	
	}
	
 }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>.. :: Admin Panel :: ..</title>
    
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
       <legend> <h1>Student Attendance</h1></legend>
        </fieldset>
      
        <label><h3>Date : <%
        if(request.getParameter("date")==null)
        	out.write(new SimpleDateFormat("dd - MMM - yyyy").format(new java.util.Date())); 
        else
        {
        	String date = request.getParameter("date");
        	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date d = sdf1.parse(date);
			
        	out.write(new SimpleDateFormat("dd - MMM - yyyy").format(d));
        }
        %></h3></label>
        <form class="form-horizontal" role="form" action="" method="post">
		  <div>
		  <%
		  	if(update.equals("Success"))
		  	{
		  		%>
        				<div class="alert alert-success" role="alert">
        				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        				<strong>Success !</strong> Attendance of selected students have been marked.</div>
        		<%
		  	}
		  	if(update.equals("Failure"))
		  	{
		  	%>
        				<div class="alert alert-danger" role="alert">
        				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        				<strong>Oh Snap !</strong> There was some error while uploading attendance.</div>
        	<%
		  	
		  	}
		  
		  
		   %>
		  <table class="table table-hover" >
		  <tr>
		  	<th>Select</th>
		  	<th>ID</th>
		  	<th>Name</th>
		  	<th>Father Name</th>
		  	<th>Mobile</th>
		  	<th>Email ID</th>
		  	<th>Sem</th>
		  	<th>Shift</th>
		  	<th>Branch</th>
		  
		  </tr>
		  
		  <%
		  	try
		  	{
		  	String query = "select * from student order by st_name";
		  	PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			ResultSet res1 = null;
			String date = request.getParameter("date");
    		if(date!=null)
    		{
    			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date d = sdf1.parse(date);
				java.sql.Date sqldob = new java.sql.Date(d.getTime());
				String query1 = "select * from attendance where date=?";
				PreparedStatement ps1 = con.prepareStatement(query1);
				ps1.setDate(1,sqldob);
				res1 = ps1.executeQuery();
    		
    		}
			else
			{
				String query1 = "select * from attendance where date=curdate()";
				PreparedStatement ps1 = con.prepareStatement(query1);
				res1 = ps1.executeQuery();
			}
			
			
			ArrayList list = new ArrayList();
			
			while(res1.next())
			{
				list.add(res1.getInt(1));
			}
			
			
			
			while(rs.next())
			{
			%>
			<tr>
			<%
				if(list.contains(rs.getInt(10)))
				{
					%>
					
					<td><input type="checkbox" name="stid" value="<%=rs.getInt(10) %>" disabled checked></td>
					<%
				
				}
				else
				{
					%>
					
					<td><input type="checkbox" name="stid" value="<%=rs.getInt(10) %>"></td>
					<%
				
				}
			
			
			
			 %>
				
				<td><%=rs.getInt(10) %></td>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(7) %></td>
				<td><%=rs.getString(8) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
				
				<td><%=rs.getString(4) %></td>
				
			</tr>
			
			<%
			}
		  	
		  	
		  	
		  	}
		  	catch(Exception e)
			{
				e.printStackTrace();
			}		  
			finally
			{
				con.close();
			}
		  
		  
		   %>
		  
		  
		  
		  </table>
		  <input type="submit" name="mark" value="Upload Attendance" class="col-sm-offset-4 btn btn-lg btn-success">
		  <input type="reset" value="Reset" class="col-sm-offset-1 btn btn-default btn-lg">
		  </div>
	</form>
         
        </p>
      </div>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>
  
</html>
