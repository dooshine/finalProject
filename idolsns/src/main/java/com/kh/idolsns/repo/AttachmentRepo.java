package com.kh.idolsns.repo;

import com.kh.idolsns.dto.AttachmentDto;

public interface AttachmentRepo {
    int sequence();
    void insert(AttachmentDto attachmentDto);
    AttachmentDto selectOne(int attachmentNo);
    void delete(int attachmentNo);
}
