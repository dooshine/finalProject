package com.kh.idolsns.restcontroller;

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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.repo.AttachmentRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/attachment")
public class AttachmentRestController {
    //준비물
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private CustomFileuploadProperties fileUploadProperties;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	//업로드
	@PostMapping("/upload")
	public AttachmentDto upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
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
			
			return attachmentRepo.selectOne(attachmentNo);//DTO를 반환
		}
		
		return null;//또는 예외 발생
	}
	
	//다운로드
	@GetMapping("/download/{attachmentNo}")
	public ResponseEntity<ByteArrayResource> download(
									@PathVariable int attachmentNo) throws IOException {
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
		
//		제공되는 모든 상수와 명령을 동원해서 최대한 오류 없이 편하게 작성
		return ResponseEntity.ok()
//					.header(HttpHeaders.CONTENT_TYPE, 
//							MediaType.APPLICATION_OCTET_STREAM_VALUE)
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
}
