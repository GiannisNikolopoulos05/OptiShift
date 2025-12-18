package optishift_group37;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class DeleteProfileServlet extends HttpServlet {

    private static String norm(String s) {
        if (s == null) return "";
        // Trim + collapse internal whitespace + case-fold
        return s.trim().replaceAll("\\s+", " ").toLowerCase();
    }

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
            Integer employeeId = null;

            // 1) Preferred path (legacy): hidden employeeId field (used when JavaScript was present)
            if (employeeIdStr != null && employeeIdStr.trim().length() > 0) {
                employeeId = Integer.parseInt(employeeIdStr.trim());
            }

            // 2) No-JS path: derive employeeId from the selected text (Firstname Lastname (username))
            if (employeeId == null) {
                String employeeText = request.getParameter("employeeText");
            if (employeeText == null || employeeText.trim().isEmpty()) {
                employeeText = request.getParameter("employeeSearch");
            }
            if (employeeText == null || employeeText.trim().isEmpty()) {
                employeeText = request.getParameter("employeeName");
            }
            if (employeeText == null || employeeText.trim().length() == 0) {
                    throw new Exception("Διάλεξε πρώτα έναν εργαζόμενο από τα αποτελέσματα αναζήτησης.");
                }
                employeeText = employeeText.trim();

                UserDAO daoTmp = new UserDAO();

                // Try parsing username inside parentheses
                int l = employeeText.lastIndexOf('(');
                int r = employeeText.lastIndexOf(')');
                if (l >= 0 && r > l) {
                    String username = employeeText.substring(l + 1, r).trim();
                    if (username.length() > 0) {
                        User u = daoTmp.findUser(username);
                        if (u != null) {
                            employeeId = u.getId();
                        }
                    }
                }

                // Fallback: match the exact display string against employees list
                if (employeeId == null) {
                    List employeesTmp = daoTmp.getEmployees();

                    String in = norm(employeeText);
                    int matches = 0;
                    Integer matchId = null;

                    for (int i = 0; i < employeesTmp.size(); i++) {
                        User u = (User) employeesTmp.get(i);
                        String fullName = norm(u.getFirstname() + " " + u.getLastname());
                        String display = norm(u.getFirstname() + " " + u.getLastname() + " (" + u.getUsername() + ")");

                        // Accept either the full display string or just the full name (no parentheses)
                        if (in.equals(display) || in.equals(fullName) || in.startsWith(fullName + " (")) {
                            matches++;
                            matchId = u.getId();
                        }
                    }

                    if (matches == 1) {
                        employeeId = matchId;
                    } else if (matches > 1) {
                        throw new Exception("Βρέθηκαν πολλοί εργαζόμενοι με αυτό το όνομα. Επίλεξε από τη λίστα (με username) για να γίνει μοναδική επιλογή.");
                    }
                }

                if (employeeId == null) {
                    throw new Exception("Διάλεξε πρώτα έναν εργαζόμενο από τα αποτελέσματα αναζήτησης.");
                }
            }

            UserDAO dao = new UserDAO();
            dao.deleteEmployeeById(employeeId.intValue());

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
