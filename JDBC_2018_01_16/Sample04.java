package com.test;

import java.lang.reflect.*;

public class Sample04 {

	public static void main(String[] args) {
		
		//Class 클래스
		//- java.lang 패키지
		//- Class 클래스로 자바에서 제공하는 클래스의 메타 데이터를 분석할 수 있다.
		//- 메타 데이터는 클래스의 이름, 생성자 정보, 필드 정보, 메소드 정보를 말한다.
		//- forName() 메소드에 분석하고자 하는 (패키지 포함)클래스 지정.
		//- getName() 메소드는 클래스 이름 반환.
		//- getPackage() 메소드는 패키지 이름 반환.
		//- getDeclaredConstructors() 메소드는 생성자(들) 정보 반환.
		//- getDeclaredFields() 메소드는 필드(들) 정보 반환
		//- getDeclaredMethods() 메소드는 메소드(들) 정보 반환
		
		try {
			
			Class cla = Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println(cla.getName());
			System.out.println("-------------------");
			System.out.println(cla.getPackage());
			System.out.println("-------------------");
			Constructor[] constructors = cla.getDeclaredConstructors();
			for (Constructor constructor : constructors) {
				System.out.println(constructor.getName());
			}
			System.out.println("-------------------");
			Method[] methods = cla.getDeclaredMethods();
			for (Method method : methods) {
				System.out.println(method.getName());
			}
			System.out.println("-------------------");
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

}
