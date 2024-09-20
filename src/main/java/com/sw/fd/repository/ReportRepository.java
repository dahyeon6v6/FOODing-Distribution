package com.sw.fd.repository;

import com.sw.fd.entity.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ReportRepository extends JpaRepository<Report, Integer>{
    Report findByRpno(int rpno);
}
