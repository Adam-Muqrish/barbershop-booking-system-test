package com.hugi.barbershop.common.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String DB_URL = "jdbc:oracle:thin:@//192.168.0.66:1521/FREEPDB1";
    private static final String DB_USER = "project2";
    private static final String DB_PASSWORD = "oracle";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Oracle JDBC driver not found.", e);
        }
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        conn.setAutoCommit(true); // Enable auto-commit
        return conn;
    }
}