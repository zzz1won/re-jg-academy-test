package kr.disable.jugd.academy.utils;

import java.util.Random;

public class FunctionUtil {

	/** 영어 + 숫자 난수 생성 */
	public static String createRandom() throws Exception {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		int maxLength = 6; // maxLength +1(index) = 총 길이
		int index = 0;
		
		for(int i=0; i<=maxLength; i++) {
			index = random.nextInt(3);
			
			// ASCII
			switch(index) {
			case 0:
				// a~z
				sb.append((char) ((int)random.nextInt(26)+97) );
				break;
				
			case 1:
				// A~Z
				sb.append((char) ((int) random.nextInt(26)+65) );
				break;
				
			case 2:
				// 0~9
				sb.append(random.nextInt(10));
				break;
			}
		}
		
		return sb.toString();
	}
}
