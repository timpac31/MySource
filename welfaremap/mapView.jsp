<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="db.*,java.sql.*, util.utilBean, java.util.*"%>

<%
	request.setCharacterEncoding("euc-kr");
	String seq = request.getParameter("seq");
   
   DBConnectionMgr pool = DBConnectionMgr.getInstance();
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;

   String sql = "select * from welfaremap where seq = " + seq;

	try{
		conn = pool.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);

		while(rs.next()){
%>		
			{
				"seq" : "<%=rs.getString("seq")%>",
				"cate_large" : "<%=rs.getString("cate_large")%>",
				"cate_small" : "<%=rs.getString("cate_small")%>",
				"addr" : "<%=rs.getString("addr")%>",
				"tel" : "<%=rs.getString("tel")%>",
				"homepage" : "<%=rs.getString("homepage") == null ? "" : rs.getString("homepage")%>",
				"fname" : "<%=rs.getString("fname")%>",
				"detail" : "<%=rs.getString("detail") == null ? "" : rs.getString("detail")%>",
				"anchorx" : "<%=rs.getString("anchorx")%>",
				"anchory" : "<%=rs.getString("anchory")%>"
			}
<%		
		}
%>

<%
	}catch(Exception exception){
      System.out.println(exception);
	}finally{
      if( rs != null ) 
         try{ rs.close(); } 
         catch(SQLException ex) {out.println("rs error :" +ex); }
      if( stmt != null ) 
         try { stmt.close(); } 
         catch(SQLException ex) {out.println("stmt error :" +ex); }
      if( conn != null ) 
         try{ pool.freeConnection(conn); } 
         catch(Exception ex){ out.println("conn error :" +ex); }
   }
%>