package pl.dmcs.devicebase.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="appuserrole")
public class AppUserRole {

    @Id
    @GeneratedValue
    private Long id;

    private String role;

    public Long getId(){ return id;}

    public void setId(Long id) {this.id = id;}

    public String getRole() { return role;}

    public void setRole(String role) {this.role = role;}
}
