<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String BASE = request.getContextPath() + "/OptiShift_Code";

    // Guard: μόνο manager
    String role = (session == null) ? null : (String) session.getAttribute("role");
    if (role == null || !"manager".equalsIgnoreCase(role)) {
        response.sendRedirect(BASE + "/login_OptiShift.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="el">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Create Profile – OptiShift</title>

  <link rel="stylesheet" href="<%= BASE %>/css/create_profile.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    /* Overlay message (δεν επηρεάζει layout) */
    .toast-overlay{
      position: fixed;
      top: 110px;               /* λίγο κάτω από navbar */
      left: 50%;
      transform: translateX(-50%);
      z-index: 9999;
      width: min(560px, calc(100% - 40px));
      display: flex;
      justify-content: center;
      pointer-events: none;     /* να μην μπλοκάρει clicks στη φόρμα */
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
      transition: opacity .22s ease, transform .22s ease;
      transform: translateY(0);
    }
    .toast.hide{
      opacity: 0;
      transform: translateY(-6px);
    }
    .toast .icon{
      font-weight: 700;
      margin-top: 1px;
    }
    .toast.success{
      background: #d7ffd9;
      color: #256428;
      border: 1px solid rgba(37,100,40,0.25);
    }
    .toast.error{
      background: #ffd9d9;
      color: #7b2a2a;
      border: 1px solid rgba(123,42,42,0.25);
    }
  
    /* Auto-hide toast without JavaScript (matches previous timing ~3.53s + 0.22s fade) */
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
  <!-- ======== NAVBAR ======== -->
  <header class="topbar">
    <div class="brand">OptiShift</div>

    <nav class="nav" aria-label="Κύρια Πλοήγηση">
      <a href="<%= BASE %>/manager_home_OptiShift.jsp">Home</a>

      <div class="dropdown active-parent">
        <button class="dropbtn active">Manage Profiles</button>
        <div class="dropdown-content">
          <a href="<%= BASE %>/create_profile_OptiShift.jsp" class="active">Create Profile</a>
          <a href="<%= BASE %>/delete_profile_OptiShift.jsp">Delete Profile</a>
        </div>
      </div>

      <a href="#">My Schedule</a>
      <a href="#">View Preferences</a>
      <a href="#">Forecast</a>
      <a href="#">Notifications</a>
    </nav>
  </header>

  <%-- SUCCESS overlay --%>
  <% if (request.getAttribute("successMsg") != null) { %>
    <div class="toast-overlay" id="toastWrap">
      <div class="toast success" id="toastMsg">
        <div><%= request.getAttribute("successMsg") %></div>
      </div>
    </div>
<% } %>

<%-- ERROR overlay --%>
<% if (request.getAttribute("errorMsg") != null) { %>
  <div class="toast-overlay" id="toastWrap">
    <div class="toast error" id="toastMsg">
      <div style="width:100%; text-align:center;">
        Το username ή το email χρησιμοποιείται ήδη!
      </div>
    </div>
  </div>
<% } %>


  <!-- ======== MAIN CONTENT ======== -->
  <main class="container">
    <section class="welcome">
      <h1>Δημιουργία Νέου Προφίλ Εργαζομένου</h1>
      <p class="subtitle">
        Συμπλήρωσε τα στοιχεία του νέου εργαζομένου και πάτησε «Αποθήκευση».<br>
        Όλα τα πεδία είναι υποχρεωτικά.
      </p>

      <form class="profile-form"
            action="<%=request.getContextPath()%>/servlet/optishift_group37.CreateEmployeeServlet"
            method="post">

        <label for="firstName">Όνομα</label>
        <input type="text" id="firstName" name="firstName" placeholder="π.χ. Μαρία" required>

        <label for="lastName">Επώνυμο</label>
        <input type="text" id="lastName" name="lastName" placeholder="π.χ. Νικολάου" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="example@email.com" required>

        <label for="phone">Τηλέφωνο</label>
        <input type="tel" id="phone" name="phone" placeholder="π.χ. 6987654321" required>

        <label for="username">Username</label>
        <input type="text" id="username" name="username" placeholder="username" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="********" required>

        <div class="form-buttons">
          <button type="submit" class="submit-btn">Αποθήκευση</button>
          <button type="button" class="back-btn"
                  onclick="window.location.href='<%= BASE %>/manager_home_OptiShift.jsp'">
            ← Επιστροφή
          </button>
        </div>
      </form>
    </section>

    <section class="footnote">
      AI Scheduling System · OptiShift
    </section>
  </main>
</body>
</html>
