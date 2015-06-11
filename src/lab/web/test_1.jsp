<%@page language="java" import="co.in.coep.tutorial.services.*,java.util.*"%>


hello

<%co.in.coep.dao.hibernate.SpringHibernateDAO hiberSpringDAO = (co.in.coep.dao.hibernate.SpringHibernateDAO) ServiceFinder.getContext(request)
				.getBean("SpringHibernateDao");%>
