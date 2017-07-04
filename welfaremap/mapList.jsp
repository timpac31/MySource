<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="db.*,java.sql.*, util.utilBean, java.util.*"%>

{
	"mapList" : [
<%
   request.setCharacterEncoding("euc-kr");
	String page_no = request.getParameter("page_no");
	String scl = request.getParameter("scl");	// 검색 대분류
	String scs = request.getParameter("scs");	// 검색 소분류
	String sfn = request.getParameter("sfn");	// 검색 기관명

   
   DBConnectionMgr pool = DBConnectionMgr.getInstance();
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   ResultSet rs1 = null;

	/* 변수 선언 및 정의 */
    String sql = "";
	
	//검색조건 where절 셋팅
	String sqlWhere = "where 1=1";
	if(scl != null && !"".equals(scl)) {
		sqlWhere += " and cate_large = '" +scl+ "'";
	}
	if(scs != null && !"".equals(scs)) {
		sqlWhere += " and cate_small = '" +scs+ "'";
	}
	if(sfn != null && !"".equals(sfn)) {
		sqlWhere += " and fname like '%" +sfn+ "%'";
	}

	try{
		conn = pool.getConnection();
		stmt = conn.createStatement();
		
		if(page_no == null) {	//지도
			sql = "select * from  welfaremap order by seq asc ";
		}else {		//목록
			sql = " select X.* from ( ";
			sql +="		select A.*, rownum as rnum from ( ";
			sql +="			select * from welfaremap " + sqlWhere + " order by seq asc) A "; 
			sql +=" 	where rownum <= " + (Integer.parseInt(page_no)*5) + ") X where rnum > " + ((Integer.parseInt(page_no)-1)*5);
		}
		
		
		rs = stmt.executeQuery(sql);
		int i = 0;
		while(rs.next()){
			if(i > 0 ) { %>,<% }
%>		

		{
			"seq" : "<%=rs.getString("seq")%>",
			"cate_large" : "<%=rs.getString("cate_large")%>",
			"cate_small" : "<%=rs.getString("cate_small")%>",
			"addr" : "<%=rs.getString("addr")%>",
			"tel" : "<%=rs.getString("tel")%>",
			"homepage" : "<%=rs.getString("homepage") == null ? "없음" : rs.getString("homepage")%>",
			"fname" : "<%=rs.getString("fname")%>",
			"detail" : "<%=rs.getString("detail")%>",
			"anchorx" : "<%=rs.getString("anchorx")%>",
			"anchory" : "<%=rs.getString("anchory")%>"			
		}
<%		
			i++;
		}
%>

	]
	
<%
	sql = " select count(*) from welfaremap " + sqlWhere;
	rs1 = stmt.executeQuery(sql);
	while(rs1.next()){
%>
		, "total_cnt" : "<%=rs1.getInt(1)%>"
<%
	}
%>
}
<%
	/*DB연결 및 레코드셋 초기화*/
	}catch(Exception exception){
      System.out.println(exception);
	}finally{
      if( rs != null ) 
         try{ rs.close(); } 
         catch(SQLException ex) {out.println("rs error :" +ex); }
      if( rs1 != null ) 
          try{ rs1.close(); } 
          catch(SQLException ex) {out.println("rs error :" +ex); }
      if( stmt != null ) 
         try { stmt.close(); } 
         catch(SQLException ex) {out.println("stmt error :" +ex); }
      if( conn != null ) 
         try{ pool.freeConnection(conn); } 
         catch(Exception ex){ out.println("conn error :" +ex); }
   }
%>