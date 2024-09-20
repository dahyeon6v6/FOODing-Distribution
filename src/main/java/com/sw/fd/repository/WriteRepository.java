package com.sw.fd.repository;

import com.sw.fd.entity.Board;
import com.sw.fd.entity.Write;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface WriteRepository extends JpaRepository<Write, Integer> {

    List<Write> findByBoardBno(int bno);
    int countByBoardBno(int bno);

    Optional<Object> findByWno(int wno);
}
