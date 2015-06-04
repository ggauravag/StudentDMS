<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*,java.sql.*,java.io.File" pageEncoding="ISO-8859-1"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%
	if(session.getAttribute("type") == null || !session.getAttribute("type").equals("Contest"))
	{
	
		response.sendRedirect("../index.jsp");
		return;
	}


Connection con = null;

try
{
 con = DBInfo.getConn();
 String pid = request.getParameter("p");
 PreparedStatement pes = con.prepareStatement("select * from problem where prob_id = "+pid+"");
 ResultSet res1 = pes.executeQuery();
 res1.next();
 
 
 String contentType = request.getContentType();
		
		
		if((contentType != null) && contentType.indexOf("multipart/form-data") >= 0)
		{
		
			
		
			String lang = null;
			String prob = null;
			String filename = null;
			
		
			FileItemFactory factory = new DiskFileItemFactory();
	      	ServletFileUpload upload = new ServletFileUpload(factory);
	      	List items = null;
		
	      	try 
	      	{
				items = upload.parseRequest(request);
			} 
         	catch (FileUploadException e) 
         	{
             e.printStackTrace();
            }
          
          
            Iterator itr = items.iterator();
			
			
			
			
			Random random =  new Random();
			int rand = random.nextInt(10000);
			
            while (itr.hasNext()) 
            {
              	FileItem item = (FileItem) itr.next();

              	if (!item.isFormField()) 
              	{
                  	try {

					  File savedFile = null;
                      String itemName = item.getName();
                      if(itemName != "" && itemName.contains("."))
                        {
                            String idl = ""+session.getAttribute("id");
                     		//filename = "/upload/File"+((String)session.getAttribute("id")).substring(12)+itemName.substring(itemName.indexOf('.')).toLowerCase();
                      		filename = "/code/File"+idl+itemName;
                      		savedFile = new File(config.getServletContext().getRealPath("/student/")+filename);
						}
						
					  System.out.println("Got a file : "+itemName+" With file name : "+filename);
                      item.write(savedFile);
                        
                  		} 
                     catch (Exception e) 
                  		{
                      		e.printStackTrace();
                  		}
                } 
              	else 
              	{
                      String name = item.getFieldName();
		              String value = item.getString();
		              if(name.equals("prob"))
		              	prob = value;
		              if(name.equals("lang"))
		              	lang = value;
		              
		              System.out.println(name+" : : "+value);
              	}
      	
			
			}
		
			
	           
	           PreparedStatement ps = con.prepareStatement("insert into upload values(?,?,?,?,now())");
	          
	           ps.setInt(1,(Integer)session.getAttribute("id"));
	           ps.setInt(2, Integer.parseInt(prob));
	           ps.setString(3, lang);
	           ps.setString(4, filename);
	           
	           
	           
	           int i = ps.executeUpdate();
	           if(i==1)
	           {
	           		System.out.println("Problem Uploaded");
	           		
	           }
	           else
	           {
	          		System.out.println("Error while uploading problem");
	           }
	           
	           session.setAttribute("up", i);
	           response.sendRedirect("ContestExam.jsp?p=1");
	         	return;
	         }
 

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title>Online Performance Assessment Test</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="/TechStar/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/TechStar/css/dashboard.css" rel="stylesheet">

    <script src="/TechStar/js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/TechStar/js/ie10-viewport-bug-workaround.js"></script>
    <script src="countdown.js" type="text/javascript"></script>
    <script type="text/javascript">
    
	
    var serial = 1;
    
    var time = 7200;
    
    function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        
    
    
    
    </script>
  </head>
  
    	
    
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">;dbToggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand">DreamBit Technologies</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
           
            <li><a id="clock"></a></li>
             <li><a >Welcome ! <%=session.getAttribute("name") %></a></li>
             <li><a href="../Logout.jsp">Log Out</a></li>
          </ul>
          <div class="navbar-form navbar-right">
<!--            	<p id="clock" style="color:white"><font size="4">TIME : &nbsp;<strong>&nbsp;120&nbsp;:&nbsp;00&nbsp;</strong></font></p> -->

          </div>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a ><span class="glyphicon glyphicon-star"></span> TOTAL QUESTIONS &nbsp;<span class="badge">3</span></a></li><br>
            <li
            <%
            	if(pid.equals("1"))
            	{
            	out.write("class=\"active\"");
            	}
             %>><a href="ContestExam.jsp?p=1"> <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Problem 1 &nbsp;&nbsp; ( 100 pts )</a></li><br>
            <li <%
            	if(pid.equals("2"))
            	{
            	out.write("class=\"active\"");
            	}
             %>><a href="ContestExam.jsp?p=2"> <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Problem 2 &nbsp;&nbsp; ( 250 pts )</a></li><br>
            <li <%
            	if(pid.equals("3"))
            	{
            	out.write("class=\"active\"");
            	}
             %>><a href="ContestExam.jsp?p=3"> <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Problem 3 &nbsp;&nbsp; ( 500 pts )</a></li><br>
			
		
			
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          
		  <fieldset>
		   <% 
	       if(session.getAttribute("up")!= null && (Integer)session.getAttribute("up") == 1)
          {
           %>
          <div class="alert alert-success fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Success !</strong> Code has been uploaded.
   		  </div>
   		   <%
   		   session.removeAttribute("up");
   		  }
   		  else if(session.getAttribute("up")!= null && (Integer)session.getAttribute("up") == 0)
   		  {
 			%>
          <div class="alert alert-danger fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<strong>Oh Snap !</strong> Unable to upload code, please try again.
   		  </div>
   		   <%
   		   session.removeAttribute("up");
   		  }
   		  %>
                    <legend>
                        <h1>
                            Problem <%=pid %> : <%=res1.getString(2) %></h1>	
                    </legend>
                   
                    <h4>Problem Statement</h4>
                    
                    
                    <%=res1.getString(3) %>
                    <h4>Input</h4>
                    <%=res1.getString(4) %>
                    <h4>Output</h4>
                    <%=res1.getString(5) %>
                    <h4>Sample Input</h4>
                    <%=res1.getString(6) %>
                    <h4>Sample Output</h4>
                    <%=res1.getString(7) %>
          </fieldset>
		  <br />
		 
         
          <br>
          
			<form method="post" class="form-horizontal" name="optionForm" enctype="multipart/form-data">
  	
						<br>
			   		
						<input type="hidden" name="prob" value="<%=pid %>">
					
						<br><br>
						    	<div class="form-group">
						    	<div class="col-sm-4">
									<label for="File" id="File">Choose File to Upload</label>
									<input type="file" id="File" name="code" class="form-control"> 
									</div>
									<div class="col-sm-2">
										<select class="form-control" name="lang">
										
											<option value="C">C</option>
											<option value="C++">C++</option>
											<option value="Java">Java</option>  	
										</select>
									</div>
									<div class="col-sm-2">
									<input type="submit" name="upload" class="btn btn-success" value="Upload">
									</div>
								</div>
							<br>
								<div class="form-group" style="display:inline">
									
								</div>
		
			
			<br><br><br><br><br>
        </form>
		
        </div>
      </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/TechStar/js/jquery.min.js"></script>
    <script src="/TechStar/js/bootstrap.min.js"></script>
    <script src="/TechStar/js/docs.min.js"></script>
	
  </body>
  <%
  }
  catch(Exception e)
  {
  	e.printStackTrace();
  
  }
  finally
  {
  	if(con != null)
  	{
  		try
  		{
  			con.close();
  			}
  			catch(Exception e)
  			{
  			e.printStackTrace();
  			}
  	
  	}
  
  }
  
  
   %>
</html>
