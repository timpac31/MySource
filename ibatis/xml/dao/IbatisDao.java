package xml.dao;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class IbatisDao {
	
	private SqlMapClient sqlMap = null;
	
	public IbatisDao() throws IOException {
		Reader reader = Resources.getResourceAsReader("xml/SqlMapConfig.xml");
		sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
	}
	
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





