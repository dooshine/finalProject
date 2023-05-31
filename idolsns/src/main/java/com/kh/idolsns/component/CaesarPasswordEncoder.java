package com.kh.idolsns.component;

public interface CaesarPasswordEncoder {
	String encrypt(String origin);
	String decrypt(String value);
}