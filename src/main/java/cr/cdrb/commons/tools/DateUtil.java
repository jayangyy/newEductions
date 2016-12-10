/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.commons.tools;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author Jayang
 *
 * 日期操作类
 */
public class DateUtil {

    public static int CompareDate(Date item1, Date item2) {
        return item1.compareTo(item2);
    }

    public static int CompareDate(String item1, String item2) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.CHINA);
        Date d1 = sdf.parse(item1);
        Date d2 = sdf.parse(item2);
        return d1.compareTo(d2);
    }

    public static Boolean CompareDate(String item1, String item2, String citem) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.CHINA);
        Date d1 = sdf.parse(item1);
        Date d2 = sdf.parse(item2);
        Date d3 = sdf.parse(citem);
        return d3.compareTo(d1) >= 0 && d2.compareTo(d3) >= 0;
    }

    public static Date CovertToDate(String item) throws Throwable {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.CHINA);
        return sdf.parse(item);
    }

    public static String FormatDate(Date date, String format, Locale local) {
        SimpleDateFormat sdf = new SimpleDateFormat(format, local);
        return sdf.format(date);
    }

    public static String FormatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.CHINA);
        return sdf.format(date);
    }

    ///
    public static String FormatDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.CHINA);
        return sdf.format(new Date());
    }

    //获取两日期相差天数
    public static Integer GetCompareDays(String item1, String item2) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.CHINA);
        Date d1 = sdf.parse(item1);
        Date d2 = sdf.parse(item2);
        long diff = d2.getTime() - d1.getTime();
        long days = diff / (1000 * 60 * 60 * 24);
        return Integer.parseInt(String.valueOf(days));   
    }
}
