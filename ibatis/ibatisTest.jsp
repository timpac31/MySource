<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import= "xml.dao.IbatisDao, java.util.List, xml.dao.IbatisBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	IbatisDao dao = new IbatisDao();
	IbatisBean bean = new IbatisBean();
	bean.setSeq(183);
	List<IbatisBean> geduList = dao.getAll(bean);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>Insert title here</title>
</head>
<body>
<c:set var ="geduList" value="<%=geduList %>"/>
	<c:forEach items="${geduList }" var="data" varStatus="index">
		<table>
			<tr>
				<td>${data.name }</td>
				<td>${data.regDate }</td>
				<td>${data.remark }</td>
				<td>${data.applyNum }</td>
			</tr>		
		</table>
	</c:forEach>

</body>
</html>
