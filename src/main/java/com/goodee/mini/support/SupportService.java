package com.goodee.mini.support;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SupportService {

	@Autowired
	private SupportDao supportDao;
	
	public int savePayRequest(SupportVO supportVO) throws Exception {
		return supportDao.savePayRequest(supportVO);
	}
	
	public int updatePayRequest(SupportVO supportVO) throws Exception {
       return supportDao.updatePayRequest(supportVO);
    }
}
