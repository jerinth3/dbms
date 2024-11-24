import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MySQLJDBCExample {

    public static void main(String[] args) {

        // MySQL database credentials
        String url = "jdbc:mysql://localhost:3306/your_database_name"; // Replace with your DB URL and name
        String username = "your_username"; // Replace with your MySQL username
        String password = "your_password"; // Replace with your MySQL password

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Step 1: Load the MySQL JDBC driver (not always required in newer versions of JDBC)
            // Class.forName("com.mysql.cj.jdbc.Driver"); // Optional in newer versions, but useful for older ones

            // Step 2: Establish the connection to the MySQL database
            connection = DriverManager.getConnection(url, username, password);
            
            System.out.println("Connection established successfully.");

            // Step 3: Create a Statement object
            statement = connection.createStatement();
            
            // Step 4: Execute a query (example: select data from a table)
            String query = "SELECT * FROM your_table_name"; // Replace with your table name
            resultSet = statement.executeQuery(query);

            // Step 5: Process the result set
            while (resultSet.next()) {
                // Assuming you have a column named "id" and "name" in the result set
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                System.out.println("ID: " + id + ", Name: " + name);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Step 6: Close the resources to avoid memory leaks
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
