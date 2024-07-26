package pl.dmcs.devicebase.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "endpoint_permission")
public class EndpointPermission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "endpoint_id")
    private Endpoint endpoint;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private AppUserRole role;

    public EndpointPermission() {
    }

    public EndpointPermission(Endpoint endpoint, AppUserRole role) {
        this.endpoint = endpoint;
        this.role = role;
    }

    // Gettery i settery
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Endpoint getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(Endpoint endpoint) {
        this.endpoint = endpoint;
    }

    public AppUserRole getRole() {
        return role;
    }

    public void setRole(AppUserRole role) {
        this.role = role;
    }
}
