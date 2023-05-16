package com.kh.idolsns.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class AdminMemberSearchVO {
  private String memberId;
  private String memberNick;
  private Integer minPoint;
  private Integer maxPoint;
  private String memberEmail;
  private List<String> memberAgreeList;
  private String beginJoinDate;
  private String endJoinDate;
  private List<String> memberLevelList;
  private Integer searchLoginDays;

  private List<String> orderList;
}
