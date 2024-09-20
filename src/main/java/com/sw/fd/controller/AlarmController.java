package com.sw.fd.controller;

import com.sw.fd.entity.Member;
import com.sw.fd.service.AlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class AlarmController {

    @Autowired
    private AlarmService alarmService;

//    @GetMapping("/top")
//    public String getTopPage(HttpSession session, Model model) {
//        Member loggedInMember = (Member) session.getAttribute("loggedInMember");
//        System.out.println("get Controller 들어왔음");
//        if (loggedInMember != null) {
//            boolean hasAlarms = alarmService.hasAlarms(loggedInMember);
//            System.out.println("hasAlarms  = " + hasAlarms);
//            model.addAttribute("hasAlarms", hasAlarms);
//        }
//
//        return "top"; // 반환할 JSP 페이지 이름
//    }
}
