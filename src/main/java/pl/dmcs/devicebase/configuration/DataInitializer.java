package pl.dmcs.devicebase.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.*;
import pl.dmcs.devicebase.repository.*;

import jakarta.annotation.PostConstruct;
import java.util.Arrays;
import java.util.List;

@Configuration
public class DataInitializer {

    @Autowired
    private AppUserRepository appUserRepository;

    @Autowired
    private AppUserRoleRepository appUserRoleRepository;

    @Autowired
    private EndpointRepository endpointRepository;

    @Autowired
    private EndpointPermissionRepository endpointPermissionRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private DepartmentRepository departmentRepository;

    @PostConstruct
    @Transactional
    public void init() {
        if (appUserRepository.count() == 0 && appUserRoleRepository.count() == 0 &&
                endpointRepository.count() == 0 && endpointPermissionRepository.count() == 0) {

            // Tworzenie roli
            AppUserRole roleAdmin = new AppUserRole();
            roleAdmin.setRole("ROLE_ADMIN");
            appUserRoleRepository.save(roleAdmin);

            AppUserRole roleUser = new AppUserRole();
            roleUser.setRole("ROLE_USER");
            appUserRoleRepository.save(roleUser);

            // Tworzenie użytkownika admin
            AppUser adminUser = new AppUser();
            adminUser.setDepartment("Admin");
            adminUser.setEmail("admin00@gmail.com");
            adminUser.setIsEnabled(true);
            adminUser.setFirstName("Adam");
            adminUser.setLastName("Matuszewski");
            adminUser.setLogin("admin");
            adminUser.setPassword(passwordEncoder.encode("Admin123%"));
            adminUser.setPhonePrefix("+48");
            adminUser.setPhoneNumber("733 088 560");
            adminUser.setWorkplace("admin");
            adminUser.getAppUserRole().add(roleAdmin);
            appUserRepository.save(adminUser);

            // Tworzenie użytkownika user
            AppUser userUser = new AppUser();
            userUser.setDepartment("User");
            userUser.setEmail("user00@gmail.com");
            userUser.setIsEnabled(true);
            userUser.setFirstName("Adam");
            userUser.setLastName("Matuszewski");
            userUser.setLogin("user");
            userUser.setPassword(passwordEncoder.encode("Admin123%"));
            userUser.setPhonePrefix("+48");
            userUser.setPhoneNumber("733 088 560");
            userUser.setWorkplace("user");
            userUser.getAppUserRole().add(roleUser);
            appUserRepository.save(userUser);

            // Tworzenie endpointów
            Endpoint endpoint1 = new Endpoint();
            endpoint1.setId(1L);
            endpoint1.setDescription("Zarządzanie użytkownikami obejmuje operacje związane z dodawaniem, edytowaniem i usuwaniem kont użytkowników w systemie. Administratorzy mogą przeglądać listę wszystkich użytkowników oraz modyfikować ich dane i uprawnienia zgodnie z politykami bezpieczeństwa.");
            endpoint1.setEndpoint("/users**");
            endpoint1.setLabel("Zarządzanie użytkownikami");
            endpointRepository.save(endpoint1);

            Endpoint endpoint2 = new Endpoint();
            endpoint2.setId(2L);
            endpoint2.setDescription("Administratorska strona główna to centralny punkt dostępu dla administratorów, gdzie mogą monitorować i zarządzać różnymi aspektami systemu. Znajdują się tu podsumowania aktywności użytkowników, alerty systemowe oraz szybki dostęp do najważniejszych funkcji.");
            endpoint2.setEndpoint("/home**");
            endpoint2.setLabel("Administratorska strona główna");
            endpointRepository.save(endpoint2);

            Endpoint endpoint3 = new Endpoint();
            endpoint3.setId(3L);
            endpoint3.setDescription("Zarządzanie rolami pozwala na tworzenie i modyfikowanie ról, które definiują zestawy uprawnień dla użytkowników systemu. Rola jest grupą uprawnień, które można łatwo przypisać do użytkowników, co ułatwia zarządzanie ich dostępem do różnych funkcji systemu.");
            endpoint3.setEndpoint("/appUserRole*");
            endpoint3.setLabel("Zarządzanie rolami");
            endpointRepository.save(endpoint3);

            Endpoint endpoint4 = new Endpoint();
            endpoint4.setId(4L);
            endpoint4.setDescription("Dodawanie nowych ról obejmuje definiowanie nowych zestawów uprawnień, które mogą być przypisane użytkownikom. Administratorzy mogą określić specyficzne prawa dostępu, które będą obowiązywały dla każdej nowej roli, zapewniając odpowiedni poziom bezpieczeństwa.");
            endpoint4.setEndpoint("/addAppUserRole**");
            endpoint4.setLabel("Dodawanie nowych ról");
            endpointRepository.save(endpoint4);

            Endpoint endpoint5 = new Endpoint();
            endpoint5.setId(5L);
            endpoint5.setDescription("Przypisywanie ról użytkownikom umożliwia administratorom szybkie i efektywne zarządzanie dostępem użytkowników do zasobów systemu. Dzięki przypisywaniu ról, użytkownicy mogą zyskać odpowiednie uprawnienia bez potrzeby indywidualnego konfigurowania każdego.");
            endpoint5.setEndpoint("/usersRoles**");
            endpoint5.setLabel("Przypisywanie ról użytkownikom");
            endpointRepository.save(endpoint5);

            Endpoint endpoint6 = new Endpoint();
            endpoint6.setId(6L);
            endpoint6.setDescription("Zarządzanie uprawnieniami pozwala na precyzyjne kontrolowanie, jakie akcje mogą wykonywać użytkownicy w systemie. Administratorzy mogą dostosować prawa dostępu do różnych funkcji i danych w systemie, zapewniając, że tylko uprawnieni użytkownicy mogą wykonywać określone czynności.");
            endpoint6.setEndpoint("/permission-management**");
            endpoint6.setLabel("Zarządzanie uprawnieniami");
            endpointRepository.save(endpoint6);

            Endpoint endpoint7 = new Endpoint();
            endpoint7.setId(7L);
            endpoint7.setDescription("Przeglądanie profilu obecnie zalogowanego użytkownika");
            endpoint7.setEndpoint("/profile**");
            endpoint7.setLabel("Profil użytkownika");
            endpointRepository.save(endpoint7);

            Endpoint endpoint8 = new Endpoint();
            endpoint8.setId(8L);
            endpoint8.setDescription("Zezwala na edytowanie użytkowników");
            endpoint8.setEndpoint("/editUser**");
            endpoint8.setLabel("Edycja użytkowników");
            endpointRepository.save(endpoint8);

            Endpoint endpoint9 = new Endpoint();
            endpoint9.setId(9L);
            endpoint9.setDescription("Zezwala na zmianę haseł użytkowników");
            endpoint9.setEndpoint("/changeUserPassword/**");
            endpoint9.setLabel("Zmiana haseł użytkowników");
            endpointRepository.save(endpoint9);

            List<EndpointPermission> permissions = Arrays.asList(
                    new EndpointPermission(endpoint1, roleAdmin),
                    new EndpointPermission(endpoint2, roleAdmin),
                    new EndpointPermission(endpoint3, roleAdmin),
                    new EndpointPermission(endpoint4, roleAdmin),
                    new EndpointPermission(endpoint5, roleAdmin),
                    new EndpointPermission(endpoint6, roleAdmin),
                    new EndpointPermission(endpoint7, roleAdmin),
                    new EndpointPermission(endpoint8, roleAdmin),
                    new EndpointPermission(endpoint9, roleAdmin),
                    new EndpointPermission(endpoint7, roleUser),
                    new EndpointPermission(endpoint2, roleUser)

            );
            endpointPermissionRepository.saveAll(permissions);
        }

        createDepartmentIfNotExists("Dział oczyszczania ścieków", "Opis działu");
        createDepartmentIfNotExists("Dział księgowości", "Opis działu");
        createDepartmentIfNotExists("Dział mechaniczny", "Opis działu");
    }

    private void createDepartmentIfNotExists(String departmentName, String description) {
        if (!departmentRepository.existsByDepartmentName(departmentName)) {
            Department department = new Department();
            department.setDepartmentName(departmentName);
            department.setDescription(description);
            departmentRepository.save(department);
        }
    }
}
