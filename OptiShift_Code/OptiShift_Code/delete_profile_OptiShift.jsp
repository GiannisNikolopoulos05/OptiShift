<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="optishift_group37.User" %>
<%@ page import="optishift_group37.UserDAO" %>

<%
  // Guard: μόνο manager
  String role = (session == null) ? null : (String) session.getAttribute("role");
  if (role == null || !"manager".equalsIgnoreCase(role)) {
    response.sendRedirect(request.getContextPath() + "/OptiShift_Code/login_OptiShift.jsp");
    return;
  }

  request.setAttribute("pageTitle", "Delete Profile – OptiShift");
  request.setAttribute("activePage", "delete_profile");

  // Employees list (από servlet ή fallback αν ανοίξει απευθείας η JSP)
  List employees = (List) request.getAttribute("employees");
  if (employees == null) {
    try {
      UserDAO dao = new UserDAO();
      employees = dao.getEmployees();
    } catch (Exception ex) {
      employees = new ArrayList();
      request.setAttribute("errorMsg", "Δεν ήταν δυνατή η φόρτωση εργαζομένων: " + ex.getMessage());
    }
  }

  String BASE = request.getContextPath() + "/OptiShift_Code/";
%>

<!DOCTYPE html>
<html lang="el">
<head>
  <jsp:include page="common/head.jsp">
    <jsp:param name="css" value="delete_profile.css"/>
  </jsp:include>

  <%-- Toast overlay (όπως στο Create Profile) --%>
  <style>
    .toast-overlay{
      position: fixed;
      top: 110px;
      left: 50%;
      transform: translateX(-50%);
      z-index: 9999;
      width: min(560px, calc(100% - 40px));
      display: flex;
      justify-content: center;
      pointer-events: none;
    }
    .toast{
      pointer-events: auto;
      width: 100%;
      padding: 14px 16px;
      border-radius: 12px;
      box-shadow: 0 10px 26px rgba(0,0,0,0.28);
      font-size: 15px;
      line-height: 1.35;
      display: flex;
      align-items: flex-start;
      gap: 10px;
      opacity: 1;
      transform: translateY(0);
    }
    .toast.success{
      background: #d7ffd9;
      color: #256428;
      border: 1px solid rgba(37,100,40,0.25);
    }

    /* Auto-hide toast without JS (~3.53s + fade 0.22s) */
    @keyframes toastAutoHide {
      to { opacity: 0; transform: translateY(-6px); visibility: hidden; pointer-events: none; }
    }
    @keyframes toastWrapAutoHide {
      to { opacity: 0; visibility: hidden; pointer-events: none; }
    }
    .toast-overlay{
      animation: toastWrapAutoHide .22s ease forwards;
      animation-delay: 3.53s;
    }
    .toast{
      animation: toastAutoHide .22s ease forwards;
      animation-delay: 3.53s;
    }
  </style>
</head>

<body>
  <jsp:include page="common/header.jsp"/>

  <%-- SUCCESS toast overlay (φεύγει μόνο του) --%>
  <% if (request.getAttribute("successMsg") != null) { %>
    <div class="toast-overlay">
      <div class="toast success">
        <div style="width:100%; text-align:center;"><%= request.getAttribute("successMsg") %></div>
      </div>
    </div>
  <% } %>

  <main class="container">
    <section class="welcome">
      <h1>Διαγραφή Εργαζομένου</h1>
      <p class="subtitle">
        Πληκτρολόγησε ή κάνε κλικ στο πεδίο αναζήτησης, επίλεξε εργαζόμενο από τη λίστα και πάτα «Διαγραφή».
      </p>

      <form class="profile-form"
            action="<%= request.getContextPath() %>/servlet/optishift_group37.DeleteProfileServlet"
            method="post"
            id="deleteForm">

        <label for="employeeSearch">Αναζήτηση εργαζομένου</label>

        <input
          type="text"
          id="employeeSearch"
          name="employeeText"
          placeholder="π.χ. Μαρία Νικολάου"
          list="employeesList"
          autocomplete="off"
          required
        />

        <datalist id="employeesList">
          <%
            for (int i = 0; i < employees.size(); i++) {
              User u = (User) employees.get(i);
              String display = u.getFirstname() + " " + u.getLastname() + " (" + u.getUsername() + ")";
          %>
            <option value="<%= display %>" data-id="<%= u.getId() %>"></option>
          <% } %>
        </datalist>

        <input type="hidden" id="employeeId" name="employeeId" value="" />

        <div class="inline-error" id="pickError" style="display:none;">
          Διάλεξε πρώτα έναν εργαζόμενο από τα αποτελέσματα αναζήτησης.
        </div>

        <%-- ERROR: όπως το “Προσοχή”, χωρίς label/banner --%>
        <%
          String err = (String) request.getAttribute("errorMsg");
          if (err != null) {
            // Αν είναι το γνωστό μήνυμα, δείξε το fixed όπως ζήτησες
            if (err.contains("Διάλεξε πρώτα")) {
        %>
              <p class="warning">Διάλεξε πρώτα έναν εργαζόμενο από τα αποτελέσματα αναζήτησης!</p>
        <%
            } else {
              // αλλιώς, εμφάνισε το καθαρισμένο κείμενο
              String clean = err.replace("❌", "").trim();
              clean = clean.replaceFirst("^Delete error:\\s*", "");
        %>
              <p class="warning"><%= clean %></p>
        <%
            }
          }
        %>

        <p class="warning">
          Προσοχή: Η διαγραφή είναι οριστική και δεν μπορεί να αναιρεθεί.
        </p>

        <div class="form-buttons">
          <button type="submit" class="delete-btn">Διαγραφή</button>
          <a href="<%= BASE %>manager_home_OptiShift.jsp" class="back-btn">← Επιστροφή</a>
        </div>
      </form>
    </section>

    <jsp:include page="common/footer.jsp">
      <jsp:param name="text" value="AI Scheduling System · OptiShift"/>
    </jsp:include>
  </main>
</body>
</html>
