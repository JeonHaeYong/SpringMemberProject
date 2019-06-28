package kh.spring.service;

import kh.spring.dto.MemberDTO;

public interface MemberService {
	
	public int insertService(MemberDTO dto);
	
	public int isLoginOkService(String id, String pw);
	
	public int idCheckService(String id);
	
	public String profileImgService(String id, String profileImg);
	
	public MemberDTO getMyPageService(String id);
	
	public int deleteService(String id);
	
	public int modifyService(MemberDTO dto);
}
