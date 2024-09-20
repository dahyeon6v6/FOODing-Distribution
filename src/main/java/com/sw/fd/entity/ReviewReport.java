package com.sw.fd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "reviewreport_t")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewReport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int rrno;

    @ManyToOne
    @JoinColumn(name = "rno", nullable = false)
    private Review review;

    @ManyToOne
    @JoinColumn(name = "mno", nullable = false)
    private Member member;

    @ManyToOne
    @JoinColumn(name = "rpno", nullable = false)
    private Report report;

    @Column(name = "rrdate", nullable = false)
    private LocalDateTime rrdate;

    @PrePersist
    protected void onCreate() {
        rrdate = LocalDateTime.now();
    }
}
