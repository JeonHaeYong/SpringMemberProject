package kh.spring.practice;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.spring.dto.BoardDTO;
import kh.spring.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService bs;

	@Autowired
	private HttpSession session;

	@RequestMapping("/board")
	public String board(HttpServletRequest request, int currentPage) {
		Map<String, Integer> pageNavi = bs.getPageNaviService(currentPage);
		List<BoardDTO> list = bs.selectListService(pageNavi.get("fromIndex"), pageNavi.get("toIndex"));
		request.setAttribute("list", list);
		request.setAttribute("pageNavi", pageNavi);
		return "board";
	}

	@RequestMapping("/writeForm")
	public String writeFormLogin(HttpServletRequest request) {
//		session.setAttribute("flag", false);
		System.out.println(session.getAttribute("flag"));
		return "writeForm";
	}

	@ResponseBody
	@RequestMapping("/imageUpload")
	public String imageUploadLogin(HttpServletRequest request, MultipartFile image) {
		String id = (String)session.getAttribute("loginId");
		System.out.println(id);
		String resourcePath = session.getServletContext().getRealPath("/resources");
		System.out.println(resourcePath);
		long currTime = System.currentTimeMillis();
		String imagePath = "/resources/" + id + "/" + currTime + "_board_image.png";

		try {
			image.transferTo(new File(resourcePath + "/" + id + "/" + currTime + "_board_image.png"));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return imagePath;
	}

	@ResponseBody
	@RequestMapping("/deleteImage")
	public String deleteImageLogin(HttpServletRequest request, String imagePath) {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println(session.getAttribute("flag"));
		String resourcePath = session.getServletContext().getRealPath("/");
		//		boolean flag = (boolean)session.getAttribute("flag");
		System.out.println(resourcePath);

		//		if(!flag) {
		if(imagePath.startsWith("http")) {
			imagePath = imagePath.replaceAll("http://.+?/", "");
		}
		String deletePath = resourcePath + imagePath;
		new File(deletePath).delete();
		//		}

		//		session.setAttribute("flag", false);
		return null;
	}

	@RequestMapping("/write")
	public String writeLogin(HttpServletRequest request, BoardDTO dto) {
		//		session.setAttribute("flag", true);
		System.out.println(session.getAttribute("flag"));
		dto.setWriter((String)session.getAttribute("loginId"));
		request.setAttribute("result", bs.insertService(dto));
		return "alertWrite";
	}

	@RequestMapping("/read")
	public String read(HttpServletRequest request, int seq, int currentPage) {
		request.setAttribute("dto", bs.selectArticleService(seq));
		request.setAttribute("currentPage", currentPage);
		return "read";
	}

	@RequestMapping("/deleteArticle")
	public String deleteArticleLogin(HttpServletRequest request, int seq) {
		bs.deleteArticleService(seq);
		return "redirect:board?currentPage=1";
	}
}
