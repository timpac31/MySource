package xml.dao;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;


public abstract class AbstractDAO {
	
	protected static SqlMapClient sqlMap = null;
	
	static {
		try {
			Reader reader = Resources.getResourceAsReader("xml/SqlMapConfig.xml");
			sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		} catch (IOException e) {
			throw new RuntimeException("ibatis reader error", e);
		}
	}
	
	public SqlMapClient getSqlMapInstance(){
		return sqlMap;
	}
	

}
