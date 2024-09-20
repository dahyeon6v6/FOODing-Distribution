package com.sw.fd.controller;

import com.sw.fd.dto.GroupDTO;
import com.sw.fd.dto.MemberGroupDTO;
import com.sw.fd.entity.Board;
import com.sw.fd.entity.Member;
import com.sw.fd.entity.MemberGroup;
import com.sw.fd.entity.Write;
import com.sw.fd.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class BoardController {
    @Autowired
    private GroupService groupService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private WriteService writeService;

    @GetMapping("/board")
    public String showBoard(@RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "10") int size,
                            HttpServletRequest request, HttpSession session,Model model) {
        Integer gno = Integer.parseInt(request.getParameter("gno"));

        session.setAttribute("gno", gno);
        GroupDTO group = groupService.getGroupById(gno);
        List<Board> boards = boardService.getBoardByGroupGno(gno);



        if (boards.isEmpty()) {
            model.addAttribute("error", "해당 모임에 게시판이 없습니다.");
            return "board";
        }
        int bno = boards.get(0).getBno();
        List<Write> writes= writeService.getWritesByBoardBnoWithPagination(bno, page, size);
        int totalWrites = writeService.countWritesByBoardBno(bno);
        int totalPages = (int) Math.ceil((double) totalWrites / size);


        if (gno != null) {
            try{
                if (group != null) {
                    model.addAttribute("boardWrite", boards);
                    model.addAttribute("board", boards.get(0));
                    model.addAttribute("writes", writes);
                    model.addAttribute("currentPage", page);
                    model.addAttribute("totalPages", totalPages);
                }else{
                    model.addAttribute("error", "찾을 수 없는 모임");
                }
            } catch (NumberFormatException e) {
                model.addAttribute("error", e.getMessage());
            }
        }else {
            model.addAttribute("error", "모임 번호가 없음");
        }

        return "board";
    }
}
