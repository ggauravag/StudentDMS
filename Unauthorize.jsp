<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<script>
	function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        
        
        function redirect()
        {
              window.location = "<%=basePath%>";
        }

        setTimeout("redirect()", 2000);
	</script>
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
         
          
          <fieldset>
           <legend><h1 style="color: white" >Unauthorized Access</h1></legend> 
           <h3>Your session has been timed out or you are unauthorized to view the page.</h3>
           <h4> Please login again to continue</h4>
            </fieldset>
            
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
