package com.sw.fd.repository;

import com.sw.fd.entity.Store;
import com.sw.fd.entity.StoreTag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StoreTagRepository extends JpaRepository<StoreTag, Integer> {

    List<StoreTag> findByStore_Sno(int sno);
    List<StoreTag> findByTag_Tno(int tno);
    List<StoreTag> findByTag_tno(List<Integer> tnos);

    @Query("SELECT st FROM StoreTag st WHERE st.store.sno = :sno AND st.tag.tno = :tno")
    StoreTag findStoreTagByStoreSnoAndTagTno(@Param("sno") int sno, @Param("tno") int tno);
}
