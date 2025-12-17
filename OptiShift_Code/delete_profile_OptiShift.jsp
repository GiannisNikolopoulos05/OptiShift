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
</head>
<body>
  <jsp:include page="common/header.jsp"/>

  <main class="container">
    <section class="welcome">
      <h1>Διαγραφή Εργαζομένου</h1>
      <p class="subtitle">
        Πληκτρολόγησε ή κάνε κλικ στο πεδίο αναζήτησης, επίλεξε εργαζόμενο από τη λίστα και πάτα «Διαγραφή».
      </p>

      <% if (request.getAttribute("successMsg") != null) { %>
        <div class="flash flash-success" id="flashMsg"><%= request.getAttribute("successMsg") %></div>
        <script>
          setTimeout(function(){
            var el = document.getElementById("flashMsg");
            if (el) el.classList.add("flash-hide");
          }, 3000);
        </script>
      <% } %>

      <% if (request.getAttribute("errorMsg") != null) { %>
        <div class="flash flash-error" id="flashMsg"><%= request.getAttribute("errorMsg") %></div>
        <script>
          setTimeout(function(){
            var el = document.getElementById("flashMsg");
            if (el) el.classList.add("flash-hide");
          }, 3500);
        </script>
      <% } %>

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

        <p class="warning">
          Προσοχή: Η διαγραφή είναι οριστική και δεν μπορεί να αναιρεθεί.
        </p>

        <div class="form-buttons">
          <button type="submit" class="delete-btn">Διαγραφή</button>
          <a href="<%= BASE %>manager_home_OptiShift.jsp" class="back-btn">← Επιστροφή</a>
        </div>
      </form>

      <script>
        (function(){
          var input = document.getElementById("employeeSearch");
          var hidden = document.getElementById("employeeId");
          var err = document.getElementById("pickError");
          var list = document.getElementById("employeesList");
          var form = document.getElementById("deleteForm");

          function syncHidden() {
            var val = input.value;
            hidden.value = "";
            if (!val) return;

            var opts = list.options;
            for (var i = 0; i < opts.length; i++) {
              if (opts[i].value === val) {
                hidden.value = opts[i].getAttribute("data-id") || "";
                return;
              }
            }
          }

          input.addEventListener("input", function(){
            syncHidden();
            if (err) err.style.display = "none";
          });

          input.addEventListener("change", function(){
            syncHidden();
            if (err) err.style.display = "none";
          });

          form.addEventListener("submit", function(e){
            syncHidden();
            if (!hidden.value) {
              e.preventDefault();
              if (err) err.style.display = "block";
              input.focus();
            }
          });
        })();
      </script>

    </section>

    <jsp:include page="common/footer.jsp">
      <jsp:param name="text" value="AI Scheduling System · OptiShift"/>
    </jsp:include>
  </main>
</body>
</html>
