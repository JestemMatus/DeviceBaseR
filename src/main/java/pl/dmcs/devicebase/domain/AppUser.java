package pl.dmcs.devicebase.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="appuser")
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotNull
    @Column(name = "firstName", nullable = false)
    @Size(min=2, max=30, message = "{error.size.firstName}")
    private String firstName;

    @Column(name = "lastName", nullable = false)
    @Size(min=2, max=30, message = "{error.size.firstName}")
    private String lastName;

    private String email;

    @Column(name = "login", nullable = false)
    @Size(min=2, max=30, message = "{error.size.firstName}")
    private String login;

    @Column(name = "password", nullable = false)
    @Size(min=2, max=30, message = "{error.password}")
    private String password;

    private String department;
    private String workplace;

    @Size(min=2, max=4, message = "{error.size.telephonePrefix}")
    @Column(name = "phonePrefix", nullable = true)
    private String phonePrefix;

    @Column(name = "phoneNumber", nullable = true)
    private String phoneNumber;

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getWorkplace() {
        return workplace;
    }

    public void setWorkplace(String workplace) {
        this.workplace = workplace;
    }


    public String getTelephoneNumber() {
        return phonePrefix + " " + phoneNumber;
    }

    public void setTelephoneNumber(String phonePrefix, String phoneNumber) {
        this.phonePrefix = phonePrefix;
        this.phoneNumber = phoneNumber;
    }

    public String getPhonePrefix() {
        return phonePrefix;
    }

    public void setPhonePrefix(String phonePrefix) {
        this.phonePrefix = phonePrefix;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getFirstName(){
        return firstName;
    }

    public void setFirstName(String firstName){
        this.firstName = firstName;
    }

    public String getLastName(){
        return lastName;
    }

    public void setLastName(String lastName){
        this.lastName = lastName;
    }

    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public String getLogin(){
        return login;
    }

    public void setLogin(String login){
        this.login = login;
    }

    public String getPassword(){
        return password;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
