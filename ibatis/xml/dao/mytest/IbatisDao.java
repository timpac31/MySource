package xml.dao.mytest;

import java.util.List;

import xml.dao.AbstractDAO;

public class IbatisDao extends AbstractDAO {
	
	//��� ��������
	public List<IbatisBean> getAll(IbatisBean param) throws Exception{
		return (List<IbatisBean>)sqlMap.queryForList("MyTest.getAll", param);
	}

	public IbatisBean getDetail(int seq) throws Exception{
		return (IbatisBean)sqlMap.queryForObject("MyTest.getDetail" , seq);
	}
		
}





