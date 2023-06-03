package com.kh.idolsns.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.repo.AttachmentRepo;

@Service
public class AttachmentService {
    @Autowired
	private CustomFileuploadProperties fileUploadProperties;

    @Autowired
    private AttachmentRepo attachmentRepo;

    private File dir;

    @PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}

    // 파일 저장 & attachment 테이블 저장
    public void handleAttachment(int attachmentNo, MultipartFile attachment) throws IllegalStateException, IOException{
        //파일 저장(저장 위치는 임시로 생성)
        File target = new File(dir, String.valueOf(attachmentNo));//파일명=시퀀스
        attachment.transferTo(target);
        
        //DB 저장
        attachmentRepo.insert(AttachmentDto.builder()
                        .attachmentNo(attachmentNo)
                        .attachmentName(attachment.getOriginalFilename())
                        .attachmentType(attachment.getContentType())
                        .attachmentSize(attachment.getSize())
                    .build());
    }
}
