<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login.jsp</title>
</head>
<body>
	<%
		String url = "jdbc:mysql://127.0.0.1:3306/sns";
		String uid = "root";
		String pwd = "5245";
		String driver = "com.mysql.jdbc.Driver";
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		Connection connect = null;
		PreparedStatement pstmt = null;
		
		try{
			
			Class.forName(driver);
			connect = DriverManager.getConnection(url, "root", "5245");
			if(connect != null){

				String query = "SELECT * from users";
				pstmt = connect.prepareStatement(query);
				ResultSet rs = pstmt.executeQuery();
				boolean foundUser = false;

				while( rs.next() ){
					String preEmail = rs.getString("email");
					String prePassword = rs.getString("password");
					%>
					<%=preEmail %>
					<%=prePassword %>
				<% 
					if(email.equals(preEmail) && password.equals(prePassword))
					{
						foundUser = true;
						break;
					}
						
				}

				if(foundUser){
					out.println("<script>alert('로그인 성공!(다음 메인홈페이지 연결ㄱㄱ)')</script>");
					
				}else {

					out.println("<script>alert('로그인 실패!')</script>");
					out.println("<script>window.location='login.html'</script>");
				}

				pstmt.close();
				connect.close();
				
			}else{
				out.println("Database cannot be connected!");
			}
		}catch(Exception e){
			
			out.println(e.getMessage()); 
			e.printStackTrace();
		}	
		
		
		
	%>
</body>
</html>