package com.tcs.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.sql.Date;
import java.text.SimpleDateFormat;

public class Utility {
	
	public static long numberOfDays(Date date) {
		java.util.Date now = new java.util.Date();// current time
        java.util.Date utilDate = new java.util.Date(date.getTime());
		
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");

        String before = format1.format(utilDate);
        String after= format1.format(now);
        
        LocalDate dateBefore = LocalDate.parse(before);
    	LocalDate dateAfter = LocalDate.parse(after);
    		
    	//calculating number of days in between
    	long noOfDaysBetween = ChronoUnit.DAYS.between(dateBefore, dateAfter);
		return noOfDaysBetween;
	}
	
	public static String today() {
		java.util.Date now = new java.util.Date();
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
        String today= format1.format(now);
        return today;
	}
}
