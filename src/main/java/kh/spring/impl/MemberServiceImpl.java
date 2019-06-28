package kh.spring.impl;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.spring.dao.MemberDAO;
import kh.spring.dto.MemberDTO;
import kh.spring.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO mdao;
	
	@Transactional("txManager")
	public int insertService(MemberDTO dto) {
		return mdao.insertMember(dto);
	}
	
	@Transactional("txManager")
	public int isLoginOkService(String id, String pw) {
		return mdao.isLoginOk(id, pw);
	}
	
	@Transactional("txManager")
	public int idCheckService(String id) {
		return mdao.idCheck(id);
	}
	
	@Transactional("txManager")
	public String profileImgService(String id, String profileImg) {
		String result = mdao.getProfileImg(id);
		mdao.modifyProfileImg(profileImg, id);
		return result;
	}
	
	@Transactional("txManager")
	public MemberDTO getMyPageService(String id) {
		return mdao.getMyPage(id);
	}
	
	@Transactional("txManager")
	public int deleteService(String id) {
		return mdao.deleteMember(id);
	}
	
	@Transactional("txManager")
	public int modifyService(MemberDTO dto) {
		return mdao.modifyMember(dto);
	}
	
}
