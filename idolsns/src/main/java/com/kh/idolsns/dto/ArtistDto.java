package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 대표페이지(artist) DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArtistDto {
    private int artistNo;
    private String artistName;
    private String artistEngName;
    private String artistEngNameLower;
}
