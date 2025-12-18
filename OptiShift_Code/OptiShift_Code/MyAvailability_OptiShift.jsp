<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  session.setAttribute("role", "employee"); // demo

  request.setAttribute("pageTitle", "My Availability – OptiShift");
  request.setAttribute("activePage", "my_availability");
%>
<!DOCTYPE html>
<html lang="el">
<head>
  <jsp:include page="common/head.jsp">
    <jsp:param name="css" value="MyAvailability.css"/>
  </jsp:include>
</head>
<body>
  <jsp:include page="common/header.jsp"/>

  <main class="container">
    <section class="welcome">
      <h1>My Availability</h1>
      <p class="subtitle">
        Δήλωσε για κάθε ημέρα της εβδομάδας αν μπορείς να δουλέψεις, αν προτιμάς
        να δουλέψεις ή αν θα ήθελες ρεπό. Στη συνέχεια πάτησε «Submit Preferences».
      </p>

      <!-- TODO: θα μπει AvailabilityServlet στο action -->
      <form class="availability-form" action="#" method="post">
        <div class="week-grid">

          <div class="day-row">
            <div class="day-label">Δευτέρα</div>
            <div class="day-options">
              <label><input type="radio" name="monday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="monday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="monday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

          <div class="day-row">
            <div class="day-label">Τρίτη</div>
            <div class="day-options">
              <label><input type="radio" name="tuesday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="tuesday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="tuesday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

          <div class="day-row">
            <div class="day-label">Τετάρτη</div>
            <div class="day-options">
              <label><input type="radio" name="wednesday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="wednesday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="wednesday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

          <div class="day-row">
            <div class="day-label">Πέμπτη</div>
            <div class="day-options">
              <label><input type="radio" name="thursday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="thursday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="thursday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

          <div class="day-row">
            <div class="day-label">Παρασκευή</div>
            <div class="day-options">
              <label><input type="radio" name="friday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="friday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="friday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

          <div class="day-row">
            <div class="day-label">Σάββατο</div>
            <div class="day-options">
              <label><input type="radio" name="saturday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="saturday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="saturday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

          <div class="day-row">
            <div class="day-label">Κυριακή</div>
            <div class="day-options">
              <label><input type="radio" name="sunday" value="can" required> Μπορώ να δουλέψω</label>
              <label><input type="radio" name="sunday" value="prefer"> Προτιμώ να δουλέψω</label>
              <label><input type="radio" name="sunday" value="off"> Θέλω ρεπό</label>
            </div>
          </div>

        </div>

        <div class="note-block">
          <label for="notes">Σχόλια / ειδικές προτιμήσεις (προαιρετικό)</label>
          <textarea id="notes" name="notes" rows="3" placeholder="π.χ. Προτιμώ απογευματινές βάρδιες Τετάρτη–Παρασκευή."></textarea>
        </div>

        <div class="form-buttons">
          <button type="submit" class="submit-btn">Submit Preferences</button>
          <a href="employee_home_OptiShift.jsp" class="back-btn">Cancel</a>
        </div>
      </form>
    </section>

    <jsp:include page="common/footer.jsp">
      <jsp:param name="text" value="AI Scheduling System · Employee Availability · OptiShift"/>
    </jsp:include>
  </main>
</body>
</html>
