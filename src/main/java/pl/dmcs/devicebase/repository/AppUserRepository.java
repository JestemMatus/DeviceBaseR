package pl.dmcs.devicebase.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.AppUser;
import java.util.List;

@Transactional
@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    List<AppUser> findByLastName(String lastName);
    AppUser findById(long id);

    AppUser findByLogin(String login);
    AppUser findByEmail(String email);
    AppUser findByPhoneNumber(String phoneNumber);

}
