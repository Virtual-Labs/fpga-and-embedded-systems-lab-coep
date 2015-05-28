<%@page import="extra.DbConnect"%>
<%@page import="java.sql.ResultSet"%><%@page import="java.sql.Statement"%><%@page import="java.sql.Connection"%><%@page contentType="text/html" pageEncoding="UTF-8"%><% Connection connection = null;
    try {
        DbConnect db = new DbConnect();
        connection = db.getConnect();
        Statement st = connection.createStatement();
        String id = request.getParameter("id");
        String expNo = (String) request.getParameter("expNo");
        if (expNo == null) {
            expNo = "1";
        }
        System.out.print("Experiment no=" + expNo);
        ResultSet rs = st.executeQuery("SELECT program FROM Programs WHERE ID=" + id + " AND expNo=" + expNo);
        String t = null;
        while (rs.next()) {
            t = (String) rs.getString(1);
        }
        out.print(t);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
