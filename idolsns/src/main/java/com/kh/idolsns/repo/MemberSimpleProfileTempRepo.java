package com.kh.idolsns.repo;
import java.util.List;

import com.kh.idolsns.dto.MemberSimpleProfileTempDto;

public interface MemberSimpleProfileTempRepo {

	List<MemberSimpleProfileTempDto> profile(List<String> memberIdList);
	
}
