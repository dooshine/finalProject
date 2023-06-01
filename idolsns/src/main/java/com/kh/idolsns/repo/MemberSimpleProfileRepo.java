package com.kh.idolsns.repo;
import java.util.List;

import com.kh.idolsns.dto.MemberSimpleProfileDto;

public interface MemberSimpleProfileRepo {

	List<MemberSimpleProfileDto> profile(List<String> memberIdList);
}
