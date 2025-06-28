package com.hugi.barbershop.common.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/dbtest")
public class DBTestServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        try (Connection conn = DBUtil.getConnection()) {
            out.println("<h2>Database connection successful!</h2>");
        } catch (SQLException e) {
            out.println("<h2>Database connection failed:</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    }
}
