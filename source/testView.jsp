<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Temp&Hum Web</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<% Connection conn = null;
		PreparedStatement pstmt = null;
		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://localhost:3306/cyk94";

	try{
		try{
			Class.forName(jdbc_driver);
			out.println("loading success");
		}
		catch(Exception e){
			out.print("Loading fail<BR>");
			out.println(e);
			out.println("<BR>");
		}

		try{
			conn = DriverManager.getConnection(jdbc_url,"1123","1123");
			out.println("DB successs");
		}
		catch(Exception e){
			out.println("DB Fail<BR>");
			out.println(e);
			out.println("<BR>");
		}

		String sql = "select * from DATA_INFO order by tno";
		pstmt = conn.prepareStatement(sql);
			
		ResultSet rs = pstmt.executeQuery();
		int i = 1;
	%>

	<h2>This is Temp & Humidity Info</h2>
	<div id="data_info">
		<p><a href="test.jsp"><input type="button" value="Total View"/></a></p>
		<table border="1">
		<tr>
			<th>No</th>
			<th>Temp</th>
			<th>Humidity</th>
		</tr>	
	</div>

	<%
		while(rs.next()){ %> 
		<tr>
			<td><%=rs.getString("tno")%></td>
			<td><%=rs.getString("ttemp")%></td>
			<td><%=rs.getString("thum")%></td>
		</tr>

	<%	i++;
		}
		
	rs.close();
	pstmt.close();
	conn.close();
	}

	catch(Exception e){
		out.println("Error : " + e);
	}
	%>
	</table>
</body>
</html
