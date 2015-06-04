<%@page import="com.login.DBInfo"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con = DBInfo.getConn();
boolean isUser = true;
boolean isError;
try
{
	
	if(request.getParameter("login")!=null)
	{
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		String query = "select * from login where username=? and password=? ";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1,uname);
		ps.setString(2, pass);		
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			String query1 = "update login set logtime=?, ip=? where username=?";
			String query2 = "select st_name from student where st_id = ?";
			PreparedStatement ps2 = con.prepareStatement(query2);
			ps2.setInt(1, rs.getInt("userid"));
			ResultSet res1 = ps2.executeQuery();
			String name = "Admin";
			if(res1.next())
			{
				name = res1.getString(1);
			}
			
			
			PreparedStatement ps1 = con.prepareStatement(query1);
			java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
			ps1.setTimestamp(1,date);
			ps1.setString(2, request.getRemoteAddr());
			ps1.setString(3, uname);
			int result = ps1.executeUpdate();
			if(result == 1)
			{
				isUser = true;
				String type = rs.getString("usertype");
				if(type.equals("Student"))
				{
					session.setAttribute("type", "student");
					session.setAttribute("id", rs.getInt("userid"));
					session.setAttribute("name", name);
					session.setMaxInactiveInterval(3000);
					response.sendRedirect("student/Home.jsp");
					return;
				}
				else if(type.equals("Contest"))
				{
					session.setAttribute("type", "Contest");
					session.setAttribute("id", rs.getInt("userid"));
					session.setAttribute("name", name);
					response.sendRedirect("student/ContestExam.jsp?p=1");
					return;
				}
				else
				{
					session.setAttribute("type", "admin");
					session.setAttribute("id", rs.getInt("userid"));
					session.setAttribute("name", name);
					session.setMaxInactiveInterval(5000);
					response.sendRedirect("admin/Home.jsp");
					return;
				}
			
			}
			else
			{
				isError = true;
			}
		}
		else
		{
		   isUser = false;
		}
	
	}
}
catch(Exception e)
{
	response.sendRedirect("Error.jsp");
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
    
    <title>..:: Login Panel ::.. </title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   <title>Cover Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
   

    <!-- Custom styles for this template -->
    

   

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"></link>
  <link rel="stylesheet" href="css/cover.css" type="text/css"></link>
  <script type="text/javascript" src="js/ie-emulation-modes-warning.js">
  </script><script type="text/javascript" src="js/ie10-viewport-bug-workaround.js"></script></head>

  <body>

    <div class="site-wrapper">

      <div class="site-wrapper-inner">

        <div class="cover-container">

          <div class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand">Software Development</h3>
              <ul class="nav masthead-nav">
                <li class="active"><a href="index.jsp">Home</a></li>
               
                <li><a href="contact.jsp">Contact</a></li>
              </ul>
            </div>
          </div>

          <div class="inner cover">
          <%
          	if(!isUser)
          	{
          		%>
          		<div class="alert alert-danger alert-dismissible" role="alert">
  					<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  					<strong>Oh Snap !</strong> Username or password is incorrect.
				</div>
          		
          		
          		<%
          	
          	}
          
          
           %>
          
          <fieldset>
           <legend><h1 style="color: white" >Login</h1></legend> 
            </fieldset>
            <form class="form-signin" role="form" method="post">
        <h2 class="form-signin-heading"></h2>
        <input type="email" class="form-control" placeholder="Email address" name="uname" required autofocus>
        <br>
        <input type="password" class="form-control" placeholder="Password" name="pass" required>
        <div class="checkbox">
          
        </div>
        <button class="btn btn-lg btn-success btn-block" type="submit" name="login">Sign in</button>
      </form>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>Copyright &copy; Tech Innova Club 2014<br>Developed by <a href="#">Gaurav Agarwal</a>.</p>
            </div>
          </div>

        </div>

      </div>

    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/docs.min.js"></script>
  </body>
</html>