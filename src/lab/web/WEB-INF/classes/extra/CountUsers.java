package extra;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author root
 */
public class CountUsers {

    public int count() {
        File file = new File(constants.Constants.PATH);

        String[] children = file.list();

        return children.length;

    }

    public boolean createdir(String path) {
        boolean success = false;
        try {

            // if(!new File("/root/Temp").e)
            System.out.println(path + " " + new File(path).exists());

            success = (new File(path)).mkdir();



        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        return success;
    }

    public String[] files(String ws) {

        File file = new File(constants.Constants.PATH + ws);
        String[] children = file.list();
        return children;
    }

    public String getContent(String path) throws IOException {
        File file = new File(path);
        try {
            FileInputStream fin = new FileInputStream(file);
            byte fileContent[] = new byte[(int) file.length()];
            fin.read(fileContent);
            String strFileContent = new String(fileContent);
            System.out.println("File content : " + strFileContent.trim());
            return strFileContent;
        } catch (FileNotFoundException e) {
            System.out.println("File not found" + e);
        } catch (IOException ioe) {
            System.out.println("Exception while reading the file " + ioe);
        }
        return null;
    }
}
