package com.kh.idolsns.repo;

import com.kh.idolsns.dto.MemberFollowCntDto;

public interface MemberFollowCntRepo {

	MemberFollowCntDto followCnt(String memberId);
}
