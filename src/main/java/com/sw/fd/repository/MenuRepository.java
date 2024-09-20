package com.sw.fd.repository;

import com.sw.fd.entity.Menu;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MenuRepository extends JpaRepository<Menu, Integer> {
    List<Menu> findByStoreSno(int sno);
}
