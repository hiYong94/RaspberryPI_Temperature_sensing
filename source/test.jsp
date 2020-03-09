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

		String sql = "select ttemp, thum, count(*) from DATA_INFO group by ttemp order by count(*) desc";
		pstmt = conn.prepareStatement(sql);
			
			//out.println(i+ " : " + rs.getString("ttemp") + ", " + rs.getString("thum") + "<BR>");
		ResultSet rs = pstmt.executeQuery();
		int i = 1;
	%>

	<h2>This is Temp & Humidity Info</h2>
	<div id="data_info">
		<p><a href="testView.jsp"><input type="button" value="All View Page"/></a></p>
		
		<table border="1">
		<tr>
			<th>Temp</th>
			<th>Humidity</th>
			<th>Count</th>
		</tr>	
	</div>

	<%
		while(rs.next()){ %>
		<tr>
			<td><%=rs.getString("ttemp")%></td>
			<td><%=rs.getString("thum")%></td>
			<td><%=rs.getString("count(*)")%></td>
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
