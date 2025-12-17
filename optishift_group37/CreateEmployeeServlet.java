package optishift_group37;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class CreateEmployeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String role = (session == null) ? null : (String) session.getAttribute("role");

        if (role == null || !"manager".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/OptiShift_Code/login_OptiShift.jsp");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String email     = request.getParameter("email");
        String phone     = request.getParameter("phone");
        String username  = request.getParameter("username");
        String password  = request.getParameter("password");

        try {
            // Χρησιμοποιεί το User class που έχεις με (id, firstname, lastname, email, phone, username, password, role, active)
            User u = new User(
                0,
                firstName,
                lastName,
                email,
                phone,
                username,
                password,
                "employee",
                true
            );

            UserDAO dao = new UserDAO();
            dao.register(u);

            request.setAttribute("successMsg", "✅ Ο εργαζόμενος δημιουργήθηκε! Μπορεί τώρα να συνδεθεί από το login.");
            request.getRequestDispatcher("/OptiShift_Code/create_profile_OptiShift.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMsg", "❌ " + e.getMessage());
            request.getRequestDispatcher("/OptiShift_Code/create_profile_OptiShift.jsp").forward(request, response);
        }
    }
}
