<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	System.out.println(request.getParameter("s_addr"));

	String s_id = request.getParameter("s_id");

	String s_addr = new String(request.getParameter("s_addr").getBytes("8859_1"),"utf-8");  
	String s_pwd = new String(request.getParameter("s_pwd"));	

	Connection myConn = null;  
	Statement stmt = null;  
	String mySQL = "";

	String dburl  = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user="DBHS"; 		  // 본인 아이디(ex.ST0000000000)
	String passwd="DBHS";   // 본인 패스워드(ex.ST0000000000)
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    

	try {
   	   Class.forName(dbdriver);
	   myConn =  DriverManager.getConnection (dburl, user, passwd);
	   stmt = myConn.createStatement();	
   } catch(SQLException ex) {
		  System.err.println("SQLException: " + ex.getMessage());
   }
    mySQL = "update student ";
	mySQL = mySQL + " set s_addr ='" + s_addr + "' , " ;	
	mySQL = mySQL + " s_pwd ='" + s_pwd + "' where s_id='" + s_id + "' "; 
	try  {
	  System.out.println(mySQL);
	  stmt.executeQuery(mySQL);  
%>

<script>
  alert("학생 정보가 수정되었습니다.");       
  location.href="update.jsp";
</script>
<%    
     } catch(SQLException ex) {
  	   String sMessage;
   	   if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다";
	  else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
	  else sMessage="잠시 후 다시 시도하십시오";	
%>
<script>
	alert("<%= sMessage %>");    
	location.href = "update.jsp";
</script>
<%	
	} finally {
		if (stmt != null)   try { 	stmt.close();  myConn.close(); }
		catch(SQLException ex) { }
	}
%>
</body></html>
