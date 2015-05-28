/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * PROGRAM TO EVALUATE THE EXPRESSION
 */
package JavaFiles;

import org.apache.commons.lang.StringUtils;

/**
 *
 * @author root
 */
public class ExpressionEvaluator {

    static char var1 = (char) 64;
    static String[] newExps = new String[100];
    //static String evals[];
    static int cnt;
    static String expr1 = "";

    public ExpressionEvaluator() {
        cnt=0;
        expr1="";
        var1=(char)64;
        for(int i=0;i<newExps.length;i++)
            newExps[i]=null;
    }

   

    public String[] evaluate(String evals[], String expr) {
        evals = expr.split(" ");
//        newExps=new String;
        expr1 = expr.trim();
        newExps[cnt++] = expr;
        //System.out.println("======== = * + - / % " + equal + " " + star + " " + plus + " " + minus + " " + slash + " " + per + " " + ++var1);

//        int len=evals.length;
//        for(int i=0;i<len;i++)
//        {
//            if(evals[i].equals("+"))
//            {
//                String rep=String.valueOf(var1);
//                System.out.println("coming here "+evals[i-1]+" + "+evals[i+1]+ " "+String.valueOf(var1)+" "+StringUtils.countMatches(expr1, evals[i-1]+" + "+evals[i+1]));
//                //expr1=expr1.replaceAll(evals[i-1]+" + "+evals[i+1], String.valueOf(var1));
//                //expr1=expr1.replaceAll(evals[i-1]+" + "+evals[i+1],rep);
//                expr1=StringUtils.replace(expr1, evals[i-1]+" + "+evals[i+1], String.valueOf(++var1));
//            }
//            
//        }
        // while(StringUtils.countMatches(newExps[cnt-1], "*")>0)
        replaceStars(evals, expr);
        //newExps[cnt++] = expr1;
        replaceSlash(expr1.split(" "), expr1);
       // newExps[cnt++] = expr1;
        replacePer(expr1.split(" "), expr1);
        //newExps[cnt++] = expr1;
        replacePlus(expr1.split(" "), expr1);
       // newExps[cnt++] = expr1;
        replaceMinus(expr1.split(" "), expr1);
       // newExps[cnt] = expr1;
        for (int i = 0; i < cnt; i++) {
            System.out.println("=--=-=-=-=" + newExps[i]);
        }
        return newExps;

    }

    void replaceStars(String evals[], String expr) {
        //expr1=expr.trim();
        int len = evals.length;
        for (int i = 0; i < len; i++) {
            if (evals[i].equals("*")) {
                //expr1=expr1;
                String rep = String.valueOf(++var1);
                expr1 = StringUtils.replace(expr1, evals[i - 1] + " * " + evals[i + 1], rep);
                newExps[cnt++] = rep + " = " + evals[i - 1] + " * " + evals[i + 1];
                break;

            }

        }
        if (StringUtils.countMatches(expr1, "*") > 0) {
            replaceStars(expr1.split(" "), expr1);
        }
        //System.out.println(expr1);
    }

    void replacePlus(String evals[], String expr) {
        //expr1=expr.trim();
        int len = evals.length;
        for (int i = 0; i < len; i++) {
            if (evals[i].equals("+")) {
                //expr1=expr1;
                String rep = String.valueOf(++var1);
                expr1 = StringUtils.replace(expr1, evals[i - 1] + " + " + evals[i + 1], rep);
                newExps[cnt++] = rep + " = " + evals[i - 1] + " + " + evals[i + 1];
                break;

            }

        }
        if (StringUtils.countMatches(expr1, "+") > 0) {
            replacePlus(expr1.split(" "), expr1);
        }
        //System.out.println(expr1);
    }

    void replaceSlash(String evals[], String expr) {
        //expr1=expr.trim();
        int len = evals.length;
        for (int i = 0; i < len; i++) {
            if (evals[i].equals("/")) {
                //expr1=expr1;
                String rep = String.valueOf(++var1);
                expr1 = StringUtils.replace(expr1, evals[i - 1] + " / " + evals[i + 1], rep);
                newExps[cnt++] = rep + " = " + evals[i - 1] + " / " + evals[i + 1];
                break;

            }

        }
        if (StringUtils.countMatches(expr1, "/") > 0) {
            replaceSlash(expr1.split(" "), expr1);
        }
        //System.out.println(expr1);
    }

    void replaceMinus(String evals[], String expr) {
        //expr1=expr.trim();
        int len = evals.length;
        for (int i = 0; i < len; i++) {
            if (evals[i].equals("-")) {
                //expr1=expr1;
                String rep = String.valueOf(++var1);
                expr1 = StringUtils.replace(expr1, evals[i - 1] + " - " + evals[i + 1], rep);
                newExps[cnt++] = rep + " = " + evals[i - 1] + " - " + evals[i + 1];
                break;

            }

        }
        if (StringUtils.countMatches(expr1, "-") > 0) {
            replaceMinus(expr1.split(" "), expr1);
        }
        //System.out.println(expr1);
    }

    void replacePer(String evals[], String expr) {
        //expr1=expr.trim();
        int len = evals.length;
        for (int i = 0; i < len; i++) {
            if (evals[i].equals("%")) {
                //expr1=expr1;
                String rep = String.valueOf(++var1);
                expr1 = StringUtils.replace(expr1, evals[i - 1] + " % " + evals[i + 1], rep);
                newExps[cnt++] = rep + " = " + evals[i - 1] + " % " + evals[i + 1];
                break;

            }

        }
        if (StringUtils.countMatches(expr1, "%") > 0) {
            replaceMinus(expr1.split(" "), expr1);
        }
        //System.out.println(expr1);
    }
}
