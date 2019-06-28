package kh.spring.dao;

import java.util.List;
import java.util.Map;

import kh.spring.dto.BoardDTO;

public interface BoardDAO {
	public int insertArticle(BoardDTO dto);
	public List<BoardDTO> selectList(int fromIndex, int toIndex);
	public BoardDTO selectArticle(int seq);
	public void viewCounting(int seq);
	public void deleteArticle(int seq);
	public int getRecordTotalCount();
	public Map<String, Integer> getPageNavi(int currentPage, int recordTotalCount);
}
