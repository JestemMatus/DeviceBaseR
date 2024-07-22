package pl.dmcs.devicebase.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.AppUserRole;

@Transactional
@Repository
public interface AppUserRoleRepository extends JpaRepository<AppUserRole, Long>{
    AppUserRole findByRole(String role);
}