package com.sw.fd.repository;

import com.sw.fd.entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface StoreRepository extends JpaRepository<Store, Integer> {
    Optional<Store> findBySno(int sno);
    List<Store> findByScate(String scate);
    List<Store> findAll();

/*----------------------다현씨 추가파트-------------------*/
    @Query("SELECT s FROM Store s WHERE s.sno IN :snoList")
    List<Store> findBySno(@Param("snoList") List<Integer> snoList);
}
