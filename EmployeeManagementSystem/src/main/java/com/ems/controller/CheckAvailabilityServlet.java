package com.ems.controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

import com.ems.util.DBConnection;

@WebServlet("/CheckAvailabilityServlet")
public class CheckAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String type = request.getParameter("type");
        String value = request.getParameter("value");

        boolean available = false;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            
            String sql = "";
            if ("username".equals(type)) {
                sql = "SELECT COUNT(*) FROM admin WHERE username = ?";
            } else if ("email".equals(type)) {
                sql = "SELECT COUNT(*) FROM admin WHERE email = ?";
            } else {
                out.print("{\"available\": false}");
                return;
            }
            
            ps = con.prepareStatement(sql);
            ps.setString(1, value);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                available = (count == 0);
            }
            
            out.print("{\"available\": " + available + "}");
            
        } catch (Exception e) {
            System.out.println("Error in CheckAvailabilityServlet: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"available\": false, \"error\": \"Database error\"}");
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (SQLException e) {
                System.out.println("Error closing ResultSet: " + e.getMessage());
            }
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing PreparedStatement: " + e.getMessage());
            }
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error closing Connection: " + e.getMessage());
            }
        }
        
        out.flush();
    }
}