package com;


import java.util.List;



import org.springframework.jdbc.core.JdbcTemplate;

public class PopuDao {
private JdbcTemplate jtl=null;
      public JdbcTemplate getJtl(){
    	  return jtl;
      }
	public void setJtl(JdbcTemplate jtl) {
		this.jtl = jtl;
	}
	public int queryForInt(String selectsql){
		return jtl.queryForInt(selectsql);
	}

}
