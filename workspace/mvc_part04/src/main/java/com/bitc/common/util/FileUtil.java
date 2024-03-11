package com.bitc.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;

/**
 * 파일 관련 요청에 대한 처리를 도와줄 class
 * upload, download, delete
 * @author admin
 *
 */
public class FileUtil {
	
	/**
	 * 날짜 별 디렉토리에 파일을 업로드 한 후
	 * 업로드된 디렉토리와 파일 이름을 문자열로 반환
	 */
								// 업로드 파일 저장 root 경로, 업로드할 파일 정보
	public static String uploadFile(String realPath, MultipartFile file) throws Exception{
		
		String uploadedFileName = "";
		// 동일 디렉토리에 동일한 이름의 파일 중복 최소화
		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString().replace("-", "");	// 하이픈 공백으로 대체
		String originalName = file.getOriginalFilename();
		savedName += "_"+(originalName.replace("_",""));	// 원본파일에 언더바 있을 경우 공백으로 대체
		System.out.println(savedName);
		
		// url 요청으로 전달된 파일 이름은 공백이 자동으로 +로 치환
		savedName = savedName.replace("+", " ");
		String datePath = calcPath(realPath);
		
		File f = new File(realPath+datePath, savedName);
		System.out.println(f.getAbsolutePath());
		file.transferTo(f);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		if(MediaUtil.getMediaType(formatName) != null) {
			// 이미지일 경우에는 썸네일 이미지 경로 반환
			uploadedFileName = makeThumbnail(realPath, datePath, savedName, formatName);
			
		}else {
			String fileName = datePath+File.separator+savedName;
			System.out.println(fileName);
			uploadedFileName = fileName.replace(File.separatorChar, '/');	// directory 구분자를 \ 에서 /로 변경
		}
		
		/*
		 * String fileName = datePath+File.separator+savedName;
		 * System.out.println(fileName); uploadedFileName =
		 * fileName.replace(File.separatorChar, '/'); // directory 구분자를 \ 에서 /로 변경
		 */		
		return uploadedFileName;
	}
	
