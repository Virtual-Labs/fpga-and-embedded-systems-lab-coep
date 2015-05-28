/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author root
 */
public class Test5 {

    public static void main(String[] a) {
        float f = 1.25f;
        int intBits = Float.floatToIntBits(f);
        int rawIntBits = Float.floatToRawIntBits(f);
//        System.out.printf("f = %f  intBits = %d  " +
//                          "rawIntBits = %d%n", f, intBits, rawIntBits);
        float toFloat = Float.intBitsToFloat(intBits);
//        System.out.printf("toFloat = %f%n", toFloat);

        int sign = intBits & 0x80000000;
        int exponent = intBits & 0x7f800000;
        int mantissa = intBits & 0x007fffff;
//        System.out.printf("sign = %d  exponent = %d  mantissa = %d%n",
//                           sign, exponent, mantissa);

        String binarySign = Integer.toBinaryString(sign);
        String binaryExponent = Integer.toBinaryString(exponent);
        String binaryMantissa = Integer.toBinaryString(mantissa);
//        System.out.printf("binarySign     = %s%nbinaryExponent = %s%n" +
//                          "binaryMantissa = %s%n", binarySign,
//                           binaryExponent, binaryMantissa);
//        
        double d = 10.36;
        long lbits = Double.doubleToLongBits(d);
        long signL = lbits & (long) 0x80000000;
        long exponentL = lbits & (long) 0x7f800000;
        long mantissaL = intBits & (long) 0x007fffff;
//        System.out.println("sign : "+Long.toBinaryString(signL));
//        System.out.println("exponent : "+Long.toBinaryString(exponentL));
//        System.out.println("mantissa : "+Long.toBinaryString(mantissaL));
//        
        String globalAnswer = "", globalHex = "";

        int d1 = (int) d;
        double fractional = d - d1;
        System.out.println("djkdjfkfjkdf : " + Integer.toBinaryString(d1));
        int sLen = 0;
        String full = Integer.toBinaryString(d1);
        sLen = full.substring(1).length();
        System.out.println("**********************\n Answer : " + new Test5().calculateBinary(fractional, 23 - sLen));

        String man = full.substring(1) + new Test5().calculateBinary(fractional, 23);
        String exp = Integer.toBinaryString((127 + sLen));
        globalAnswer = "0" + exp + man;
        int tempval = 0;
        for (int j = 0; j < globalAnswer.length() - 3; j = j + 4) {
            tempval = Integer.parseInt(globalAnswer.substring(j, j + 4), 2);
            System.out.println(globalAnswer.substring(j, j + 4));
            globalHex += Integer.toHexString(tempval);
        }
        System.out.println("///" + globalHex);


    }

    public String calculateBinary(double fractional, int nBits) {
        System.out.println("Fraction : " + fractional);
        double tempAns = fractional;
        String ans = "";
        int i = 1;
        while (tempAns != 1 && i <= nBits) {
            tempAns *= 2;
            ans += "" + (int) tempAns;
            System.out.println("Temp : " + (int) tempAns);
            tempAns -= (int) tempAns;
            i++;
        }



        return ans;
    }
}
