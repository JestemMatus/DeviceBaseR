package pl.dmcs.devicebase.configuration;

import jakarta.annotation.Resource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.beans.factory.annotation.Autowired;
import pl.dmcs.devicebase.service.PermissionService;
import pl.dmcs.devicebase.domain.EndpointPermission;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfiguration {

    @Resource(name = "myAppUserDetailsService")
    private UserDetailsService userDetailsService;

    @Autowired
    private PermissionService permissionService;

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    DaoAuthenticationProvider authProvider(){
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        UserDetails user = User.withDefaultPasswordEncoder()
                .username("user")
                .password("user")
                .roles("USER")
                .build();
        UserDetails admin = User.withDefaultPasswordEncoder()
                .username("admin")
                .password("admin")
                .roles("ADMIN", "USER")
                .build();
        return new InMemoryUserDetailsManager(user, admin);
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        http
                .authorizeHttpRequests((authz) -> {
                    // Fetch all permissions
                    List<EndpointPermission> allPermissions = permissionService.getAllPermissions();

                    // Group permissions by endpoint
                    Map<String, List<String>> endpointRoleMap = allPermissions.stream()
                            .collect(Collectors.groupingBy(
                                    permission -> permission.getEndpoint().getEndpoint(),
                                    Collectors.mapping(permission -> permission.getRole().getRole(), Collectors.toList())
                            ));

                    // Configure authorization for each endpoint
                    endpointRoleMap.forEach((endpoint, roles) -> {
                        String[] rolesArray = roles.toArray(new String[0]);
                        authz.requestMatchers(endpoint).hasAnyAuthority(rolesArray);
                    });

                    authz
                            .requestMatchers("/login**", "/**", "/register**", "/welcome**").permitAll()
                            .anyRequest().authenticated();
                })
                .formLogin(form -> form
                        .loginPage("/login")
                        .usernameParameter("login")
                        .passwordParameter("password")
                        .failureUrl("/login?error")
                        .defaultSuccessUrl("/home", true)
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/login?logout")
                )
                .exceptionHandling(logout -> logout
                        .accessDeniedPage("/accessDenied"))
                .csrf().and()
                .httpBasic();
        return http.build();
    }
}
