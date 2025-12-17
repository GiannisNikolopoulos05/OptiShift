<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  if (!"employee".equals(session.getAttribute("role"))) {
    response.sendRedirect("login_OptiShift.jsp");
    return;
  }

  request.setAttribute("pageTitle", "OptiShift — Employee Home");
  request.setAttribute("activePage", "employee_home");
%>
<!DOCTYPE html>
<html lang="el">
<head>
  <jsp:include page="common/head.jsp">
    <jsp:param name="css" value="employee_home.css"/>
  </jsp:include>
</head>
<body>
  <jsp:include page="common/header.jsp"/>

  <main class="container">
    <section class="welcome">
      <h1>Καλωσήρθες, <%= session.getAttribute("firstname") %></h1>
      <p class="subtitle">
        Από εδώ μπορείς να δηλώσεις τη διαθεσιμότητά σου,
        να δεις το εβδομαδιαίο πρόγραμμα βαρδιών σου και να ενημερώνεσαι
        για τυχόν αλλαγές ή ανακοινώσεις.
      </p>

      <ul class="helper-list">
        <li><span>My Availability</span> — Δήλωσε ημέρες, ώρες και προτιμήσεις για την επόμενη εβδομάδα.</li>
        <li><span>Schedule</span> — Δες το τελικό πρόγραμμα βαρδιών σου, καθώς και τυχόν αλλαγές.</li>
        <li><span>Notifications</span> — Λάβε ενημερώσεις για τροποποιήσεις στο πρόγραμμα ή νέα αιτήματα.</li>
      </ul>
    </section>

    <jsp:include page="common/footer.jsp">
      <jsp:param name="text" value="AI Scheduling System · Employee Portal · OptiShift"/>
    </jsp:include>
  </main>
</body>
</html>
