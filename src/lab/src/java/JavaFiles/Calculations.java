/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JavaFiles;

/**
 *
 * @author root
 */
public class Calculations {

    public String twosForExp5(int lax) {
        String ans = "";
        ans = Integer.toBinaryString(lax);
        if (ans.length() < 8) {
        }


        return ans;

    }

    public long convertToFixPoint(String fpnum, int mantissa, int exp) {
        long laxt = 0;
        int sign = 0;
        float fp = Float.parseFloat(fpnum);

        if (fp < 0) {
            sign = 1;
        }
        int fp1 = Integer.parseInt(fpnum.split("\\.")[0]);
        int fp2 = Integer.parseInt(fpnum.split("\\.")[1]);
        String expo = Integer.toBinaryString(Math.abs(fp1));
        //String mant=Integer.toBinaryString(fp2);
        String lax = new Calculations().calculateBinary(Float.valueOf("0." + fp2), mantissa);

        int lax1 = expo.length();
        if (lax1 < exp) {
            for (int i = 0; i < exp - lax1; i++) {
                expo = "0" + expo;
            }
        }
        laxt = Long.parseLong(sign + expo + lax, 2);
        return laxt;
    }

    public long convertToFixPoint2(String fpnum, int mantissa, int exp) {
        long laxt = 0;
        int sign = 0;
        float fp = Float.parseFloat(fpnum);

        if (fp < 0) {
            sign = 1;
        }
        int fp1 = Integer.parseInt(fpnum.split("\\.")[0]);
        String fp2 = fpnum.split("\\.")[1];
        String expo = Integer.toBinaryString(Math.abs(fp1));
        //String mant=Integer.toBinaryString(fp2);
        String lax = new Calculations().calculateBinary(Float.valueOf("0." + fp2), mantissa);
        //System.out.println("Lax binary : "+lax);

        //System.out.println("Lax binary comp: "+sign+expo+lax);

        /////////test//////////////
        if (sign == 1) {
            int l = lax.length();
            for (int i = 0; i < l; i++) {
                if (lax.charAt(i) == '1') {
                    lax = new Calculations().replaceCharAt(lax, i, '0');
                } else {
                    lax = new Calculations().replaceCharAt(lax, i, '1');
                }
            }
            for (int i = l - 1; i >= 0; i--) {
                if (lax.charAt(i) == '1') {
                    lax = new Calculations().replaceCharAt(lax, i, '0');
                } else {
                    lax = new Calculations().replaceCharAt(lax, i, '1');
                    break;
                }
            }
            //System.out.println("expo :"+expo);
            int l1 = expo.length();
            for (int i = 0; i < l1; i++) {
                if (expo.charAt(i) == '1') {
                    expo = new Calculations().replaceCharAt(expo, i, '0');
                } else {
                    expo = new Calculations().replaceCharAt(expo, i, '1');
                }
            }

            int lax1 = expo.length();
            if (lax1 < exp) {
                for (int i = 0; i < exp - lax1; i++) {
                    expo = "1" + expo;
                }
            }

        } //////////////////////
        else {
            int lax1 = expo.length();
            if (lax1 < exp) {
                for (int i = 0; i < exp - lax1; i++) {
                    expo = "0" + expo;
                }
            }
        }

        //System.out.println("Lax binary comp after: "+sign+expo+lax);
        laxt = Long.parseLong(sign + expo + lax, 2);
        return laxt;
    }

    public long convertToFixPoint3(String fpnum, int mantissa, int exp) {
        long laxt = 0;
        int sign = 0;
        float fp = Float.parseFloat(fpnum);

        int fp1 = Integer.parseInt(fpnum.split("\\.")[0]);
        System.out.println("fp1" + fp1);
        String fp2 = fpnum.split("\\.")[1];
        System.out.println("fp2" + fp2);
        String expo = Integer.toBinaryString(Math.abs(fp1));
        System.out.println("expo" + expo);
        String lax = new Calculations().calculateBinary(Float.valueOf("0." + fp2), mantissa);
        System.out.println("lax" + lax);
        int lax1 = expo.length();
        if (lax1 < exp) {
            for (int i = 0; i < exp - lax1; i++) {
                expo = "0" + expo;
            }
        }
        laxt = Long.parseLong(expo + lax, 2);
        System.out.println("expo" + expo);
        return laxt;
    }

