package optishift_group37;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UserDAO dao = new UserDAO();
            User u = dao.authenticate(username, password); // ελέγχει στη DB (και active=1)

            // session
            HttpSession session = request.getSession(true);
            session.setAttribute("username", u.getUsername());
            session.setAttribute("role", u.getRole());

            // base path για τα JSP σου (είναι μέσα στο OptiShift_Code)
            String base = request.getContextPath() + "/OptiShift_Code/";

            // redirect ανάλογα με ρόλο
            if ("manager".equalsIgnoreCase(u.getRole())) {
                response.sendRedirect(base + "manager_home_OptiShift.jsp");
                return;
            }

            if ("employee".equalsIgnoreCase(u.getRole())) {
                response.sendRedirect(base + "employee_home_OptiShift.jsp");
                return;
            }

            // αν έχεις άλλο ρόλο
            throw new Exception("Unknown role: " + u.getRole());

        } catch (Exception e) {
            // ξαναγυρνάει στο login και δείχνει μήνυμα
            request.setAttribute("errorMsg", e.getMessage());
            request.getRequestDispatcher("/OptiShift_Code/login_OptiShift.jsp")
                   .forward(request, response);
        }
    }
}
