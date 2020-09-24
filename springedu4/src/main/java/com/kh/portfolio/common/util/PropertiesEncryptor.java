package com.kh.portfolio.common.util;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class PropertiesEncryptor {

	public static void main(String[] args) {
		StandardPBEStringEncryptor enc = new StandardPBEStringEncryptor();
		//�븫�샇�궎
		enc.setPassword("wjdtjdghk");
		
		//db�븫�샇�솕
	//	System.out.println(enc.encrypt("oracle.jdbc.driver.OracleDriver"));
		System.out.println(enc.encrypt("net.sf.log4jdbc.sql.jdbcapi.DriverSpy"));
//		System.out.println(enc.encrypt("jdbc:oracle:thin:@127.0.0.1:1521:xe"));
		System.out.println(enc.encrypt("jdbc:log4jdbc:oracle:thin:@127.0.0.1:1521:xe"));
		System.out.println(enc.encrypt("mycloset"));
		System.out.println(enc.encrypt("mycloset"));
		//mail�븫�샇�솕
		System.out.println(enc.encrypt("1404jsh@gmail.com"));
		System.out.println(enc.encrypt("wjdtjdghk3801"));
		
		//蹂듯샇�솕
		System.out.println(enc.decrypt("eapAp5DOvmae03TNmXUKz0VFsIvCp5Rb"));
	}

}
