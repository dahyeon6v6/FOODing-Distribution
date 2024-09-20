package com.sw.fd.repository;

import com.sw.fd.entity.Board;
import com.sw.fd.entity.Group;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;


public interface BoardRepository extends JpaRepository<Board, Integer> {

    List<Board> findByGroupGno(int gno);

    Board findByBno(int bno);

    // bno에 대한  gno를 반환받기 위해 작성(다혜)
    @Query("SELECT b.group.gno FROM Board b WHERE b.bno = :bno")
    int findGnoByBno(@Param("bno") int bno);
}
