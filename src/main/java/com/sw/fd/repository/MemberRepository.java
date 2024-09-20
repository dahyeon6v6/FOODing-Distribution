package com.sw.fd.repository;

import com.sw.fd.entity.Member;
import org.apache.http.annotation.Contract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer> {


    Member findByMidAndMpass(String mid, String mpass);

    Optional<Member> findByMno(int mno);
    Optional<Member> findByMid(String mid);

    boolean existsByMid(String mid);
    boolean existsByMnick(String mnick);


    void deleteByMno(int mno);

    Member findByMnameAndMemail(String mname, String memail);
    Member findByMnameAndMphone(String mname, String mphone);
    boolean existsByMno(int mno);

    Optional<Member> findByMidAndMnameAndMemail(String mid,String mname, String memail);
}
