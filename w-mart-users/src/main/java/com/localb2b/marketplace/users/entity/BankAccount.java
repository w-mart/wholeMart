package com.localb2b.marketplace.users.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="wm_bank_account")
public class BankAccount extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    private String accountHolderName;

    private String bankName;

    private String accountNumber;

    private String ifscCode;

    private String upiId;

    private Boolean primaryAccount;

}