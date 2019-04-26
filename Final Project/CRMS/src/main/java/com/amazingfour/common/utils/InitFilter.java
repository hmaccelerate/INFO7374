package com.amazingfour.common.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Properties;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class InitFilter implements Filter {

	public void destroy() {
		System.out.println("Init Filter destroy");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		System.out.println("do Init Filter");
		
//		Properties prop = new Properties();
//		try {
//			prop.load(this.getClass().getClassLoader().getResourceAsStream("url.properties"));
//		} catch (IOException e1) {
//			throw new RuntimeException(e1);
//		}
//		//获得绝对地址
//		String url = prop.getProperty("URL");
//		
//		((HttpServletRequest) request).getSession().setAttribute( "url",url);
//		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {

		Properties prop = new Properties();
		InputStream in = getClass().getResourceAsStream("/url.properties");
		try {
			prop.load(in);
			 Enumeration en = prop.propertyNames();
             while (en.hasMoreElements()) {
              String key = (String) en.nextElement();
                    String Property = prop.getProperty (key);
                    filterConfig.getServletContext().setAttribute(key, Property);
                }
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
