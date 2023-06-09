package com.semi4.utils;

import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class IbatisUtil {

	private static SqlMapClient sqlmap;

	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/semi4/ibatis/SqlMapConfig.xml");
			sqlmap = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static SqlMapClient getSqlmap() {
		return sqlmap;
	}

}
