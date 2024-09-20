package com.sw.fd.service;

import com.sw.fd.entity.ReviewTag;
import com.sw.fd.entity.Tag;
import com.sw.fd.repository.ReviewTagRepository;
import com.sw.fd.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagRepository tagRepository;

    @Autowired
    private ReviewTagRepository reviewTagRepository;

    public Tag getTagByTno(int tno) {
        return tagRepository.findByTno(tno);
    }

    public void saveReviewTag(ReviewTag reviewTag) {
        reviewTagRepository.save(reviewTag);
    }

    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }

    public List<Tag> getTagsByRno(int rno) {
        return tagRepository.findTagsByRno(rno);
    }

}
