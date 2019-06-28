package kh.spring.practice;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.spring.dto.MemberDTO;
import kh.spring.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberService ms;
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "loginForm";
	}
	
	@RequestMapping("/loginProc")
	public String loginProc(String id, String pw, Model model) {
		int result = ms.isLoginOkService(id, pw);
		if(result > 0) {
			session.setAttribute("loginId", id);
			System.out.println(session.getAttribute("loginId") + " 로그인!");
		}
		model.addAttribute("result", result);
		return "alertLogin";
	}
	
	@RequestMapping("/joinForm")
	public String joinForm() {
		return "joinForm";
	}
	
	@ResponseBody
	@RequestMapping("/idCheck")
	public String idCheck(String id) {
		int result = ms.idCheckService(id);
		if(result > 0) {
			return "X";
		}else {
			return "O";
		}
	}
	
	@RequestMapping("/joinProc")
	public String joinProc(MemberDTO dto, MultipartFile image, Model model) {
		String resourcePath = session.getServletContext().getRealPath("/resources");
		System.out.println(resourcePath);
		long currTime = System.currentTimeMillis();
		try {
			image.transferTo(new File(resourcePath + "/" + dto.getId() + "/" + currTime + "_image.png"));
		}catch(Exception e) {
			e.printStackTrace();
		}
		dto.setProfileImg("/resources/" + dto.getId() + "/" + currTime + "_image.png");
		int result = ms.insertService(dto);
		model.addAttribute("result", result);
		return "alertJoin";
	}
	
	@RequestMapping("/myPage")
	public String myPageLogin(HttpServletRequest request, Model model) {
		model.addAttribute("dto", ms.getMyPageService((String)session.getAttribute("loginId")));
		return "myPage";
	}
	
	@RequestMapping("/logout")
	public String logoutLogin(HttpServletRequest request) {
		session.invalidate();
		return "alertLogout";
	}
	
	@RequestMapping("/signOut")
	public String signOutLogin(HttpServletRequest request, Model model) {
		int result = ms.deleteService((String)session.getAttribute("loginId"));
		if(result > 0) {
			session.invalidate();
		}
		model.addAttribute("result", result);
		return "alertSignOut";
	}
	
	@RequestMapping("/modifyForm")
	public String modifyFormLogin(HttpServletRequest request, Model model) {
		model.addAttribute("dto", ms.getMyPageService((String)session.getAttribute("loginId")));
		return "modifyForm";
	}
	
	@RequestMapping("/modify")
	public String modifyLogin(HttpServletRequest request, MemberDTO dto, Model model) {
		dto.setId((String)session.getAttribute("loginId"));
		int result = ms.modifyService(dto);
		model.addAttribute("result", result);
		return "alertModify";
	}
	
	@ResponseBody
	@RequestMapping("/modifyProfileImg")
	public String modifyProfileImgLogin(HttpServletRequest request, MultipartFile image) {
		String id = (String)session.getAttribute("loginId");
		String resourcePath = session.getServletContext().getRealPath("/resources");
		long currTime = System.currentTimeMillis();
		String imagePath = "/resources/" + id + "/" + currTime + "_image.png";
		String oriPath = ms.profileImgService(id, imagePath).replaceFirst("/resources", "");
		new File(resourcePath + oriPath).delete();
		try {
			image.transferTo(new File(resourcePath + "/" + id + "/" + currTime + "_image.png"));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return imagePath;
	}
	
	@RequestMapping("/webchat")
	public String webchatLogin(HttpServletRequest request) {
		return "webchat";
	}
}
