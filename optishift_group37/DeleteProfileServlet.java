package optishift_group37;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class DeleteProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session == null) ? null : (String) session.getAttribute("role");

        if (role == null || !"manager".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/OptiShift_Code/login_OptiShift.jsp");
            return;
        }

        try {
            UserDAO dao = new UserDAO();
            List employees = dao.getEmployees();
            request.setAttribute("employees", employees);
        } catch (Exception e) {
            request.setAttribute("errorMsg", "❌ " + e.getMessage());
        }

        request.getRequestDispatcher("/OptiShift_Code/delete_profile_OptiShift.jsp")
               .forward(request, response);
    }

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

        try {
            String employeeIdStr = request.getParameter("employeeId");
            if (employeeIdStr == null || employeeIdStr.trim().length() == 0) {
                throw new Exception("Διάλεξε πρώτα έναν εργαζόμενο από τα αποτελέσματα αναζήτησης.");
            }

            int employeeId = Integer.parseInt(employeeIdStr);

            UserDAO dao = new UserDAO();
            dao.deleteEmployeeById(employeeId);

            request.setAttribute("successMsg", "✅ Ο εργαζόμενος διαγράφηκε επιτυχώς.");

        } catch (Exception e) {
            request.setAttribute("errorMsg", "❌ Delete error: " + e.getMessage());
        }

        // Reload employees list
        try {
            UserDAO dao = new UserDAO();
            List employees = dao.getEmployees();
            request.setAttribute("employees", employees);
        } catch (Exception e) {
            request.setAttribute("errorMsg", "❌ " + e.getMessage());
        }

        request.getRequestDispatcher("/OptiShift_Code/delete_profile_OptiShift.jsp")
               .forward(request, response);
    }
}