	// 이미지일경우 썸네일 이미지 생성
	public static String makeThumbnail(
			String realPath,	// upload folder root 경로 
			String datePath,	// 년월일 경로
			String savedName, 	// upload된 원본 파일 이름
			String ext			// upload된 파일 확장자 명
			) throws Exception{
		String name = "";
		// 원본 이미지 정보 
		File file = new File(realPath+datePath, savedName);
		// ImageScalr는 BufferedImage 타입으로 이미지를 제어
		// ImageIO class는 javax package에서 Image타입의 파일을 쉽게 메모리로 읽거나 
		// 메모리의 파일 정보를 물리파일로 write 하는 method를 제공하는 class이다.
		BufferedImage origianlImage = ImageIO.read(file);
		
		// scalr 객체를 이용해서 원본 이미지를 복제한 Thmbnail 이미지 생성
		BufferedImage sourceImage = Scalr.resize(
											origianlImage, 				// 복제할 원본 이미지
											Scalr.Method.AUTOMATIC,		// 이미지 비율 지정(자동으로)
											Scalr.Mode.FIT_TO_HEIGHT, 	// 고정 높이 -> 고정높이를 기준으로 비율 지정
											100							// FIT 크기
											);
		String thumbnailImage = realPath+datePath+File.separator+"s_"+savedName;	// s_ 붙어있으면 썸네일 이미지
		// ImageIO.write(출력할 이미지 데이터, 파일 확장자, 출력 위치);						
		ImageIO.write(sourceImage, ext, new File(thumbnailImage));
		name = thumbnailImage.substring(realPath.length()).replace(File.separatorChar,'/');
		return name;
	}
	
	
	// /yyyy/MM/dd 형식의 요청 날짜별 디렉토리 생성
	public static String calcPath(String realPath) {
		
		String pattern = File.separator+"yyyy"+File.separator+"MM"+File.separator+"dd";
		LocalDate date = LocalDate.now();
		String datePath = date.format(
				DateTimeFormatter.ofPattern(pattern)
			);
		File file = new File(realPath, datePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		System.out.println(datePath);
		return datePath;
	}

	/**
	 * download 받기 위한 파일 데이터를 byte[]로 반환
	 */
	public static byte[] getBytes(String realPath, String fileName) throws Exception{
		File file = new File(realPath, fileName.replace('/', File.separatorChar));
		InputStream is = new FileInputStream(file);
		
		// since java 9 - 
		byte[]bytes = is.readAllBytes();
		is.close();
		return bytes;
		
		/*
		 * long length = file.length(); length = is.available(); // available : 읽을 수 있는
		 * 바이트 단위의 개수
		 * 
		 * byte[] bytes = new byte[(int)length]; for(int i = 0; i < bytes.length; i++) {
		 * bytes[i] = (byte)is.read(); } is.close();
		 * 
		 * return bytes;
		 */
	}
	
	/**
	 * 요청한 첨부 파일 정보에 따라 
	 * content - type이 추가된 Headers 정보 반환
	 */
	public static HttpHeaders getHeaders(String fileName) throws Exception{
		HttpHeaders headers = new HttpHeaders();
		// 파일 이름에서 확장자명 추출
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		
		// 추출된 확장자명 가지고 media 타입 호출
		MediaType m = MediaUtil.getMediaType(ext);
		if(m != null) {
			headers.setContentType(m);
		}else {
			headers = getOctectHeaders(fileName);
		}
		return headers;		
	}
	
	/**
	 * 이미지 파일이 아닐 경우는 브라우저를 통해 사용자 PC에 저장할 수 있도록 
	 * 해설할 수 없는 바이너리 데이터라고 인식할 수 있게 headers 정보 추가
	 */
	public static HttpHeaders getOctectHeaders(String fileName) throws Exception{
		HttpHeaders headers = new HttpHeaders();
		
		// application/octet-stream
		// octet 8비트 / 1byte 단뒤의 이진 데이터가 전송됨을 의미함
		// headers.add(Content-Type", "application/octet-stream");
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		fileName = fileName.substring(fileName.lastIndexOf("-") + 1);
		
		// Content-Disposition(배치 조치)
		// 응답헤더를 통해 컨텐츠가 브라우저에 인라인으로 표시되어야 하는지 
		// 웹페이지의 일부인지 또는 첨부파일인 배치 조치 여부를 나타내는 헤더
		// attachment;fileName="파일이름.jpg"
		// 다운 받을때 한글로 쓰면 iso이기 때문에 다 깨져서 utf로 변환해줌
		/*
		 * fileName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
		 * headers.add("Content-Disposition", "attachment=\""+fileName+"\"");
		 */
		ContentDisposition cd = ContentDisposition.attachment().filename(
										fileName, Charset.forName("UTF-8")).build();
		headers.setContentDisposition(cd);
		return headers;
	}
	
	/**
	 * 요청이 들어온 파일 삭제 
	 * /2024/02/21/s_a78fb89848374956ae0abb35fb25e739_cat1.jpg
		/2024/02/21/a68b7e6a06f54792bb19e677926181cb_data.hwp
		/2024/02/21/bec635e9d9254ffba862283cf46ce241_file1.txt
	 */
	public static boolean deleteFile(String realPath, String fileName) throws Exception{
		boolean isDeleted = false;
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		
		fileName = fileName.replace('/', File.separatorChar);
		File file = new File(realPath, fileName);
		isDeleted = file.delete();
		
		// 이미지 일 경우 썸네일만 삭제되어 파일도 삭제
		if(isDeleted && MediaUtil.getMediaType(ext) != null) {
			fileName = fileName.replace("s_", "");
			isDeleted = new File(realPath, fileName).delete();
		}
		return isDeleted;		
	}
	
}
