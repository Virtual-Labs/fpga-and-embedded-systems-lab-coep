
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author root
 */
public class Test1 {

    public static void main(String args[]) {
        FileReader fr = null;
        FileWriter fw = null;
        try {
            byte k = 8;
            System.out.println("Hex : " + Integer.toBinaryString(k));
            //      System.out.println("Hex : " + Long.parseLong("11111111111111111111111111111110",16));
            //System.out.println("Hex : " + Long.toHexString(Long.valueOf(Integer.toBinaryString(-3))));
//            File f = new File("/root/laxp.txt");
//            File f1 = new File("/root/laxk.txt");
            File f = new File("e:/laxp.txt");
            File f1 = new File("e:/laxk.txt");
            f1.createNewFile();
            String eachline = "lax", wrline = "";
            fr = new FileReader(f);
            fw = new FileWriter(f1);
            BufferedReader br = new BufferedReader(fr);
            BufferedWriter bw = new BufferedWriter(fw);
            while (eachline != null) {

                eachline = br.readLine();
                System.out.println(eachline);
                wrline = "+\"\\n" + eachline + "\"";
                bw.write(wrline + "\n");
            }

            br.close();
            bw.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Test1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Test1.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {

                fr.close();
                fw.close();
            } catch (IOException ex) {
                Logger.getLogger(Test1.class.getName()).log(Level.SEVERE, null, ex);
            }
        }


    }
}
