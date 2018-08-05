import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Demo {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/bbs?useSSL = false & ?serverTimezone=GMT%2B8";
            String username = "root";
            String password = "123456";
            Connection conn = DriverManager.getConnection(url, username, password);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
