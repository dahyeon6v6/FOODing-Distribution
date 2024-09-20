package com.sw.fd.service;

import com.sw.fd.entity.Menu;
import com.sw.fd.repository.MenuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MenuService {

    @Autowired
    private MenuRepository menuRepository;

    public void saveMenu(Menu menu) {
        menuRepository.save(menu);
    }

    public List<Menu> getMenuBySno(int sno) {
        return menuRepository.findByStoreSno(sno);
    }
}
