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
@WebServlet(name = "ForgotPassword", urlPatterns = "/ForgotPassword")
public class ForgotPassword extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final BankService bankService = new BankServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("ForgotPassword.jsp?error=empty");
            return;
        }

        try {
            boolean sent = bankService.recoverAccount(email.trim());
            if (sent) {
                log.info("Recovery email sent to: " + email);
                response.sendRedirect("ForgotPassword.jsp?success=true");
            } else {
                log.warning("No account found for email: " + email);
                response.sendRedirect("ForgotPassword.jsp?error=notfound");
            }
        } catch (Exception e) {
            log.severe("Error during account recovery: " + e.getMessage());
            response.sendRedirect("ForgotPassword.jsp?error=system");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("ForgotPassword.jsp");
    }
}
