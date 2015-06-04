

<%@ page language="java" import="java.util.*, java.io.*, java.sql.*, com.login.*" pageEncoding="ISO-8859-1"%>



  <%
  Connection con = null;
  try
  {
  		con = DBInfo.getConn();
  		
  		String ename = (String)session.getAttribute("ename");
  		System.out.println("Exam name is : "+ename);
  		String ex = (String)session.getAttribute("ex");
		String ques = request.getParameter("q");
		String qprev = request.getParameter("ques");
		String ans = request.getParameter("ans");
		int id = (Integer)session.getAttribute("id");
		String current = request.getParameter("ser");
		System.out.println("---- Page Called with data : "+ques+" Prev : "+qprev+" Ans : "+ans+" ID : "+id+" Current : "+current+" -------");
  		
  		ResultSet res = null;
  		PreparedStatement stmt = null;
  		String data = "";
  		Iterator<Integer> iter = (Iterator<Integer>)session.getAttribute("ques");
  		
  		if(ques!=null && ans!=null)
  		{
  			int q = Integer.parseInt(ques);
  			String sql; 
  			if(ex != null && ex.equals("Hacker"))
  			{
  			
  				sql  = "{ CALL AddAnsHack(?,?,?,?,?) }";
  			}
  			else
  			{
  				sql = "{ CALL AddAns(?,?,?,?,?) }";
  			
  			}
			
			CallableStatement call = con.prepareCall(sql);
			call.setInt(1, id);
			call.setInt(2,Integer.parseInt(current));
			call.setString(3,ans);
			call.setString(4,ename);
			call.setInt(5,q);
			//System.out.println("Call statement is : "+call+" and ID is : "+sid+" operation is :"+call.execute());
			call.execute();
			call.close();
			
  			String xml = "";
  			response.setContentType("text/xml;charset=UTF-8");
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY><SUBMIT>Y</SUBMIT>";
  			if(!iter.hasNext())
	  		{	
	  			String s = "select marks from result where st_id = ? and exam_name = ?";
	  			PreparedStatement pes = con.prepareStatement(s);
	  			pes.setInt(1, id);
	  			pes.setString(2, ename);
	  			ResultSet rse = pes.executeQuery();
	  			if(rse.next())
	  			{
	  				xml += "<MARKS>"+rse.getInt(1)+"</MARKS>";
	  			}
	  			rse.close();
	  			pes.close();
	  			xml += "<END>Y</END>";
	  			//out.write(xml);
	  			//System.out.println(xml);
	  			//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  			//return;	
	  		}
  			
  			xml += "</QUERY>";
  			out.write(xml);
  			//System.out.println(xml);
  			//System.out.println("The response is : "+response.getContentType()+" is :"+xml);
  			con.close();
  			return;
  		}
  		
  		
  		
  		else if(qprev != null)
  		{
  			String query = "";
  			if(ex != null && ex.equals("Hacker"))
  			{
  				query = "select * from hackertest where qno = ?";
  			}
  			else
  			{
  				query = "select * from test where qno = ?";
  			}
  			
			PreparedStatement ps = con.prepareStatement(query);
			int qcurr = iter.next();
			ps.setInt(1, qcurr);
			//ps.setString(2, ename);
			ResultSet rs = ps.executeQuery();
			
			session.setAttribute("ques", iter);
  			response.setContentType("text/xml;charset=UTF-8");
  			String xml = "";
  			
  			xml.concat("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  			xml += "<QUERY><QUESTION>";
  			System.out.println(response.getContentType());
  			if(rs.next())
			{
				
				String qu = rs.getString(2);
				String op1 = rs.getString(3);
				String op2 = rs.getString(4);
				String op3 = rs.getString(5);
				String op4 = rs.getString(6);
				xml += "<QNO>"+rs.getInt(1)+"</QNO>";
				String question[] = qu.split(":");
				if(question.length == 2)
				{
					xml += "<Q>"+question[0]+"</Q>";
					xml += "<IMAGE>"+question[1]+"</IMAGE>";
				}
				else
				{
					xml += "<Q>"+question[0]+"</Q>";
				}
				
				xml += "<OP1>"+op1+"</OP1>";
				xml += "<OP2>"+op2+"</OP2>";
				xml += "<OP3>"+op3+"</OP3>";
				xml += "<OP4>"+op4+"</OP4>";
			}
	  		
	  		xml += "</QUESTION></QUERY>";
	  		
	  		out.write(xml);
	  		System.out.println("The response is : "+response.getContentType()+" is :"+xml);
	  		con.close();
	  		return;
  		}
  		
  		else
  		{
  		
  		return;
  		
  		}
  	
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