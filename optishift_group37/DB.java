package optishift_group37;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {

    private final String dbServer = "195.251.249.131";
    private final String dbServerPort = "3306";
    private final String dbName = "ismgroup37";
    private final String dbusername = "ismgroup37";
    private final String dbpassword = "bbn83b";

    private Connection con = null;

    public Connection getConnection() throws Exception {

        try {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                Class.forName("com.mysql.jdbc.Driver"); // fallback για παλιό connector
            }
        } catch (Exception e) {
            throw new Exception("MySQL Driver error: " + e.getMessage());
        }

        try {
            String url = "jdbc:mysql://" + dbServer + ":" + dbServerPort + "/" + dbName
                    + "?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC";

            con = DriverManager.getConnection(url, dbusername, dbpassword);
            return con;

        } catch (Exception e) {
            throw new Exception("Could not establish connection with the Database Server: " + e.getMessage());
        }
    }

    public void close() throws SQLException {
        try {
            if (con != null) con.close();
        } catch (SQLException e) {
            throw new SQLException("Could not close connection with the Database Server: " + e.getMessage());
        }
    }
}
