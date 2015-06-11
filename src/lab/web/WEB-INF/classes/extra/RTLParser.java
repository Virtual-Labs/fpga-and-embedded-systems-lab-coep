/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package extra;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;



/**
 *
 * @author root
 */
public class RTLParser {
int and,nand,or,nor,xor,xnor,not,buf,bufif0,bufif1,notif0,notif1;
int wire;

    public int getAnd() {
        return and;
    }

    public void setAnd(int and) {
        this.and = and;
    }

    public int getBuf() {
        return buf;
    }

    public void setBuf(int buf) {
        this.buf = buf;
    }

    public int getBufif0() {
        return bufif0;
    }

    public void setBufif0(int bufif0) {
        this.bufif0 = bufif0;
    }

    public int getBufif1() {
        return bufif1;
    }

    public void setBufif1(int bufif1) {
        this.bufif1 = bufif1;
    }

    public int getNand() {
        return nand;
    }

    public void setNand(int nand) {
        this.nand = nand;
    }

    public int getNor() {
        return nor;
    }

    public void setNor(int nor) {
        this.nor = nor;
    }

    public int getNot() {
        return not;
    }

    public void setNot(int not) {
        this.not = not;
    }

    public int getNotif0() {
        return notif0;
    }

    public void setNotif0(int notif0) {
        this.notif0 = notif0;
    }

    public int getNotif1() {
        return notif1;
    }

    public void setNotif1(int notif1) {
        this.notif1 = notif1;
    }

    public int getOr() {
        return or;
    }

    public void setOr(int or) {
        this.or = or;
    }

    public int getWire() {
        return wire;
    }

    public void setWire(int wire) {
        this.wire = wire;
    }

    public int getXnor() {
        return xnor;
    }

    public void setXnor(int xnor) {
        this.xnor = xnor;
    }

    public int getXor() {
        return xor;
    }

    public void setXor(int xor) {
        this.xor = xor;
    }
public void gateParser(String ws,String filename) throws IOException{
String rtl=(String)this.getContent(ws, filename);
this.setAnd(this.countMatches(rtl, "and"));
this.setBuf(this.countMatches(rtl, "buf"));
this.setBufif0(this.countMatches(rtl, "bufif0"));
this.setBufif1(this.countMatches(rtl, "bufif1"));
this.setNand(this.countMatches(rtl, "Nand"));
this.setNor(this.countMatches(rtl, "nor"));
this.setNot(this.countMatches(rtl, "not"));
this.setNotif0(this.countMatches(rtl,"notif0"));
this.setNotif1(this.countMatches(rtl,"notif1"));
this.setOr(this.countMatches(rtl,"or"));
this.setXnor(this.countMatches(rtl,"xnor"));
this.setXor(this.countMatches(rtl,"xor"));
this.setWire(this.countMatches(rtl,"wire"));
}

public String  getContent(String ws,String filename) throws IOException{
File file = new File(constants.Constants.PATH+ws+"/"+filename+".synthesized.v");
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

public int countMatches(String str, String sub) {
           if (str.isEmpty() || sub.isEmpty()) {
               return 0;
            }
            int count = 0;
            int idx = 0;
     /*       while ((idx = str.indexOf(sub, idx)) !=-1) {
                count++;
                idx += sub.length();
            }*/
            String[] words=str.split(";");
            for(int i=0;i<words.length;i++){                
                System.out.println(words[i]+" count="+words[i].length());
                if(words[i].contains(sub+" "))count++;
            }

            return count;
        }
public String deleteWhitespace(String str) {
            if (str.isEmpty()) {
             return str;
           }
            int sz = str.length();
            char[] chs = new char[sz];
           int count = 0;
            for (int i = 0; i < sz; i++) {
                if (!Character.isWhitespace(str.charAt(i))) {
                    chs[count++] = str.charAt(i);
               }
            }
            if (count == sz) {
                return str;
            }
            return new String(chs, 0, count);
        }


}
