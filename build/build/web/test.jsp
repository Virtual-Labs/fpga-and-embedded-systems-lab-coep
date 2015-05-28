<%-- 
    Document   : test
    Created on : 18 May, 2011, 2:51:26 PM
    Author     : root
--%>
<%@page import="java.awt.Graphics"%>
<%@page import="gnu.jpdf.PDFJob"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="extra.Mails"%>
<%@page import="extra.SynthesisODIN"%>
<%@page import="java.util.*"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="extra.PreSysthesisParser"%>
<%@page import="extra.VerilogSyntaxPro"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="extra.DbConnect"%>
<%@page import="extra.ConfigFile"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="extra.TestBench"%>
<%@page import="java.util.regex.MatchResult"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="extra.CountUsers"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
     
        <script type="text/javascript">
            document.write("Hi.......");
        function collectname(){
            alert(document.f1.Name.value);
            document.getElementById("intro").innerHTML
          var rating="asdas";
        }  
        
       
        </script>
    </head>
    <body onload="">
        <form name="f1" > 
        Name: <input type="text" name="Name" value="" />
        <input type="submit" value="go"  onclick="collectname()">
        <select>
            <option >not selected......</option>
            <option selected>selected.......</option>
            <option >sdhfjkdshakjfhk..</option>
        </select>
        </form>
    </body>
</html>
