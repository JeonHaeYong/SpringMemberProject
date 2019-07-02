package kh.spring.service;

import java.util.List;
import java.util.Map;

import kh.spring.dto.BoardDTO;

public interface BoardService {
	public int insertService(BoardDTO dto);
	public List<BoardDTO> selectListService(int fromIndex, int toIndex);
	public BoardDTO selectArticleService(int seq);
	public void deleteArticleService(int seq);
	public void modifyArticle(BoardDTO dto);
	public Map<String, Integer> getPageNaviService(int currentPage);
}
