package com.localb2b.marketplace.users.entity;

import java.time.Instant;

public class AuditEntity extends BaseEntity {
    private Instant createdDate;
    private Instant updatedDate;
    public Instant getCreatedDate(){ return createdDate; }
    public void setCreatedDate(Instant createdDate){ this.createdDate = createdDate; }
    public Instant getUpdatedDate(){ return updatedDate; }
    public void setUpdatedDate(Instant updatedDate){ this.updatedDate = updatedDate; }
}
