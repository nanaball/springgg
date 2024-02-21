package com.bitc.file.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

/**
 * 확장자를 이용하여 
 * Image File type을 MediaType으로 구분하여 반환하는 객체
 * @author admin
 */
public class MediaUtil {
	
	private static Map<String, MediaType> mediaMap;		// mediaType = mytype
	
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);		// image/jpg == jpeg
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);		// image/jpeg
		mediaMap.put("PNG", MediaType.IMAGE_JPEG);		// image/png
		mediaMap.put("GIF", MediaType.IMAGE_JPEG);		// image/gif
	}

	/**
	 * 
	 * @param ext - 업로드된 파일 확장자명
	 * @return - key 값이 확장자랑 일치하는 MediaType 객체 반환
	 */
	public static MediaType getMediaType(String ext) {
		return mediaMap.get(ext.toUpperCase());
	}
}
