
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.awt.event.MouseEvent"%>
<%@page import="java.awt.event.InputEvent"%>
<%-- 
    Document   : displayGtk
    Created on : 12 May, 2011, 10:08:57 AM
    Author     : root
--%>

<%@page import="java.awt.Window"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows_de"%>
<%@page import="java.awt.event.KeyEvent"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Robot"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


      <%
String vcdfile="test.vcd";
String ws=(String)session.getAttribute("workspace");
String output=null;
Process p;
BufferedImage screenImage=null;

    String[] compile=new String[2];
    compile[0]="gtkwave";

    compile[1]=constants.Constants.PATH+ws+"/"+vcdfile;

Robot myRobot=new Robot();
if(System.getProperty("Lock")==null)System.setProperty("Lock","false");
String lock=System.getProperty("Lock");
while(lock.equals("true")){myRobot.delay(20);
lock=System.getProperty("Lock");
}
System.setProperty("Lock","true");
     p = Runtime.getRuntime().exec(compile);
//compile[0]="xdotool key 'alt+print'";
//Toolkit.getDefaultToolkit().getScreenSize()
 
try
  {
   myRobot.delay(3500);
myRobot.keyPress(KeyEvent.VK_CONTROL);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_A);
myRobot.keyRelease(KeyEvent.VK_CONTROL);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_A);
myRobot.keyPress(KeyEvent.VK_TAB);
myRobot.keyRelease(KeyEvent.VK_TAB);
myRobot.keyPress(KeyEvent.VK_TAB);
myRobot.keyRelease(KeyEvent.VK_TAB);
myRobot.keyPress(KeyEvent.VK_TAB);
myRobot.keyRelease(KeyEvent.VK_TAB);
myRobot.keyPress(KeyEvent.VK_SPACE);
myRobot.keyRelease(KeyEvent.VK_SPACE);
myRobot.keyPress(KeyEvent.VK_TAB);
myRobot.keyRelease(KeyEvent.VK_TAB);
myRobot.keyPress(KeyEvent.VK_CONTROL);
myRobot.keyPress(KeyEvent.VK_A);
myRobot.keyRelease(KeyEvent.VK_CONTROL);
myRobot.keyRelease(KeyEvent.VK_A);
myRobot.mouseMove(108, 950);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_A);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_A);
myRobot.delay(300);
myRobot.keyPress(KeyEvent.VK_ALT);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_Z);
myRobot.keyRelease(KeyEvent.VK_ALT);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_Z);
myRobot.delay(50);
myRobot.keyPress(KeyEvent.VK_ALT);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_Z);
myRobot.keyRelease(KeyEvent.VK_ALT);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_Z);
myRobot.delay(20);
myRobot.keyPress(KeyEvent.VK_ALT);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_Z);
myRobot.keyRelease(KeyEvent.VK_ALT);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_Z);
myRobot.delay(20);
String zl=(String)request.getParameter("zoom");
if(zl!=null){
int z=Integer.parseInt(zl);
while(z>0){
z--;
myRobot.delay(50);
myRobot.keyPress(KeyEvent.VK_ALT);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_Z);
myRobot.keyRelease(KeyEvent.VK_ALT);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_Z);
}

}
/*
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_A);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_A);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_A);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_A);
myRobot.keyPress(KeyEvent.VK_SHIFT);
myRobot.keyPress(KeyEvent.VK_A);
myRobot.keyRelease(KeyEvent.VK_SHIFT);
myRobot.keyRelease(KeyEvent.VK_A);*/
//compile=new String[3];
//compile[0]="xdotool";
//compile[1]="click";
//compile[2]="1";
//Runtime.getRuntime().exec(compile);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseMove(x+61, y+314);
//p = Runtime.getRuntime().exec(compile);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
//myRobot.keyPress(KeyEvent.VK_CONTROL);
//myRobot.keyPress(KeyEvent.VK_A);
//myRobot.keyRelease(KeyEvent.VK_CONTROL);
//myRobot.keyRelease(KeyEvent.VK_A);
//myRobot.mouseMove(x+110,y+605);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
//myRobot.mouseMove(x+179,y+69);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
//myRobot.mousePress(InputEvent.BUTTON1_MASK);
//myRobot.mouseRelease(InputEvent.BUTTON1_MASK);
screenImage=myRobot.createScreenCapture(new Rectangle(225,97,1001, 750));
screenImage.createGraphics();
myRobot.keyPress(KeyEvent.VK_ALT);
myRobot.keyPress(KeyEvent.VK_F4);
myRobot.keyRelease(KeyEvent.VK_ALT);
myRobot.keyRelease(KeyEvent.VK_F4);
session.setAttribute("image", screenImage);


int w = 2 * screenImage.getWidth();
int h = 2 * screenImage.getHeight();
 BufferedImage enlargedImage = new BufferedImage(w, h, screenImage.getType());

        for (int y=0; y < h; ++y)
            for (int x=0; x < w; ++x)
                enlargedImage.setRGB(x, y, screenImage.getRGB(x/2, y/2));

   for (int y=30; y < 49; ++y){
       for (int x=530; x < 578; ++x)
                  enlargedImage.setRGB(x, y, 0);
       for (int x=841; x < 890; ++x)
                  enlargedImage.setRGB(x, y, 0);
for (int x=1154; x < 1203; ++x)
                  enlargedImage.setRGB(x, y, 0);
       for (int x=1468; x < 1507; ++x)
                  enlargedImage.setRGB(x, y, 0);
for (int x=1781; x < 1822; ++x)
                  enlargedImage.setRGB(x, y, 0);

           }

  
 

 File outputfile = new File(constants.Constants.PATH+ws+"/saved.jpeg");
ImageIO.write(enlargedImage,"jpeg", outputfile);


out.print("<h5>Simulation completed......</h5> "
        + "Loading the timing diagram.....");
System.setProperty("Lock","false");
myRobot.delay(50);
response.sendRedirect("disgtk.jsp");
}
  catch(Exception e)
  {
   e.printStackTrace();
  }

      %>

    
     
    </body>
</html>
