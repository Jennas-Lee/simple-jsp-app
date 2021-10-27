package dbpkg;

import java.sql.Connection;
import java.sql.DriverManager;

public class Util {
    public static Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@//localhost:1521/xe",
                "system",
                "11111"
        );

        return conn;
    }

    public static String getParamNN(String param) {
        if (param == null) {
            return "";
        } else {
            return param;
        }
    }
}