    public long convertToFixPoint4(String fpnum, int mantissa, int exp) {
        long laxt = 0;
//        int sign=0;
//        float fp=Float.parseFloat(fpnum);
//        
//        if(fp<0)
//            sign=1;
        int fp1 = Integer.parseInt(fpnum.split("\\.")[0]);
        System.out.println("fp1 sec :" + fp1);
//        String fp2=fpnum.split("\\.")[1];
//        System.out.println("fp2 sec :"+fp2);
        String expo = Integer.toBinaryString(Math.abs(fp1));
        System.out.println("expo sec :" + expo);
        //String mant=Integer.toBinaryString(fp2);
//        String lax=new Calculations().calculateBinary(Float.valueOf("0."+fp2), mantissa);
//        System.out.println("lax sec :"+lax);
//        int lax1=expo.length();
//        if(lax1<exp){
//            for(int i=0;i<exp-lax1;i++){
//                expo="0"+expo;
//            }
//        }
//        System.out.println("expo sec :"+expo);
        laxt = Long.parseLong(expo, 2);
        return laxt;
    }

    public String convertToFixPoint5(String givenDecimal) {
        String globalHex = "";
        String decs[] = givenDecimal.split("\\.");
        System.out.println(givenDecimal + "/*/*/*/*/*/*/*/*/" + givenDecimal.split(".").length);

        Float myDec = Float.parseFloat(givenDecimal);



        int decs1 = Integer.parseInt(decs[0]);
        int decs2 = Integer.parseInt(decs[1]);

        String dec1 = Integer.toBinaryString(Math.abs(decs1));
        String dec2 = Integer.toBinaryString(decs2);

        dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23);
        System.out.println("-----------------------------" + dec2.length());
        // out.println(dec1 + "." + dec2);
        String ans = "";
        int exponent = 127;
        int shiftCount = dec1.length() - 1;
        int signBit = 0;
        int nlShifts = new Calculations().numberOfLeftShiftRequired(dec2);

