/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package extra;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;
import javax.servlet.http.HttpSession;


/**
 *
 * @author root
 */
public class ConfigFile {
 public boolean createConfig(String ws,String filename) throws IOException{
        String conf="-t:dll\n"
                + "flag:syn-rules\n"
                + "flag:cprop\n"
                + "flag:nodangle\n"
                + "flag:arch=stratix\n"
                + "flag:gdb_spin_point=yes\n"
                + "flag:lib="+constants.Constants.PATH + "ODIN/verilog-20040606/tgt-odin/tech_lib.xml\n"
                + "flag:dynamic_debug_file="+constants.Constants.PATH + "ODIN/verilog-20040606/tgt-odin/dynamic_debug_file.xml\n"
                + "flag:optimization_file="+constants.Constants.PATH + "ODIN/verilog-20040606/tgt-odin/optimization_file.xml\n"
                + "out:"+constants.Constants.PATH + ws+"/"+filename+".synthesized.v";
        Writer output = null;
        try{
        File file = new File(constants.Constants.PATH +ws+"/config_file.txt");
  output = new BufferedWriter(new FileWriter(file));
  output.write(conf);
  output.close();
     return true;
        } catch(Exception e){
     System.out.print(" Caught in exception in class createConfig: "+e);
     }
 return false;
 }

 public String generateRTL(String ws,String filename) throws IOException{
System.out.println("file name:-"+filename);
String output=null;
Process p;
if (filename!=null){
    //String[] cmd = new String[2];
//			cmd[0]="cd";
//			cmd[1]="Temp";
//p = Runtime.getRuntime().exec(cmd);
//    /root/Temp/ODIN/verilog-20040606/./ivl -C /root/Temp/4/config_file.txt /root/Temp/4/hello.vl

    String[] compile=new String[4];
    compile[0]=constants.Constants.PATH + "ODIN/verilog-20040606/./ivl";
    compile[1]="-C";
    compile[2]=constants.Constants.PATH +ws+"/config_file.txt";
    compile[3]=constants.Constants.PATH  +ws+"/"+filename+".vl";
    p = Runtime.getRuntime().exec(compile);
			BufferedReader br = new BufferedReader(new InputStreamReader(p.getErrorStream()));
			String line = "";
			//OutputStream os=new FileOutputStream("/home/pranav/Desktop/om/Report.txt");
			StringBuffer sb=new StringBuffer();
			while((line=br.readLine())!=null){
				System.out.println(line);
				sb.append(line+" \n");
			}
		 output=new String(sb);

System.out.print("output recorded"+output);
return output;
}
return null;
 }

}
