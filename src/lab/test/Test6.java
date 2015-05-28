
import JavaFiles.Calculations;
import java.math.MathContext;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author root
 */
public class Test6 {
 
    public static void main(String args[])
    {
        short i=-5;
        long l=Long.parseLong(Float.floatToIntBits(-2.0f)+"",2 );
        System.out.println("\n\n"+l+"\n\n");
        System.out.println(Integer.toHexString(i));
        long laxt=new Calculations().convertToFixPoint("90.0",23,8);
       // System.out.println(Long.parseLong(Integer.toBinaryString(i).substring(16),2 ));
        System.out.println("value : "+Long.toHexString(laxt)+"  "+laxt);
    }
    
}

