package optishift_group37;

public class User {

    private int id;
    private String firstname;
    private String lastname;
    private String email;
    private String phone;
    private String username;
    private String password;
    private String role;     // "manager" ή "employee"
    private boolean active;  // true/false

    // Full constructor (χωρίς id)
    public User(String firstname, String lastname, String email, String phone,
                String username, String password, String role, boolean active) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.role = role;
        this.active = active;
    }

    // Full constructor (με id)
    public User(int id, String firstname, String lastname, String email, String phone,
                String username, String password, String role, boolean active) {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.role = role;
        this.active = active;
    }

    public int getId() { return id; }
    public String getFirstname() { return firstname; }
    public String getLastname() { return lastname; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public boolean isActive() { return active; }

    public void setId(int id) { this.id = id; }
    public void setFirstname(String firstname) { this.firstname = firstname; }
    public void setLastname(String lastname) { this.lastname = lastname; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setUsername(String username) { this.username = username; }
    public void setPassword(String password) { this.password = password; }
    public void setRole(String role) { this.role = role; }
    public void setActive(boolean active) { this.active = active; }
}
