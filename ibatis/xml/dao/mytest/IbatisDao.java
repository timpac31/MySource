package xml.dao.mytest;


import java.sql.SQLException;
import java.util.List;

import xml.dao.AbstractDAO;

public class IbatisDao extends AbstractDAO{
	
	//목록 가져오기
	public List<IbatisBean> getAll(IbatisBean param) {
		List<IbatisBean> result = null;
		try {
			result = (List<IbatisBean>)sqlMap.queryForList("MyTest.getAll", param);
		} catch (SQLException e) {
			System.out.println("SQLException : " + e);
		} 
		return result;
	} 


}





