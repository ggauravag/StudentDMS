<%@page import="com.login.DBInfo"%>
<%@page import="java.sql.Connection"%>
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
	Random rand = new Random();
	ArrayList<Integer> array = new ArrayList<Integer>();
	//To generate random 15 questions
	while(array.size() < 15)
	{
		int q = rand.nextInt(30) + 1;
		if(!array.contains(q))
			array.add(q);
	}
	
	for(int a:array)
		System.out.println(a);
	
	Iterator iter = array.iterator();
	int qno = (Integer)iter.next();
	session.setAttribute("ques", iter);
	
	
	session.setAttribute("ename", "PAE-Normal:1");
	String query = "insert into result values(?,?,now(),?,?,?,?)";
	PreparedStatement ps = con.prepareStatement(query);
	ps.setInt(1, id);
	ps.setString(2, "PAE-Normal:1");
	ps.setString(3, "eeeeeeeeeeeeeee");
	ps.setString(4,"eeeeeeeeeeeeeee");
	ps.setInt(5, 0);
	ps.setString(6, "FAIL");
	
	int j = ps.executeUpdate();
	ps.close();
	ps = con.prepareStatement("select * from test where qno = ?");
	ps.setInt(1, qno);
	ResultSet rs = ps.executeQuery();	
	if(rs.next())
	{
		System.out.println("Got Question");
		
	}
	else
	{
		System.out.println("No question with number : "+qno);
	}
	
	if(j!=1)
	{
		response.sendRedirect("/TechStar/student/AttemptTest.jsp");
	}
	
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
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
    
    var time = 900;
    
    function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
    
    
    
    function loadNewQues(x)
    {
    
    				var qno = x[0].getElementsByTagName("QNO");
	    			//alert("Got question no : "+qno);
			    	qno = qno[0].firstChild.nodeValue;
			    	//alert("Got question no : "+qno);
			    	//alert("Question is :"+qno);
			    	
			    	if(qno == "12")
			    	{
			    		ques = "Which operator is used for comparision ? <br> 1(=) <br> 2(<) <br> 3(==) <br> 4(!=) ?";
			    		op1 = "3";
			    		op2 = "1,2,3";
			    		op3 = "2,3,4";
			    		op4 = "3,4";
			    		img = "";
			    	}
			    	if(qno == "30")
			    	{
			    		ques = "What is the Shortcut key in Turbo C to Compile & Run a C Program ? ";
			    		op1 = "Ctrl + F9";
			    		op2 = "Alt + F9";
			    		op3 = "F9";
			    		op4 = "Enter + F9";
			    		img = "";
			    	}
			    	if(qno == "28")
			    	{
			    		ques = "If u want to check a is less than 50 & greater than 10, you will place which operator in blank space ?";
			    		op1 = "OR(||)";
			    		op2 = "(!=)";
			    		op3 = "AND(&&)";
			    		op4 = "(==)";
			    		img = "/TechStar/student/image/ques7.jpg";
			    	}
			    	if(qno == "29")
			    	{
			    		ques = "(1) -> int a = 35.0/2; (2) -> float a = 35/2; (3) -> int a = 35/2; (4) -> float a = (35.0)/2; \nWhich will give a = 17.5 ?";
			    		op1 = "1";
			    		op2 = "2";
			    		op3 = "3";
			    		op4 = "4";
			    		img = "";
			    	}
			    	if(qno == "17")
			    	{
			    		ques = "Which of the following will evaluate to true ?";
			    		op1 = "false || false";
			    		op2 = "true || false";
			    		op3 = "true && false";
			    		op4 = "false && true";
			    		img = "";
			    	}
			    	if(qno == "4")
			    	{
			    		ques = "What printf(\"Hello \nWorld\"); will print ?";
			    		op1 = "Hello \nWorld";
			    		op2 = "Hello<br>World";
			    		op3 = "Hello World";
			    		op4 = "HelloWorld";
			    		img = "";
			    	}
			    	
			    	
			    	document.getElementById("o1").innerHTML = op1;
	    			document.getElementById("o2").innerHTML = op2;
	    			document.getElementById("o3").innerHTML = op3;
	    			document.getElementById("o4").innerHTML = op4;
	    			
	    			document.getElementById("options1").disabled = false;
	    			document.getElementById("options2").disabled = false;
	    			document.getElementById("options3").disabled = false;
	    			document.getElementById("options4").disabled = false;
	    			
	    			document.getElementById("options1").checked = false;
	    			document.getElementById("options2").checked = false;
	    			document.getElementById("options3").checked = false;
	    			document.getElementById("options4").checked = false;
	    			
	    			document.getElementById("confirm").disabled = true;
	    			document.getElementById("next").disabled = true;
	    			
	    			serial = serial + 1;
	    			document.getElementById("qprevious").value = qno;
	    			
	    			document.getElementById(""+(serial-1)).className = "";
	    			document.getElementById(""+(serial)).className = "active";
	    			document.getElementById("question").innerText = ques;
	    			document.getElementById("qimage").src = img;
	    			if(img != null & img != "")
	    			{
	    				//var h = prompt("Enter image height : ");
	    				document.getElementById("qimage").height = "250";
	    				//alert("Image width is : "+h);
	    			}
	    			else
	    			{
	    				document.getElementById("qimage").height = "0";
	    			}
	    			
	    			//alert("Success");
    
    }
    
    
    
    function loadQuery(data)
	{
		var xmlhttp;
		//alert('ajax called with data'+data);
		if (window.XMLHttpRequest)
		  {// code for IE7+, Firefox, Chrome, Opera, Safari
		  	xmlhttp=new XMLHttpRequest();
		  }
		else
		  {// code for IE6, IE5
		  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		  
		  
	  
	  
	xmlhttp.onreadystatechange=function()
	  {
	  //alert("ajax state change : "+xmlhttp.readyState+" status is : "+xmlhttp.status);
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    	//document.getElementById("displayRecord").innerHTML=xmlhttp.responseText;
	    	//alert("responseXML is : "+xmlhttp.responseXML);
	    		//var parser = new DOMParser();
				//var xmlDoc = parser.parseFromString(xmlhttp.responseText,"text/xml");
	    	//alert("The parsed response is : "+xmlDoc);
	    		//alert("ResponseXML is : "+xmlhttp.responseXML+" and responseText is : "+xmlhttp.responseText);
	    		var xmlDoc = null;
	    		try
	    		{
	    		x = xmlhttp.responseXML.documentElement.getElementsByTagName("QUESTION");
	    		
	    		//alert(" X is having : "+x.length);
	    		
	    		y = xmlhttp.responseXML.documentElement.getElementsByTagName("SUBMIT");
	    		
	    		//alert(" Y is having : "+y.length);
	    		
	    		z = xmlhttp.responseXML.documentElement.getElementsByTagName("END");
	    		
	    		//alert(" Z is having : "+z.length);
	    		
	    		//alert("Response is x : "+x.length+" and y is : "+y.length);
	    		}
	    		catch(err)
	    		{
	    			//alert(err.message);
	    			////alert("The response in XML was : "+xmlhttp.responseXML+" Response in text was : "+xmlhttp.responseText)
	    			var parser = new DOMParser();
					xmlDoc = parser.parseFromString(xmlhttp.responseText,"text/xml");
		    		//alert("The parsed response is : "+xmlDoc);
		    		//alert("Inside dash dash")
	    			x = xmlDoc.documentElement.getElementsByTagName("QUESTION");
	    			//alert("X Question :  : "+x[0].getElementsByTagName("QNO")[0].firstChild.nodeValue);
	    			
	    			loadNewQues(x);
	    			return;
	    		}
	    		
	    		if(z.length > 0)
	    		{
	    			alert("You have successfully completed test !");
	    			//mark = xmlhttp.responseXML.documentElement.getElementsByTagName("MARKS");
	    			//var marks = parseInt(marks[0].firstChild.nodeValue);
	    			//alert("Your marks are : "+marks);
	    			window.close();
	    			return;
	    		
	    		}
	    		
	    		else if(y != null && y.length > 0)
	    		{
	    			//alert("Question Submitted Successfully");
	    			document.getElementById("options1").disabled = true;
	    			document.getElementById("options2").disabled = true;
	    			document.getElementById("options3").disabled = true;
	    			document.getElementById("options4").disabled = true;
	    			document.getElementById("next").disabled = false;
	    			
	    		}
	    		else if(x.length > 0)
	    		{
	    			//alert("Just got a new question");
	    			
	    				
	    				
	    			
	    			var qno = x[0].getElementsByTagName("QNO");
	    			//alert("Got question no : "+qno);
			    	qno = qno[0].firstChild.nodeValue;
			    	//alert("Got question no : "+qno);
			    	
			    	var ques = x[0].getElementsByTagName("Q");
			    	//alert("Got question : "+ques);
			    	ques = ques[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var op1 = x[0].getElementsByTagName("OP1");
			    	op1 = op1[0].firstChild.nodeValue;
			    	
			    	var op2 = x[0].getElementsByTagName("OP2");
			    	op2 = op2[0].firstChild.nodeValue;
			    	//alert("Just pushing students");
			    	var op3 = x[0].getElementsByTagName("OP3");
			    	op3 = op3[0].firstChild.nodeValue;
			    	
			    	var op4 = x[0].getElementsByTagName("OP4");
			    	op4 = op4[0].firstChild.nodeValue;
			    	//alert("All values OK");
			    	var img = x[0].getElementsByTagName("IMAGE");
			    	if(img[0] == null || img[0].firstChild == null)
			    	{
			    		img = "";
			    		//alert("Not an image question")
			    	}
			    	else
			    	{
			    		img = img[0].firstChild.nodeValue;
			    		//alert("Got an image question")
			    	}
			    	
			    	//alert("Just entering new students");
			    	
			    	
			    	document.getElementById("o1").innerHTML = op1;
	    			document.getElementById("o2").innerHTML = op2;
	    			document.getElementById("o3").innerHTML = op3;
	    			document.getElementById("o4").innerHTML = op4;
	    			
	    			document.getElementById("options1").disabled = false;
	    			document.getElementById("options2").disabled = false;
	    			document.getElementById("options3").disabled = false;
	    			document.getElementById("options4").disabled = false;
	    			
	    			document.getElementById("options1").checked = false;
	    			document.getElementById("options2").checked = false;
	    			document.getElementById("options3").checked = false;
	    			document.getElementById("options4").checked = false;
	    			
	    			document.getElementById("confirm").disabled = true;
	    			document.getElementById("next").disabled = true;
	    			
	    			serial = serial + 1;
	    			document.getElementById("qprevious").value = qno;
	    			
	    			document.getElementById(""+(serial-1)).className = "";
	    			document.getElementById(""+(serial)).className = "active";
	    			document.getElementById("question").innerText = ques;
	    			document.getElementById("qimage").src = img;
	    			if(img != null & img != "")
	    			{
	    				//var h = prompt("Enter image height : ");
	    				document.getElementById("qimage").height = "250";
	    				//alert("Image width is : "+h);
	    			}
	    			else
	    			{
	    				document.getElementById("qimage").height = "0";
	    			}
	    			
			    }
			    else
			    {
			    
			    }
	    		
	    		
	     }
	   
	  }
	  
	 
		var path = "<%=basePath%>"+"student/AjaxEnd.jsp";
		xmlhttp.open("POST",path,true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(data);
	
	
	
	}
    
    
    
    
    </script>
  </head>
  
  <body oncontextmenu="alert('This function is not allowed');return false;" onkeydown="return (event.keyCode != 116);" >
	
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">;dbToggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand">Tech Innova Club</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
           
            <li><a id="clock"></a></li>
             <li><a >Welcome ! <%=session.getAttribute("name") %></a></li>
          </ul>
          <form class="navbar-form navbar-right">
<!--            	<p id="clock" style="color:white"><font size="4">TIME : &nbsp;<strong>&nbsp;15&nbsp;:&nbsp;00&nbsp;</strong></font></p> -->

          </form>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a ><span class="glyphicon glyphicon-star"></span> TOTAL QUESTIONS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge">15</span></a></li>
            <li id=1 class="active"><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 1</a></li>
            <li id=2><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 2</a></li>
            <li id=3><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 3</a></li>
			<li id=4><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 4</a></li>
			<li id=5 ><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 5</a></li>
			<li id=6><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 6</a></li>
			<li id=7><a ><span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 7</a></li>
			<li id=8><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 8</a></li>
			<li id=9><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 9</a></li>
			<li id=10><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 10</a></li>
			<li id=11><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 11</a></li>
			<li id=12><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 12</a></li>
			<li id=13><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 13</a></li>
			<li id=14><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 14</a></li>
			<li id=15><a > <span class="glyphicon glyphicon-share-alt"></span> &nbsp;&nbsp; Question 15</a></li>
		
			
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <%
          	String ques[] = rs.getString(2).split(":");
          	
           %>
          <font id="question" size="5"><%=ques[0] %></font>
          <br>
          <%
          	if(ques.length == 2)
          	{
          	%><img id="qimage" src="<%=ques[1] %>" ><%
          	}
          	else
          	{
          	%><img id="qimage" src="" ><%
          	}
          
           %>
		 	
          
          
			<form name="myform">
		  	<input type=hidden name="serial" id="serial">
		  	<input type=hidden value="<%=qno %>" id="qprevious" name="ques" >
						<br>
			    		
						<div class="radio">
							<label>
								<input type="radio" name="answer" id="options1" value="a" onchange="enableSubmit()">
									<font id="o1" size="4"><%=rs.getString(3) %></font> 
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="answer" id="options2" value="b" onchange="enableSubmit()">
									<font id="o2" size="4"><%=rs.getString(4) %></font> 
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="answer" id="options3" value="c" onchange="enableSubmit()">
									<font id="o3" size="4"><%=rs.getString(5) %></font> 
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="answer" id="options4" value="d" onchange="enableSubmit()">
									<font id="o4" size="4"><%=rs.getString(6) %></font> 
							</label>
						</div>
						
						
			    	
		
		
		
			<button class="btn btn-success col-sm-offset-3" id="confirm" onclick="submitAnswer(this.id)" disabled><span class="glyphicon glyphicon-ok"></span>&nbsp;Submit Answer</button>
			<button class="btn btn-success col-sm-offset-3" id="next" onclick="nextQues(this.id)" disabled>Next Question<span class="glyphicon glyphicon-chevron-right"></span></button>
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
	<script type="text/javascript">
		
		function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
		
		var myVar = setInterval(function(){myTimer()},1000);
	
	
		function myTimer() 
		{
			
			
			time = time - 1;
			
			
			
		    var minute = parseInt(time/60);
		    minute = minute.toString();
		    
		    if(minute.length == 1)
		    	minute = "0"+minute;
		    
		    var seconds = time % 60;
		    seconds = seconds.toString();
		    
		    if(seconds.length == 1)
		    	seconds = "0"+seconds;
		    	//alert("Function called with time : "+time);
		    document.getElementById("clock").innerHTML = "<font size='6' id='clr' color='white'>Time Left (MM : SS) : &nbsp;<strong>&nbsp;"+minute+"&nbsp;:&nbsp;"+seconds+"&nbsp;</strong></font>";
			if(time > 0 && time < 60 && (time%2 == 1))
				document.getElementById("clr").color = "red";
			
			
			
			if(time == 0)
			{
				clearInterval(myVar);
				alert("Your Time is up !");
				window.close();
			}
			
		}
		
		
		
		
		
		function enableSubmit()
		{
			document.getElementById("confirm").disabled = false;
		}
		
		function submitAnswer(btn)
		{
			document.getElementById(btn).disabled = true;
			var answer = document.forms["myform"].answer.value;
			var ser = serial;
			var ques = document.forms["myform"].ques.value;
			var data = "q="+ques+"&ans="+answer+"&ser="+ser;
			//alert("The called fn with data is : "+data);
			loadQuery(data);
			
		}
		
		function nextQues(btn)
		{
			document.getElementById(btn).disabled = true;
			var ques = document.forms["myform"].ques.value;
			var data = "ques="+ques;
			//alert("Current Question Number is & serial number is  : "+data+" , "+serial);
			loadQuery(data);
		}
	</script>
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
