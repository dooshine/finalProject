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
public class TagCntSearchVO {
    private List<String> tagTypeList;
    private String target;
}
