package com.bitc.file.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileController {

	@GetMapping("/")
	public String home() {return "home";}
	
	@GetMapping("uploadForm")
	public void uploadForm() {}
	
	
	// 포스트 방식으로 업로드 (멀티파트로) - 현재는 url만 가능하였으나 멀티파트로 가능하게됨
	@PostMapping("uploadForm")
	public String uploadFor(
					MultipartFile file,
					Model model) throws Exception {
		System.out.println(file);
		if(!file.isEmpty()) {
			System.out.printf("File Name : %s %n", file.getOriginalFilename());
			System.out.printf("File Size : %d %n", file.getSize());
			System.out.printf("File Type : %s %n", file.getContentType());
			
			File uploadDir = new File("c://Temp//upload");
			if(!uploadDir.exists()) {
				uploadDir.mkdirs();
				System.out.println(uploadDir.getAbsolutePath()+" 생성 완료");
			}
			// 업로드 시킬 파일 위치 경로
			File uploadFile = new File(uploadDir, file.getOriginalFilename());
			
			// 업로드된 파일의 정보를 저장하고 있는 객체 MultipartFile
			// file.transferTo(uploadFile);
			byte[] bytes = file.getBytes(); 
			String savedName = uploadFile(file.getOriginalFilename(), bytes);
			model.addAttribute("savedName",savedName);
			
			/*
			 * FileOutputStream fos = new FileOutputStream(uploadFile); 
			 * fos.write(bytes); 
			 * fos.flush(); 
			 * fos.close();
			 */
			
		}else {
			System.out.println("upload한 파일이 존재하지 않음");
		}
		return "uploadResult";
	}
	// 저장하려는 파일 이름이 중복일때
	public String uploadFile(String original, byte[] fileData) throws IOException{
		String savedName = "";
		// uuid = 랜덤하게 문자를 바꿔줌
		UUID uuid = UUID.randomUUID();
		// 총 32개의 랜덤한 문자 + 4개의 - 로 조합된 36개의 문자
		savedName = uuid.toString().replace("-", "")+"_"+original;
		System.out.println(savedName);
		
		// Spring에서 제공하는 파일 헬퍼 객체를 이용하여 지정된 위치에 파일 업로드
		FileCopyUtils.copy(fileData, new File("c:\\Temp\\upload", savedName));
		return savedName;
	}
}
