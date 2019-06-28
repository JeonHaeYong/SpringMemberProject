package kh.spring.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;
import kh.spring.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO bdao;
	
	@Transactional("txManager")
	public int insertService(BoardDTO dto) {
		return bdao.insertArticle(dto);
	}
	@Transactional("txManager")
	public List<BoardDTO> selectListService(int fromIndex, int toIndex) {
		return bdao.selectList(fromIndex, toIndex);
	}
	@Transactional("txManager")
	public BoardDTO selectArticleService(int seq) {
		bdao.viewCounting(seq);
		return bdao.selectArticle(seq);
	}
	
	@Transactional("txManager")
	public void deleteArticleService(int seq) {
		bdao.deleteArticle(seq);
	}

	@Transactional("txManager")
	public Map<String, Integer> getPageNaviService(int currentPage) {
		return bdao.getPageNavi(currentPage, bdao.getRecordTotalCount());
	}
}
