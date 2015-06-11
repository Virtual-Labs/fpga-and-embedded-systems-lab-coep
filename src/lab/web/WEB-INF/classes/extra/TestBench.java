/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package extra;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.regex.*;
import org.apache.catalina.Session;

/**
 *
 * @author root
 */
public class TestBench {

String strFileContent;
String arguments[];
String module;

    public String getModule() {
        return module;
    }

    public String getStrFileContent() {
        return strFileContent;
    }

public boolean getTestBenchFile(String ws,String filename) throws IOException{
if(strFileContent!=null){
arguments=this.getArguments();
System.out.print(" number of arguments="+arguments.length);
}
return true;
}

public boolean  setContent(String ws,String filename){
File file = new File(constants.Constants.PATH+ws+"/"+filename+".vl");
try{
FileInputStream fin = new FileInputStream(file);
byte fileContent[] = new byte[(int)file.length()];
fin.read(fileContent);
strFileContent = new String(fileContent);
System.out.println("File content : "+strFileContent.trim());
     return true;
}catch(FileNotFoundException e){
System.out.println("File not found" + e);
}
catch(IOException ioe){
System.out.println("Exception while reading the file " + ioe);
}
   return false;
}



public String[] getArguments(){
if(strFileContent!=null){
 // Create a pattern to match breaks
int i=strFileContent.indexOf("module")+6;
i++;
while(strFileContent.codePointAt(i)==' '){i++;}
while(strFileContent.codePointAt(i)!='('){
if(strFileContent.codePointAt(i)==';')return null;
    i++;}
i++;
int start=i;

while(strFileContent.codePointAt(i)!=')'){i++;}
int end=i;

System.out.println("arguments: "+strFileContent.substring(start, end));
String sub=strFileContent.substring(start, end);
String args[]=sub.split(",");
return args;
}
return null;
}

public boolean setModule(){
if(strFileContent!=null){
 // Create a pattern to match breaks
int i=strFileContent.indexOf("module")+6;
i++;
while(strFileContent.codePointAt(i)==' '){i++;}
int start=i;

while(strFileContent.codePointAt(i)!='('){i++;}
int end=i;




String sub=strFileContent.substring(start, end);
module=strFileContent.substring(start,end);
System.out.println("module ="+module);
return true;
}
return false;
}

}//class end
