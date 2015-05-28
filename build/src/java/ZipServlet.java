

import java.io.*;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.*;
import javax.servlet.http.*;

public class ZipServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and
<code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request,
HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/zip");
        response.setHeader("Content-disposition", "attachment;filename=selectedCases.zip");

        try {

            ZipOutputStream zipOutputStream = new
ZipOutputStream(response.getOutputStream());
        Vector<String> cases = findCases(request);
        String testpath = findPath(request);

        for(Iterator it = cases.iterator();it.hasNext();) {
                File tcase = new File(testpath + it.next());

               

        }
            zipOutputStream.flush();
            zipOutputStream.close();
        } catch (Exception e) {
        } finally {
        }
    }
    protected Vector<String> findCases(HttpServletRequest request)
       throws IOException
    {

    Vector<String> cases = (Vector<String>)request.getAttribute("tcases");

        return cases;
    }
    protected String findPath(HttpServletRequest request)
       throws IOException
    {

    String path = request.getParameter("path");

        return path;
    }

    private void addFilesToZip(File path, ZipOutputStream
zipOutputStream) {

        if (path.exists()) {
            File[] files = path.listFiles();
            for (int i = 0; i < files.length; i++) {
               
                    try {
                        FileInputStream in = new FileInputStream(files[i]);


                        zipOutputStream.putNextEntry(new ZipEntry( files[i].getName()));

                        byte buf[] = new byte[2048];
                        int len;
                        while ((len = in.read(buf)) > 0) {
                            zipOutputStream.write(buf, 0, len);
                        }
                        zipOutputStream.closeEntry();
                        in.close();

                    } catch (IOException e) {
                    }
                }
            }
        }
    }


    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
  

