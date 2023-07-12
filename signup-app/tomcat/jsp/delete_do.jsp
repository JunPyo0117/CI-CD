<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>

 

<%

request.setCharacterEncoding("utf-8");

String id = request.getParameter("del");

 

try{

Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://172.27.0.166:3306/test";         //DB IP 주소/DB 명

Connection con = DriverManager.getConnection(url,"testuser","1234");    //DB 사용자 명

Statement stat = con.createStatement();

 

String query = "DELETE FROM test2 where id='" + request.getParameter("del")+"'";       //DB 테이블 명

//쿼리문 전송

stat.executeUpdate(query); //return 1.

stat.close();

con.close();

response.sendRedirect("output.jsp") ;

}

 

catch(Exception e){

out.println( e );

}

%>
