/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Lochana
 */
public class TESTJCLASS {

    public static void main(String[] args) {
        try {

            System.out.println(new Date());

            int i = Integer.valueOf(10);
            GregorianCalendar g = new GregorianCalendar();
            g.setTime(new Date());
            g.add(Calendar.DATE, i);

            System.out.println(g.getTime());

        } catch (Exception e) {
        }
    }

//    public Date EXPDate(int x) throws Exception {
//        int i = Integer.valueOf(x);
//        GregorianCalendar g = new GregorianCalendar();
//        g.setTime(new Date());
//        g.add(Calendar.MONTH, i);
//
//        return g.getTime();
//    }

}
