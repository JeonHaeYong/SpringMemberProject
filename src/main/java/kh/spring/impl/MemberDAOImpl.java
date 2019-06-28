package kh.spring.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kh.spring.dao.MemberDAO;
import kh.spring.dto.MemberDTO;

@Component
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSessionTemplate sst;
	
	public int insertMember(MemberDTO dto) {
		return sst.insert("MemberDAO.insert", dto);
	}

	public int isLoginOk(String id, String pw) {
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		dto.setPw(pw);
		Integer result = sst.selectOne("MemberDAO.isLoginOk", dto);
		return sst.selectOne("MemberDAO.isLoginOk", dto);
	}
	
	public int idCheck(String id) {
		return sst.selectOne("MemberDAO.idCheck", id);
	}
	
	public String getProfileImg(String id) {
		return sst.selectOne("MemberDAO.getProfileImg", id);
	}
	
	public MemberDTO getMyPage(String id) {
		return sst.selectOne("MemberDAO.getMyPage", id);
	}
	
	public int deleteMember(String id) {
		return sst.delete("MemberDAO.deleteMember", id);
	}
	
	public int modifyMember(MemberDTO dto) {
		return sst.update("MemberDAO.modifyMember", dto);
	}
	
	public int modifyProfileImg(String profileImg, String id) {
		MemberDTO dto = new MemberDTO();
		dto.setProfileImg(profileImg);
		dto.setId(id);
		return sst.update("MemberDAO.modifyProfileImg", dto);
	}
}
