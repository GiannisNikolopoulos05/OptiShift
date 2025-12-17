package optishift_group37;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Διάλεξε ένα “καθαρό” table name για το project
    private static final String TABLE = "optishift_users";

    // A) Όλοι οι χρήστες
    public List<User> getUsers() throws Exception {
        List<User> users = new ArrayList<>();
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String sql = "SELECT id, firstname, lastname, email, phone, username, password, role, active FROM " + TABLE;
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                ));
            }

            return users;

        } catch (Exception e) {
            throw new Exception("Error getting users: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    // B) Εύρεση user με username
    public User findUser(String username) throws Exception {
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String sql = "SELECT id, firstname, lastname, email, phone, username, password, role, active "
                       + "FROM " + TABLE + " WHERE username=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                );
            }
            return null;

        } catch (Exception e) {
            throw new Exception("Error finding user: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    // C) Authenticate (μόνο αν active=1)
    public User authenticate(String username, String password) throws Exception {
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String sql = "SELECT id, firstname, lastname, email, phone, username, password, role, active "
                       + "FROM " + TABLE + " WHERE username=? AND password=? AND active=1";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                );
            } else {
                throw new Exception("Wrong username or password (or inactive user)");
            }

        } catch (Exception e) {
            throw new Exception("Authentication error: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    // D) Register (έλεγχος username/email)
    public void register(User user) throws Exception {
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String checkSql = "SELECT id FROM " + TABLE + " WHERE username=? OR email=?";
            PreparedStatement checkStmt = con.prepareStatement(checkSql);
            checkStmt.setString(1, user.getUsername());
            checkStmt.setString(2, user.getEmail());

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                throw new Exception("Sorry, username or email already registered");
            }

            String insertSql = "INSERT INTO " + TABLE
                    + " (firstname, lastname, email, phone, username, password, role, active) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(insertSql);

            stmt.setString(1, user.getFirstname());
            stmt.setString(2, user.getLastname());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getUsername());
            stmt.setString(6, user.getPassword());
            stmt.setString(7, user.getRole());
            stmt.setBoolean(8, user.isActive());

            stmt.executeUpdate();

        } catch (Exception e) {
            throw new Exception("Error registering user: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    // F) Delete (υπάρχει ήδη, αλλά στο Delete Profile θα χρησιμοποιούμε id-based deleteEmployeeById)
    public void hardDelete(String username) throws Exception {
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String sql = "DELETE FROM " + TABLE + " WHERE username=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);

            int rows = stmt.executeUpdate();
            if (rows == 0) throw new Exception("User not found");

        } catch (Exception e) {
            throw new Exception("Error deleting user: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    // G) Employees μόνο (για το Delete Profile autocomplete)
    public List<User> getEmployees() throws Exception {
        List<User> users = new ArrayList<>();
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String sql = "SELECT id, firstname, lastname, email, phone, username, password, role, active "
                       + "FROM " + TABLE + " WHERE role='employee' ORDER BY lastname, firstname";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                ));
            }

            return users;

        } catch (Exception e) {
            throw new Exception("Error getting employees: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    // H) Delete employee by id (μόνο αν είναι employee)
    public void deleteEmployeeById(int id) throws Exception {
        DB db = new DB();
        Connection con = null;

        try {
            con = db.getConnection();

            String sql = "DELETE FROM " + TABLE + " WHERE id=? AND role='employee'";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);

            int rows = stmt.executeUpdate();
            if (rows == 0) {
                throw new Exception("Employee not found (or not an employee)");
            }

        } catch (Exception e) {
            throw new Exception("Error deleting employee: " + e.getMessage());
        } finally {
            db.close();
        }
    }
}
