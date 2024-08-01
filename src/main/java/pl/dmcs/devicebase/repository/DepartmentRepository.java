package pl.dmcs.devicebase.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.dmcs.devicebase.domain.Department;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
    Department findByDepartmentName(String departmentName);
    boolean existsByDepartmentName(String departmentName);

}
