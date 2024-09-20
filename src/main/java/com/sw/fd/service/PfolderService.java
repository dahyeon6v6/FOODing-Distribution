package com.sw.fd.service;

import com.sw.fd.entity.Pfolder;
import com.sw.fd.repository.MemberRepository;
import com.sw.fd.repository.PfolderRepository;
import com.sw.fd.repository.PickRepository;
import com.sw.fd.repository.StoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PfolderService {

    @Autowired
    private PickRepository pickRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private StoreRepository storeRepository;

    @Autowired
    public PfolderRepository pfolderRepository;

    public List<Pfolder> getPfoldersByMno(int mno) {
        return pfolderRepository.findByMemberMno(mno);
    }

    public void savePfolder(Pfolder pfolder) {
        pfolderRepository.save(pfolder);
    }

    public void deletePfolderByPfno(int pfno) {
        pfolderRepository.delete(pfno);
    }

    public Pfolder findByPfno(int pfno) {
        return pfolderRepository.findByPfno(pfno).orElse(null);
    }

    public List<Pfolder> findPfoldersByPfnos(String pfnos) {
        String[] pfnoArray = pfnos.split(",");
        List<Integer> pfnoList = Arrays.stream(pfnoArray).map(Integer::parseInt).collect(Collectors.toList());
        return pfolderRepository.findByPfno(pfnoList);
    }
}
