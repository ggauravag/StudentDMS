<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Admin Panel :: Tech Innova Club</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  
   <title>Navbar Template for Bootstrap</title>

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
    
    function capitalize( str )
	{
	    var pieces = str.split(" ");
	    for ( var i = 0; i < pieces.length; i++ )
	    {
	        var j = pieces[i].charAt(0).toUpperCase();
	        
	        pieces[i] = j + pieces[i].substr(1).toLowerCase();
	    }
	    return pieces.join(" ");
	}
	
	function correct(inputID)
	{
		var value = document.getElementById(inputID).value;
		value = capitalize(value);
		document.getElementById(inputID).value = value;
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
            <li class="active"><a href="admin/Home.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;Home</a></li>
          
           
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
       <legend> <h1>Register Student</h1></legend>
        </fieldset>
        <form class="form-horizontal" role="form" action="admin/RegisterStudent.jsp" method="post">
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Name : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="fname" id="inputname" onblur="correct(this.id)" placeholder="Enter Name" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Father Name : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="father" required placeholder="Enter Father's Name" id="fid" onblur="correct(this.id)">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Date Of Birth : </label>
		    <div class="col-sm-5">
		      <input type="date" class="form-control" name="dob" id="inputPassword3" >
		    </div>
		  </div>
		 <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Branch : </label>
		    <div class="col-sm-10">
		      <select class="form-control" name="branch">
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
		      <input type="text" class="form-control" name="sem" required placeholder="Enter Semester">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Shift : </label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="shift" required placeholder="Enter Shift">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Mobile : </label>
		    <div class="col-sm-10">
		     <input type="text" required="true" class="form-control" Maxlength="10" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" name="mobile" id="inputStudent" pattern="^[7-9][0-9]{9}$" title="Please enter a valid mobile number" Placeholder="Enter Mobile No."/></input>
		   
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Email : </label>
		    <div class="col-sm-10">
		     <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Enter Email Id"  pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" required="true"  ></input>
		   
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">Address : </label>
		    <div class="col-sm-10">
		     <textarea class="form-control" name="address" rows="3" id="PAddress" placeholder="Enter Permanent Address" required="true" onblur="correct(this.id)"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    
		    <div class="col-sm-offset-3 col-sm-3">
		    <input type="submit" value="Register Student" name="register" class="btn btn-lg btn-success">
		      </div>
		      <div class="col-sm-offset-2 col-sm-4">
		      <input type="reset" class="btn btn-lg btn-reset">
		      </div>
		  </div>
	</form>
         
      </div>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>
