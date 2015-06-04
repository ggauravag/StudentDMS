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
			id = (Integer)session.getAttribute("id");
		}
		else
		{
			response.sendRedirect("/TechStar/Unauthorize.jsp");	
		}
		
		
		String query = "select * from result where st_id = ?";
		PreparedStatement ps1 = con.prepareStatement(query);
		ps1.setInt(1, id);
		
		ResultSet res = ps1.executeQuery();
		
		
		
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
        
					 <li class="active"><a><span class="glyphicon glyphicon-star"></span>&nbsp; Your Result</a></li>
					 </ul>
			        </div>
			        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			          <h1 class="page-header">Result : </h1> 
			          <br><% 
			          
			          while(res.next())
			          {
				          if(res.getString(7).equals("PASS"))
				          {
				          	out.write("<font size='5' color='green'>PASS</font><font size='4'>&nbsp;&nbsp;&nbsp;&nbsp; Exam : "+res.getString(2)+"</font>");
				          }
				          else
				          {
				          	out.write("<font size='5' color='red'>FAIL</font><font size='4'>&nbsp;&nbsp;&nbsp;&nbsp; Exam : "+res.getString(2)+"</font>");
				          }
				          
				          %><font size="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marks : </font><font size="10"><%=res.getInt(6) %></font><br><br><%
			          
			          }															
			          
			         %> 
			       
			          <a href="/TechStar/student/RankList.jsp">View Rank List</a>
					</div>
				
			}
        
        
         %>
          
           
            
          
		 
		
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
    	win = window.open("/TechStar/student/HackerTest.jsp?","_blank","width="+screen.width+",height="+screen.height+"");
    	myInterval = window.setInterval("checkWindow()",0);
    }
    
    function checkWindow()
    {
    	if(win.closed)
    	{
    		alert("Your Test is over ! Thanks for attempting and wait for your detailed result.")
    		window.clearInterval(myInterval);
    		location.href = "<%=basePath%>student/HackerResult.jsp";
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