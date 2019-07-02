package kh.spring.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;

@Component
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSessionTemplate sst;

	// 3. 한 페이지에 몇 개의 글이 보이게 할 것인지
	public static int recordCountPerPage = 10;
	// 4. 한 페이지에 네비게이터가 총 몇 개가 보이게 할 것인지
	public static int naviCountPerPage = 5;

	public int insertArticle(BoardDTO dto) {
		return sst.insert("BoardDAO.insert", dto);
	}

	public List<BoardDTO> selectList(int fromIndex, int toIndex) {
		Map<String, Integer> param = new HashMap<>();
		param.put("startNavi", fromIndex);
		param.put("endNavi", toIndex);
		return sst.selectList("BoardDAO.selectList", param);
	}

	public BoardDTO selectArticle(int seq) {
		return sst.selectOne("BoardDAO.selectArticle", seq);
	}

	public void viewCounting(int seq) {
		sst.update("BoardDAO.updateViewCount", seq);
	}
	
	public void deleteArticle(int seq) {
		sst.delete("BoardDAO.deleteArticle", seq);
	}
	
	public void modifyArticle(BoardDTO dto) {
		sst.update("BoardDAO.updateArticle", dto);
	}
	
	public int getRecordTotalCount() {
		return sst.selectOne("BoardDAO.getRecordTotalCount");
	}

	public Map<String, Integer> getPageNavi(int currentPage, int recordTotalCount) {
		// 가지고 있는 게시글의 수에 맞는 페이지의 개수를 구함.
		int pageTotalCount = recordTotalCount / recordCountPerPage;
		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount++;
		}
		// 현재 페이지 오류 검출 및 정정
		if(currentPage < 1) {
			currentPage = 1;
		}
		else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		// 네비게이터 시작과 끝
		int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage - 1);
		// 네비 끝값이 최대 페이지 번호를 넘어가면 최대 페이지번호로 네비 끝값을 설정한다.
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		int needPrev = 1;	// 1이면 true, -1이면 false
		int needNext = 1;

		if(startNavi == 1) {
			needPrev = -1;
		}
		if(endNavi == pageTotalCount) {
			needNext = -1;
		}
		
		int fromIndex = (currentPage*recordCountPerPage)-(recordCountPerPage-1);
		int toIndex = currentPage*recordCountPerPage;

		if(toIndex > recordTotalCount) {
			toIndex = recordTotalCount;
		}

		Map<String, Integer> pageNavi = new HashMap<>();
		pageNavi.put("currentPage", currentPage);
		pageNavi.put("recordTotalCount", recordTotalCount);
		pageNavi.put("recordCountPerPage", recordCountPerPage);
		pageNavi.put("naviCountPerPage", naviCountPerPage);
		pageNavi.put("pageTotalCount", pageTotalCount);
		pageNavi.put("startNavi", startNavi);
		pageNavi.put("endNavi", endNavi);
		pageNavi.put("needPrev", needPrev);
		pageNavi.put("needNext", needNext);
		pageNavi.put("fromIndex", fromIndex);
		pageNavi.put("toIndex", toIndex);

		return pageNavi;
	}

}
