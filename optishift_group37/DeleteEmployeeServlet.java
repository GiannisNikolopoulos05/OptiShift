package optishift_group37;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class DeleteEmployeeServlet extends HttpServlet {

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

        String idStr = request.getParameter("employeeId");

        try {
            if (idStr == null || idStr.trim().isEmpty()) {
                throw new Exception("No employee selected");
            }

            int employeeId = Integer.parseInt(idStr);

            UserDAO dao = new UserDAO();
            dao.deleteEmployeeById(employeeId);

            session.setAttribute("successMsg", "✅ Ο εργαζόμενος διαγράφηκε επιτυχώς.");

        } catch (Exception e) {
            session.setAttribute("errorMsg", "❌ " + e.getMessage());
        }

        // Redirect για να μην ξανακάνει delete σε refresh + να ξαναφορτώσει σωστά τη λίστα
        response.sendRedirect(request.getContextPath() + "/servlet/optishift_group37.DeleteProfileServlet");
    }
}
