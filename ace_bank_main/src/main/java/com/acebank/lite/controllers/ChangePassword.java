package com.acebank.lite.controllers;

import com.acebank.lite.service.BankService;
import com.acebank.lite.service.BankServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lombok.extern.java.Log;

import java.io.IOException;
import java.io.Serial;

@Log
@WebServlet(name = "ChangePassword", urlPatterns = "/ChangePassword")
public class ChangePassword extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final BankService bankService = new BankServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int accountNo = (int) session.getAttribute("accountNumber");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate passwords match
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            response.sendRedirect("ChangePassword.jsp?error=mismatch");
            return;
        }

        if (newPassword.length() < 10) {
            response.sendRedirect("ChangePassword.jsp?error=tooshort");
            return;
        }

        try {
            boolean success = bankService.changePassword(accountNo, oldPassword, newPassword);
            if (success) {
                log.info("Password changed successfully for account: " + accountNo);
                response.sendRedirect("ChangePassword.jsp?success=true");
            } else {
                log.warning("Password change failed for account: " + accountNo);
                response.sendRedirect("ChangePassword.jsp?error=wrong");
            }
        } catch (Exception e) {
            log.severe("Error changing password: " + e.getMessage());
            response.sendRedirect("ChangePassword.jsp?error=system");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNumber") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        response.sendRedirect("ChangePassword.jsp");
    }
}
