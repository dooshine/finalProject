package com.kh.idolsns.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.repo.AttachmentRepo;

@Controller
public class AttachmentController {
    @Autowired
	private CustomFileuploadProperties fileuploadProperties;

	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
	}
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	// 파일업로드
	@PostMapping("/upload3")
	public String upload3(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		/*System.out.println(attach.isEmpty());
		System.out.println("name = " + attach.getName());
		System.out.println("original file name = " + attach.getOriginalFilename());
		System.out.println("content type = " + attach.getContentType());
		System.out.println("size = " + attach.getSize());*/
		
		if(!attach.isEmpty()) {//파일이 있을 경우
			//번호 생성
			int attachmentNo = attachmentRepo.sequence();
			
			//파일 저장(저장 위치는 임시로 생성)
			File target = new File(dir, String.valueOf(attachmentNo));//파일명=시퀀스
			attach.transferTo(target);
			
			//DB 저장
			attachmentRepo.insert(AttachmentDto.builder()
							.attachmentNo(attachmentNo)
							.attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType())
							.attachmentSize(attach.getSize())
						.build());
		}
		return "redirect:/";
	}


	// 파일 업로드 & 다른 테이블 연계
	// @PostMapping("/upload4")
	// public String upload4(
	// 		@ModelAttribute PocketmonDto pocketmonDto,
	// 		@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
	// 	//1.포켓몬 등록
	// 	pocketmonDao.insert(pocketmonDto);
		
	// 	if(!attach.isEmpty()) {
	// 		//2.첨부파일 저장 및 등록(첨부파일이 있으면)
	// 		int attachmentNo = attachmentDao.sequence();
			
	// 		File target = new File(dir, String.valueOf(attachmentNo));
	// 		attach.transferTo(target);//저장
			
	// 		attachmentDao.insert(AttachmentDto.builder()
	// 					.attachmentNo(attachmentNo)
	// 					.attachmentName(attach.getOriginalFilename())
	// 					.attachmentType(attach.getContentType())
	// 					.attachmentSize(attach.getSize())
	// 				.build());
			
	// 		//3.포켓몬과 첨부파일 정보를 연결(첨부파일이 있으면)
	// 		pocketmonImageDao.insert(PocketmonImageDto.builder()
	// 					.pocketmonNo(pocketmonDto.getNo())
	// 					.attachmentNo(attachmentNo)
	// 				.build());
	// 	}
		
	// 	return "redirect:/";
	// }

	// 첨부파일 조회
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> download(
			@RequestParam int attachmentNo) throws IOException {
		//DB 조회
		AttachmentDto attachmentDto = attachmentRepo.selectOne(attachmentNo);
		if(attachmentDto == null) {//없으면 404
			return ResponseEntity.notFound().build();
		}	
		
		//파일 찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//헤더와 바디를 설정하며 ResponseEntity를 만들어 반환
		return ResponseEntity.ok()
			.contentType(MediaType.APPLICATION_OCTET_STREAM)
			.contentLength(attachmentDto.getAttachmentSize())
			.header(HttpHeaders.CONTENT_ENCODING, 
										StandardCharsets.UTF_8.name())
			.header(HttpHeaders.CONTENT_DISPOSITION,
				ContentDisposition.attachment()
							.filename(
									attachmentDto.getAttachmentName(), 
									StandardCharsets.UTF_8
							).build().toString()
			)
			.body(resource);
	}
	
	// 업로드 모달창을 띄위기 위한 사이트
	@GetMapping("post/test")
	public String test() {
		return "post/test";
	}

	// 업로드 모달창 뷰로 구현중 (5.16)
	@GetMapping("post/vuetest")
	public String vuetest() {
		return "post/vuetest";
	}
}
