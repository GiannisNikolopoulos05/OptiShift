<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  session.setAttribute("role", "manager"); // demo

  request.setAttribute("pageTitle", "Delete Profile – OptiShift");
  request.setAttribute("activePage", "delete_profile");
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
      <h1>Διαγραφή ή Απενεργοποίηση Προφίλ Εργαζομένου</h1>
      <p class="subtitle">
        Επέλεξε τον εργαζόμενο και την ενέργεια που θέλεις να εκτελέσεις.
        Μπορείς να κάνεις απενεργοποίηση (Deactivate) ή οριστική διαγραφή (Hard Delete).
      </p>

      <!-- TODO: θα μπει DeleteProfileServlet στο action -->
      <form class="profile-form" action="#" method="post">
        <label for="employee">Επιλογή Εργαζομένου</label>
        <select id="employee" name="employeeId" required>
          <option value="">-- Επιλέξτε εργαζόμενο --</option>
          <option value="1">Γιώργος Παπαδόπουλος</option>
          <option value="2">Μαρία Νικολάου</option>
          <option value="3">Κώστας Δημητρίου</option>
        </select>

        <label for="action">Ενέργεια</label>
        <select id="action" name="action" required>
          <option value="">-- Επιλέξτε ενέργεια --</option>
          <option value="deactivate">Απενεργοποίηση</option>
          <option value="delete">Οριστική Διαγραφή</option>
        </select>

        <p class="warning">
          Προσοχή: Η οριστική διαγραφή (Hard Delete) δεν μπορεί να αναιρεθεί.
        </p>

        <div class="form-buttons">
          <button type="submit" class="submit-btn">Επιβεβαίωση</button>
          <a href="manager_home_OptiShift.jsp" class="back-btn">← Επιστροφή</a>
        </div>
      </form>
    </section>

    <jsp:include page="common/footer.jsp">
      <jsp:param name="text" value="AI Scheduling System · OptiShift"/>
    </jsp:include>
  </main>
</body>
</html>
