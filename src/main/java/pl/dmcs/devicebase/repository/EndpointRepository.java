package pl.dmcs.devicebase.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.dmcs.devicebase.domain.Endpoint;

public interface EndpointRepository extends JpaRepository<Endpoint, Long> {
    Endpoint findByEndpoint(String endpoint);
}
