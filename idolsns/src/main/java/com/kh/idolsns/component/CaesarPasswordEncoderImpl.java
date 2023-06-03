package com.kh.idolsns.component;

import org.springframework.stereotype.Component;

@Component
public class CaesarPasswordEncoderImpl implements CaesarPasswordEncoder {

    private int offset = 3;

    @Override
    public String encrypt(String origin) {
        StringBuilder buffer = new StringBuilder();
        for (int i = 0; i < origin.length(); i++) {
            char ch = origin.charAt(i);
            ch += offset;
            buffer.append(ch);
        }
        return buffer.toString();
    }

    @Override
    public String decrypt(String value) {
        StringBuilder buffer = new StringBuilder();
        for (int i = 0; i < value.length(); i++) {
            char ch = value.charAt(i);
            ch -= offset;
            buffer.append(ch);
        }
        return buffer.toString();
    }
    
}