<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="db.*,java.sql.*, java.util.*"%>
<option value="">소분류(전체)</option>
<%
	request.setCharacterEncoding("euc-kr");
	String cate_large = request.getParameter("cate_large");
   
   DBConnectionMgr pool = DBConnectionMgr.getInstance();
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;

   String sql = "select distinct(cate_small) as cate_small from welfaremap where cate_large = '" + cate_large + "'";

	try{
		conn = pool.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);

		while(rs.next()){
%>		
	<option value="<%=rs.getString("cate_small")%>"><%=rs.getString("cate_small")%></option>	
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
