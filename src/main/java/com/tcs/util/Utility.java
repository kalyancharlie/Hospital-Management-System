package com.tcs.util;

import java.time.LocalDate;
import java.time.Period;
import java.util.Date;

public class Utility {
	public static int numberOfDays(Date date) {
		LocalDate prev = LocalDate.of(date.getYear(), date.getMonth(), date.getDay());
		 LocalDate now = LocalDate.now();
		int numDays = Period.between(prev, now).getDays();
		return numDays;
	}
}
