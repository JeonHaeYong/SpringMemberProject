package kh.spring.dao;

import kh.spring.dto.MemberDTO;

public interface MemberDAO {
	public int insertMember(MemberDTO dto);

	public int isLoginOk(String id, String pw);
	
	public int idCheck(String id);
	
	public String getProfileImg(String id);
	
	public MemberDTO getMyPage(String id);
	
	public int deleteMember(String id);
	
	public int modifyMember(MemberDTO dto);
	
	public int modifyProfileImg(String profileImg, String id);
}
