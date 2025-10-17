package com.lgy.YoRiZoRi.detail_review.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ImageDTO {
	private String idx;
	private String name;
	private byte[] img;

	public void insert_imageModel(String idx, String name, byte[] img) {
		this.idx = idx;
		this.name = name;
		this.img = img;
	}
}

