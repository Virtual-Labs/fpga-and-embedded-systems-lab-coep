/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package extra;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author root
 */
public class VcdParse {
    int limit;
    int clockTime;
String []vcd=null;
String []bitMap=null;
 Map<Object,String> mp=null; 
    public int getClockTime() {
        return clockTime;
    }

    public int getLimit() {
        return limit;
    }

    public Map<Object, String> getMp() {
        return mp;
    }

    public String[] getVcd() {
        return vcd;
    }
   
    public void setVcd(String ws){
    try{
  // Open the file that is the first 
  // command line parameter
  FileInputStream fstream = new FileInputStream("/root/Temp/"+ws+"/test.vcd");
  // Get the object of DataInputStream
  DataInputStream in = new DataInputStream(fstream);
  BufferedReader br = new BufferedReader(new InputStreamReader(in));
  String strLine;
  //Read File Line By Line
StringBuffer sb=new StringBuffer();

  while ((strLine = br.readLine()) != null)   {
sb.append(strLine+"   "); 
       // Print the content on the console
    }
String final1=new String (sb);
vcd=final1.split("   "); 
in.close();
    }catch (Exception e){//Catch exception if any
  System.err.println("Error: " + e.getMessage());
  }
    }
public void setTick(String ws){
try{
  // Open the file that is the first 
  // command line parameter
  FileInputStream fstream = new FileInputStream("/root/Temp/"+ws+"/test.vcd");
  // Get the object of DataInputStream
  DataInputStream in = new DataInputStream(fstream);
  BufferedReader br = new BufferedReader(new InputStreamReader(in));
  String strLine;
  //Read File Line By Line
StringBuffer sb=new StringBuffer();

  while ((strLine = br.readLine()) != null)   {
sb.append(strLine+"   "); 
       // Print the content on the console
    }
String final1=new String (sb);
String []vcd=final1.split("   "); 
sb=new StringBuffer();
for(int i=0;i<vcd.length;i++){
if(vcd[i].matches("#([0|1|2|3|4|5|6|7|8|9])+")){
sb.append(vcd[i]);
   //System.out.println(vcd[i]);
}
}
final1=new String (sb);
String clk[]=final1.split("#");
for(int i=0;i<clk.length;i++){
//System.out.println("i="+i+"; "+clk[i]);
}
int u=Integer.parseInt(clk[2].replace("#",""));
int l=Integer.parseInt(clk[1].replace("#",""));
in.close();
clockTime=u-l;

limit=Integer.parseInt(clk[clk.length-1].replace("#",""));

  //Close the input stream
  
    }catch (Exception e){//Catch exception if any
  System.err.println("Error: " + e.getMessage());
  }
   }
public void setSignals(String ws){
     
try{
  // Open the file that is the first 
  // command line parameter
  FileInputStream fstream = new FileInputStream("/root/Temp/"+ws+"/test.vcd");
  // Get the object of DataInputStream
  DataInputStream in = new DataInputStream(fstream);
  BufferedReader br = new BufferedReader(new InputStreamReader(in));
  String strLine;
  //Read File Line By Line
StringBuffer sb=new StringBuffer();

  while ((strLine = br.readLine()) != null)   {
sb.append(strLine+"   "); 
       // Print the content on the console
    }
String final1=new String (sb);
String []vcd=final1.split("   "); 
sb=new StringBuffer();
boolean flag=true; 
for(int i=0;i<vcd.length;i++){

if(vcd[i].contains("$scope") && flag){
    i++; int j=i;
    while(!vcd[j].contains("$scope")){sb.append(vcd[j]+"   ");System.out.println(vcd[j]+"<br>");j++;}
   flag=false;   
}
}
final1=new String (sb);
String clk[]=final1.split("   ");
bitMap=clk;
mp=new HashMap<Object, String>();

for(int i=0;i<clk.length;i++){
clk[i]=clk[i].replace("$end","");
String[] temp=clk[i].split(" ");
if(temp.length<=5){
    //System.out.println(temp[3]+"="+temp[4]);
mp.put(temp[3],temp[4]);
}
else{
    mp.put(temp[3],temp[4]+temp[5]);
//System.out.println(temp[3]+"="+temp[4]+temp[5]);
}
}
//int u=Integer.parseInt(clk[2].replace("#",""));
//int l=Integer.parseInt(clk[1].replace("#",""));
in.close();

    }catch (Exception e){//Catch exception if any
  System.err.println("Error: " + e.getMessage());
  }
}
public String [] fillSignals(String symbol){
int fEnteredClock=0; int value;
int maxcount=(limit+clockTime)/clockTime;
String []signal=new String[maxcount];
int signalCount=0;

    for(int i=0;i<vcd.length;i++){
if(vcd[i].matches("#([0|1|2|3|4|5|6|7|8|9])+")){
//System.out.println(vcd[i]);
    signalCount++;
    fEnteredClock=1;
    i++; int ul=i;
    if(!(signalCount==maxcount))
    while(!vcd[ul+1].matches("#([0|1|2|3|4|5|6|7|8|9])+"))ul++;
    else ul=vcd.length-1; 
    System.out.println("Signals in the signalCount"+signalCount+" are "+(maxcount));
    for(int j=i;(j<=ul && j<vcd.length);j++){ //System.out.println(vcd[j]+" length="+vcd[j].length());
    if(vcd[j].endsWith(symbol)){signal[signalCount-1]=vcd[j].replace(symbol,"").trim();
    //System.out.println("signal["+(signalCount-1)+"]="+signal[signalCount-1]);
    }
    }
    i=ul;
}
    
}
return signal;
}
public String [] carryAhead(String[] signal){
    String value=null;
for(int i=0;i<signal.length;i++){
 if(signal[i]!=null){
value=signal[i];
 }else {
if(value!=null)
 signal[i]=value;
    }
System.out.print(i+"="+signal[i]); 
}    
    
    return signal;
}

public int isOneBit(String name){
String[] temp=null;
System.out.println("Is called for "+name);
for(int i=0;i<bitMap.length;i++){
System.out.println(bitMap[i].trim());
    temp=bitMap[i].split(" ");

if(bitMap[i].contains(name) | bitMap[i].replace(" ","").contains(name)){
System.out.println("isOneBit Returned "+name+" as ("+bitMap[i]+") "+temp[2]);
    return Integer.parseInt(temp[2]);
}
    

}
return 0;
}


}