        String mantissa = "";
        if (myDec > 0) {
            if (Math.abs(decs1) > 0) {
                mantissa = dec1.substring(1) + dec2;
                exponent += shiftCount;
                signBit = 0;
            }
            if (Math.abs(decs1) < 1) {
                dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23 + nlShifts);
                mantissa = dec2.substring(nlShifts);
                exponent -= nlShifts;
                signBit = 0;
            }
        } else {//FOR example 0.49

            if (Math.abs(decs1) > 0) {

                mantissa = dec1.substring(1) + dec2;
                exponent += shiftCount;
                signBit = 1;
            }
            if (Math.abs(decs1) < 1) {
                dec2 = new Calculations().calculateBinary((Math.abs(myDec) - Math.abs(decs1)), 23 + nlShifts);
                mantissa = dec2.substring(nlShifts);
                exponent -= nlShifts;
                signBit = 1;
            }
        }

        String expo = "";
        expo = Integer.toBinaryString(exponent);
        if (expo.length() < 8) {
            for (int i = 0; i < 8 - expo.length(); i++) {
                expo = "0" + expo;
            }
        }//exponent correction



        //mantissa correction
        if (mantissa.length() > 23) {
            mantissa = mantissa.substring(0, 23);
        }


        ans = signBit + expo + mantissa;
        System.out.println("Answer = " + ans + "   " + expo.length() + "     " + mantissa.length());

        String globalAnswer = ans;
        int tempval = 0;
        for (int j = 0; j < ans.length() - 3; j = j + 4) {
            tempval = Integer.parseInt(ans.substring(j, j + 4), 2);
            System.out.println(ans.substring(j, j + 4));
            globalHex += Integer.toHexString(tempval);
        }
        System.out.println("*/*/*/*/*///" + globalHex);

        return globalHex;
    }

    public String replaceCharAt(String s, int pos, char c) {

        return s.substring(0, pos) + c + s.substring(pos + 1);

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

    public int numberOfLeftShiftRequired(String dec2) {
        int cnt = 0;

        for (int i = 0; i < dec2.length(); i++) {
            if (dec2.charAt(i) == '1') {
                cnt = i + 1;
                break;
            }
        }

        return cnt;
    }

    public int[] leftShift(int[] arr, int num) {
        int j = 0;

        for (int i = 0; i < num; i++) {
            for (j = 0; j < arr.length - 1; j++) {
                System.out.println("----------------------" + j + " : " + arr[j] + " " + arr[j + 1]);
                arr[j] = arr[j + 1];
            }
            arr[j] = 0;
        }
        //for(int i=0;i<arr.length;i++)

        //System.out.println("----------------------"+arr[i]);
        return arr;
    }

    public int[] rightShift(int[] arr, int num) {
        int j = 0;
        for (int i = 0; i < num; i++) {
            for (j = arr.length - 1; j > 0; j--) {
                System.out.println("----------------------" + j + " : " + arr[j] + " " + arr[j - 1]);
                arr[j] = arr[j - 1];
            }
            arr[j] = 0;
        }

        return arr;
    }

    public String toString(int[] arr) {
        String myString = "";
        for (int i = 0; i < arr.length; i++) {
            myString += arr[i];
        }
        return myString;
    }

    public int[] toIntArray(String myString) {
        int[] arr = new int[myString.length()];
        for (int i = 0; i < myString.length(); i++) {
            arr[i] = Integer.valueOf(myString.charAt(i) + "");
        }
        return arr;
    }

    public int[] bitwiseAND(int[] arr1, int arr2[]) {
        int[] ans = new int[arr1.length];
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] == 0 || arr2[i] == 0) {
                System.out.println("....Coming...");
                ans[i] = 0;
            } else {
                ans[i] = 1;
            }
        }
        for (int i = 0; i < ans.length; i++) {
            //if(arr1[i]==0 || arr2[i]==0)
            System.out.println("---------" + arr1[i] + " " + arr2[i] + " " + ans[i]);
        }

        return ans;
    }

    public int[] bitwiseOR(int[] arr1, int arr2[]) {
        int[] ans = new int[arr1.length];
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] == 0 && arr2[i] == 0) {
                System.out.println("....Coming...");
                ans[i] = 0;
            } else {
                ans[i] = 1;
            }
        }
        for (int i = 0; i < ans.length; i++) {
            //if(arr1[i]==0 || arr2[i]==0)
            System.out.println("---------" + arr1[i] + " " + arr2[i] + " " + ans[i]);
        }

        return ans;
    }

    public int[] bitwiseXOR(int[] arr1, int arr2[]) {
        int[] ans = new int[arr1.length];
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] == arr2[i]) {
                System.out.println("....Coming...");
                ans[i] = 0;
            } else {
                ans[i] = 1;
            }
        }
        for (int i = 0; i < ans.length; i++) {
            //if(arr1[i]==0 || arr2[i]==0)
            System.out.println("---------" + arr1[i] + " " + arr2[i] + " " + ans[i]);
        }

        return ans;
    }

    public int[] bitwiseXNOR(int[] arr1, int arr2[]) {
        int[] ans = new int[arr1.length];
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] != arr2[i]) {
                System.out.println("....Coming...");
                ans[i] = 0;
            } else {
                ans[i] = 1;
            }
        }
        for (int i = 0; i < ans.length; i++) {
            //if(arr1[i]==0 || arr2[i]==0)
            System.out.println("---------" + arr1[i] + " " + arr2[i] + " " + ans[i]);
        }

        return ans;
    }

    public int[] bitwiseNOT(int[] arr1) {
        int[] ans = new int[arr1.length];
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] == 0) {
                System.out.println("....Coming...");
                ans[i] = 1;
            } else {
                ans[i] = 0;
            }
        }
        for (int i = 0; i < ans.length; i++) {
            //if(arr1[i]==0 || arr2[i]==0)
            System.out.println("---------" + arr1[i] + " " + " " + ans[i]);
        }

        return ans;
    }

    public double toDecimal(String s) {
//        int lax = s.length();
        double result = 0;
//        for (int i = 0; i < lax; i++) {
//            result = result + s.charAt(i) * Math.pow(2, (s.length() - i - 1));
//        }
        result = Integer.parseInt(s, 2);
        return result;
    }

    public boolean checkCaseEquality(int[] adata1, int adata2[]) {
        boolean lax = true;

        for (int l = 0; l < adata1.length; l++) {
            if (adata1[l] != adata2[l]) {
                lax = false;
                break;
            }
        }


        return lax;

    }

    public int reductionAND(int dat1[]) {
        int ans = 99;
        ans = dat1[0];
        for (int i = 0; i < dat1.length - 1; i++) {
            if (ans == 1 && dat1[i + 1] == 1) {
                ans = 1;
            } else {
                ans = 0;
            }
        }


        return ans;
    }

    public int reductionOR(int dat1[]) {
        int ans = 99;
        ans = dat1[0];
        for (int i = 0; i < dat1.length - 1; i++) {
            if (ans == 1 || dat1[i + 1] == 1) {
                ans = 1;
            } else {
                ans = 0;
            }
        }


        return ans;
    }

    public int reductionXOR(int dat1[]) {
        int ans = 99;
        ans = dat1[0];
        for (int i = 0; i < dat1.length - 1; i++) {
            if (ans == dat1[i + 1]) {
                ans = 0;
            } else {
                ans = 1;
            }
        }
        System.out.println("000000000000\\\\ " + ans);

        return ans;
    }

    public String calPointBinary(float decimal) {


        return "";
    }
}
