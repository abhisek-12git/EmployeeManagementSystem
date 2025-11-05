package com.ems.util;

import java.util.Random;

public class IDGenerator {
	
	private static final String ALPHABETIC_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final int ALPHABETIC_LENGTH=3;
	private static final int NUMERIC_MIN_LENGTH=4;
	private static final int NUMERIC_MAX_LENGTH=7;
	private static final int NUMERIC_RANGE=NUMERIC_MAX_LENGTH - NUMERIC_MIN_LENGTH + 1;
	
	private static final Random RANDOM = new Random();
	
	public static String generateNewEmployeeId() {
		
		StringBuilder prefix =new StringBuilder();
		for(int i=0;i<ALPHABETIC_LENGTH; i++) {
			int index =RANDOM.nextInt(ALPHABETIC_CHARS.length());
			prefix.append(ALPHABETIC_CHARS.charAt(index));
		}
		
		int numericValue = RANDOM.nextInt(10000);
		String numericPart = String.format("%04d", numericValue);
		
		return prefix.toString() + numericPart;
	}

}
