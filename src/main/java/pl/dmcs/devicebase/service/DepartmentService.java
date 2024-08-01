package pl.dmcs.devicebase.service;

import pl.dmcs.devicebase.domain.Department;

import java.util.List;

public interface DepartmentService {
    List<Department> findAll();
}
