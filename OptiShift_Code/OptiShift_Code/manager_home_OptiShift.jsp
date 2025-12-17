<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  session.setAttribute("role", "manager"); // demo

  request.setAttribute("pageTitle", "OptiShift — Manager Home");
  request.setAttribute("activePage", "manager_home");
%>
<!DOCTYPE html>
<html lang="el">
<head>
  <jsp:include page="common/head.jsp">
    <jsp:param name="css" value="manager_home.css"/>
  </jsp:include>
</head>
<body>
  <jsp:include page="common/header.jsp"/>

  <main class="container">
    <section class="welcome">
      <h1>Καλωσήρθες, Manager</h1>
      <p class="subtitle">
        Διαχειρίσου προφίλ εργαζομένων, έλεγξε προτιμήσεις, δες προβλέψεις ζήτησης
        και οργάνωσε το εβδομαδιαίο πρόγραμμα — όλα από το επάνω μενού.
      </p>

      <ul class="helper-list">
        <li><span>Manage Profiles</span> — Δημιουργία/διαγραφή ή απενεργοποίηση εργαζομένων.</li>
        <li><span>My Schedule</span> — Προεπισκόπηση και δημοσίευση του προγράμματος.</li>
        <li><span>View Preferences</span> — Έλεγχος διαθέσιμων ζωνών & προτιμήσεων.</li>
        <li><span>Forecast</span> — Επισκόπηση προβλέψεων για βάρδιες/ζήτηση.</li>
        <li><span>Notifications</span> — Ενημερώσεις και αλλαγές προγράμματος.</li>
      </ul>
    </section>

    <jsp:include page="common/footer.jsp">
      <jsp:param name="text" value="AI Scheduling System · OptiShift"/>
    </jsp:include>
  </main>
</body>
</html>
