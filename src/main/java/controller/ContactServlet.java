package controller;

import dao.ContactDAO;
import model.Contact;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");

        if (acc != null) {
            ContactDAO dao = new ContactDAO();
            List<Contact> history = dao.getContactsByUserId(acc.getId());
            request.setAttribute("contactHistory", history);
        }

        String status = request.getParameter("status");
        if ("success".equals(status)) {
            request.setAttribute("successMsg", "✔️ Gửi yêu cầu thành công! Chúng tôi sẽ phản hồi sớm nhất.");
        } else if ("error".equals(status)) {
            request.setAttribute("errorMsg", "❌ Có lỗi xảy ra, vui lòng thử lại sau.");
        }

        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String messageContent = request.getParameter("message");

        ContactDAO dao = new ContactDAO();
        boolean success = success = dao.addContact(acc.getId(), name, phone, subject, messageContent);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/contact?status=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/contact?status=error");
        }
    }
}