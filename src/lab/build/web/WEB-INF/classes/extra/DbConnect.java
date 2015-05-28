package extra;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author root
 */
public class DbConnect {

    public DbConnect() {
    }

    public Connection getConnect() throws SQLException {

        Connection connection = null;


        try {
            // Load the JDBC driver
            String driverName = "org.gjt.mm.mysql.Driver"; // MySQL MM JDBC driver

            Class.forName(driverName);

            // Create a connection to the database
            String serverName = "localhost";
            String mydatabase = "VirtualLab";
            String url = "jdbc:mysql://" + serverName + "/" + mydatabase; // a JDBC url
            String username = "root";
            String password = "klaxmikantp";
//   String password = "";

            connection = DriverManager.getConnection(url, username, password);

            return connection;
        } catch (ClassNotFoundException e) {
            System.out.print("DB error........." + e);
            // Could not find the database driver
        } catch (SQLException e) {
            System.out.print("DB error........." + e);// Could not connect to the database
        }
        return null;
    }

    public ResultSet getRs(String query) {
        Connection connection = null;
        if (query == null) {
            return null;
        }
        try {
            connection = (Connection) getConnect();
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(query);
            return rs;
        } catch (SQLException ex) {
            Logger.getLogger(DbConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Connection getNewConnectionLogin() {
        Connection con = null;
        try {
            
            String driverName = "com.mysql.jdbc.Driver";

            Class.forName(driverName);
            String serverName = "localhost";
            String mydatabase = "VirtualLab";
            String url = "jdbc:mysql://" + serverName + ":3306/"+mydatabase; // a JDBC url
            String username = "root";
            String password = "klaxmikantp";
            System.out.println("********" + url);
            System.out.println("-=-=-=-=-=-=-");
            con = DriverManager.getConnection(url, username, password);
            System.out.println("**/*/*/*/*/*/*/*/*/*////" + con);


        } catch (SQLException ex) {
            Logger.getLogger(DbConnect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DbConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return con;


    }

    public Connection getNewConnect() throws InstantiationException, IllegalAccessException {
        Connection connection = null;

        try {
            // Load the JDBC driver
            String driverName = "com.mysql.jdbc.Driver";

            Class.forName(driverName).newInstance();

            // Create a connection to the database
            String serverName = "coepvlab.ac.in";
            String mydatabase = "sparrow";
            String url = "jdbc:mysql://" + serverName + ":3306/sparrow"; // a JDBC url
            String username = "karan";
            String password = "5fdh";
            System.out.println("********" + url);
            System.out.println("-=-=-=-=-=-=-");
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("**/*/*/*/*/*/*/*/*/*////" + connection);

            return connection;

//String driverName = "org.gjt.mm.mysql.Driver"; // MySQL MM JDBC driver

            //Class.forName(driverName).newInstance();

            // Create a connection to the database
//    String serverName = "59.163.23.69";
//    String mydatabase = "sparrow";
//    String url = "jdbc:mysql://" + serverName +  "/" + mydatabase; // a JDBC url
//    String username = "karan";
//   String password = "5fdh";
////   String password = "";
//    
//    connection = DriverManager.getConnection(url, username, password);
//    System.out.println("**/*/*/*/*/*/*/*/*/*////"+connection);

            //return connection;
        } catch (ClassNotFoundException e) {
            System.out.print("DB error.........\n");
            e.printStackTrace();
            // Could not find the database driver
        } catch (SQLException e) {
            System.out.print("DB error.........");// Could not connect to the database
            e.printStackTrace();
        }
        return connection;
    }
}
