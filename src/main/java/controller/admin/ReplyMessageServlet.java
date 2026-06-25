package controller.admin;

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

@WebServlet("/admin/reply-message")
public class ReplyMessageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ContactDAO dao = new ContactDAO();
        Contact contact = dao.getContactById(id);

        request.setAttribute("c", contact);
        request.getRequestDispatcher("/admin/reply.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User adminAcc = (User) session.getAttribute("acc");

        int adminId = 1;
        if (adminAcc != null) {
            adminId = adminAcc.getId();
        }

        int contactId = Integer.parseInt(request.getParameter("id"));
        String adminReply = request.getParameter("adminReply");

        ContactDAO dao = new ContactDAO();
        dao.replyContact(contactId, adminId, adminReply);

        response.sendRedirect(request.getContextPath() + "/admin/messages?replySuccess=true");
    }
}