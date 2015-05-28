/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package extra;

import java.io.*;

/**
 *
 * @author root
 */
public class PreSysthesisParser {
  public String  getContent(String ws,String filename) throws IOException{
File file = new File("/root/Temp/"+ws+"/"+filename+".vl");
try{
FileInputStream fin = new FileInputStream(file);
byte fileContent[] = new byte[(int)file.length()];
fin.read(fileContent);
String strFileContent = new String(fileContent);
System.out.println("File content : "+strFileContent.trim());
     return strFileContent;
}catch(FileNotFoundException e){
System.out.println("File not found" + e);
}
catch(IOException ioe){
System.out.println("Exception while reading the file " + ioe);
}
   return null;
}
  public String  parse(String ws,String filename){

  return "sdfsd";
  }
}
