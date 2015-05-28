
import JavaFiles.Calculations;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author root
 */
public class Test3 {
    
    public static void main(String []s)
    {
        System.out.println("Hex of 127 "+Integer.toBinaryString(12));
        System.out.println("Hex of 1023 "+Integer.toBinaryString(115));
        System.out.println("Hex of 31"+Integer.toBinaryString(31));
        
        
        System.out.println("--------------------"+Integer.parseInt(""+Float.floatToRawIntBits(0.48f)));
        
        
        String st="12.115";
        String lax=new Calculations().calculateBinary(0.115, 23);
        float fp=Float.parseFloat(st);
        int fp1=Integer.parseInt(st.split("\\.")[0]);
        int fp2=Integer.parseInt(st.split("\\.")[1]);
        String expo=Integer.toBinaryString(fp1);
        String mant=Integer.toBinaryString(fp2);
        int lax1=expo.length();
        if(lax1<8){
            for(int i=0;i<8-lax1;i++){
                expo="0"+expo;
            }
        }
        mant=lax;
        lax1=mant.length();
        if(lax1<23){
            for(int i=0;i<23-lax1;i++){
                mant=mant+"0";
            }
        }
        System.out.println("======"+expo+"  "+mant+"   "+Integer.parseInt("0"+expo+lax, 2));
    }
    
}
