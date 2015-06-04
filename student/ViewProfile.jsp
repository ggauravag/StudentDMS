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
		
		int sid = Integer.parseInt(String.valueOf(session.getAttribute("id")));
		
		if(request.getParameter("register")!=null)
		{
			if(request.getParameter("mobile")!=null)
			{
				String query = "update student inner join login on login.userid = student.st_id set student.mobile=?,login.contact=? where student.st_id=?";
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, request.getParameter("mobile"));
				ps.setString(2, request.getParameter("mobile"));
				ps.setInt(3, sid);
				ps.executeUpdate();
			}
			if(request.getParameter("email")!=null)
			{
				String query = "update student inner join login on login.userid = student.st_id set student.email=?,login.username=? where student.st_id=?";
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, request.getParameter("email"));
				ps.setString(2, request.getParameter("email"));
				ps.setInt(3, sid);
				ps.executeUpdate();
			}
		
		}
		
		
		
		
		
		String query = "select * from student where st_id=?";
	    PreparedStatement ps = con.prepareStatement(query);
		ps.setInt(1, sid);	    	
		ResultSet res = ps.executeQuery();
		res.next();


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
    <script>
    	function enable(cbox,controlID)
    	{
    		//
    		var check = cbox;
    		//alert("funtion ");
    		if(check.checked == true)
    		{
    			//alert("funtion ");
    			document.getElementById(controlID).disabled = false;
    			//alert("funtion ");
    		}
    		else
    		{
    			document.getElementById(controlID).disabled = true;
    		}
    	
    	}
    </script>
    
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
       <legend> <h1>Profile</h1></legend>
        </fieldset>
        <form class="form-horizontal" role="form" action="" method="post">
        <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">My PhotoGraph : </label>
		    <div class="col-sm-10">
		      <img src="student/<%=res.getString("photo") %>" height="125px">
		    </div>
		  </div>
        
        
        
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Name : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="fname" id="inputname" value="<%=res.getString(1) %>" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Father Name : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="father" value="<%=res.getString(3) %>" disabled>
		    </div>
		  </div>
		  
		 <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Branch : </label>
		    <div class="col-sm-10">
		    
		      <select class="form-control" name="branch" id="branchid"  disabled>
		      	<option value="Computer Science">Computer Science</option>
		      	<option value="Information Technology">Information Technology</option>
		      	<option value="Civil">Civil</option>
		      	<option value="Mechanical">Mechanical</option>
		      	<option value="Electronics">Electronics Engineering</option>
		      	<option value="Electrical">Electrical Engineering</option>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Semester : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="sem" value="<%=res.getString(5) %>" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Shift : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="shift" value="<%=res.getString(6) %>" disabled>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Mobile : </label>
		    <div class="col-sm-10">
		     <input type="text" required="true" class="form-control" value="<%=res.getString(7) %>" Maxlength="10" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" name="mobile" id="mob1" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No." disabled/></input>
		   		<input type="checkbox" onchange="enable(this,'mob1')"> Edit ?</input>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Email : </label>
		    <div class="col-sm-10">
		     <input type="email" name="email" class="form-control" value="<%=res.getString(8) %>" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true" disabled ></input>
		   	<input type="checkbox" onchange="enable(this,'inputEmail')"> Edit ?</input>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Address : </label>
		    <div class="col-sm-10">
		     <textarea class="form-control"  disabled name="address" rows="3" id="PAddress" placeholder="Enter Permanent Address" required="true" onblur="correct(this.id)"><%=res.getString(9) %></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    
		    <div class="col-sm-offset-6 col-sm-3">
		    <input type="submit" value="Update Profile" name="register" class="btn btn-lg btn-success">
		      </div>
		      
		  </div>
	</form>
         
       
      </div>

    </div> <!-- /container -->
	

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script>
    document.getElementById('branchid').value = "<%=res.getString(4) %>";
    </script>
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>
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
    
    
  </body>
</html>