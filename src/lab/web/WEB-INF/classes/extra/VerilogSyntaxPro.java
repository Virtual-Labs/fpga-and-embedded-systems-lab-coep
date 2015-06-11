/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package extra;

import java.io.*;
import java.util.StringTokenizer;

/**
 *
 * @author root
 */
public class VerilogSyntaxPro {
String strFileContent;
String module;
String validchar="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
public boolean  setContent(String ws,String filename){
File file = new File(constants.Constants.PATH+ws+"/"+filename+".vl");
try{
FileInputStream fin = new FileInputStream(file);
byte fileContent[] = new byte[(int)file.length()];
fin.read(fileContent);
strFileContent = new String(fileContent);
System.out.println("File content : "+strFileContent.trim());
fin.close();
return true;

}catch(FileNotFoundException e){
System.out.println("File not found" + e);
}
catch(IOException ioe){
System.out.println("Exception while reading the file " + ioe);
}
   return false;
}

public String checkModule(){
int i=0;
while(strFileContent.charAt(i)==' ')i++;
if(strFileContent.indexOf("endmodule")!=-1)
if(strFileContent.substring(i,strFileContent.indexOf("endmodule")-1).indexOf("module ")==-1){
return "can not find the module keyword at start of module";
} 
//while(strFileContent.charAt(i)==' ')i++;
//StringBuffer sb=new StringBuffer();
//i=strFileContent.indexOf("endmodule");
//if(i==-1) return "Could not find the keyword endmodule!!!!!";
//if(module)
return null;
}

public String beginEnd(){
if(strFileContent.contains("begin ")){
strFileContent.matches("");
}
return null;
}


}

