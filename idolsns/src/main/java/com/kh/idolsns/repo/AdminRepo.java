package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.MemberProfileFollowDto;
import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.vo.AdminMemberSearchVO;
import com.kh.idolsns.vo.TagCntSearchVO;

public interface AdminRepo {
    // 전체 tag 불러오기
	List<TagDto> adminTagSelectList();
    // 태그 수정(태그이름)
    boolean updateTagTypeByName(TagDto tagDto);
    // tag 삭제하기(태그이름)
    boolean adminTagDelete(String tagName);
    // 태그 사용량 조회
    List<TagCntDto> adminTagCntSelectList(TagCntSearchVO tagCntSearchVO);

    // 모든 회원목록 조회
	List<MemberProfileFollowDto> adminSelectMemberList(AdminMemberSearchVO adminMemberSearchVO);
}
