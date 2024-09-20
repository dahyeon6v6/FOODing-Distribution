package com.sw.fd.repository;

import com.sw.fd.entity.Group;
import com.sw.fd.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface GroupRepository extends JpaRepository<Group, Integer> {
    Optional<Group> findByGno(int gno);

    @Query(value = "SELECT g.* FROM group_table g JOIN join_t j ON g.gno = j.gno WHERE j.mno = :mno", nativeQuery = true)
    List<Group> findGroupsByMember(@Param("mno") int mno);
}
