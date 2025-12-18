<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String errorMsg = (String) session.getAttribute("errorMsg");
  if (errorMsg == null) {
    errorMsg = (String) request.getAttribute("errorMsg");
  }

  // να εμφανιστεί 1 φορά και μετά να καθαρίσει
  if (session.getAttribute("errorMsg") != null) {
    session.removeAttribute("errorMsg");
  }
%>
<!DOCTYPE html>
<html lang="el">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Είσοδος Χρήστη – OptiShift</title>

  <link rel="stylesheet" href="css/login.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    /* Inline error message όπως στις εικόνες + λίγο κενό από κάτω */
    .inline-error{
      margin-top: 8px;
      margin-bottom: 14px; /* αυτό το κάνει “πιο πάνω” από το κουμπί */
      font-size: 13px;
      color: #9b2c2c;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="brand-title">
      <div class="main">OptiShift</div>
      <div class="sub">AI Scheduling System</div>
    </div>

    <form class="login-form"
          action="<%=request.getContextPath()%>/servlet/optishift_group37.LoginServlet"
          method="post"
          id="loginForm">

      <label for="username">Όνομα Χρήστη</label>
      <input type="text" id="username" name="username" required>

      <label for="password">Κωδικός Πρόσβασης</label>
      <input type="password" id="password" name="password" required>

      <div class="remember">
        <input type="checkbox" id="remember" name="remember">
        <label for="remember">Remember me</label>
      </div>

      <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
        <div class="inline-error" id="loginError"><%= errorMsg %></div>
      <% } %>

      <button type="submit" class="primary-btn">Σύνδεση</button>
    </form>
  </div>

  <script>
    (function(){
      var u = document.getElementById("username");
      var p = document.getElementById("password");
      var err = document.getElementById("loginError");

      function hideErr(){
        if (err) err.style.display = "none";
      }

      // Θέλω να φεύγει ΜΕ ΤΟ ΠΟΥ πατήσεις click ή focus
      ["focus","click","input","keydown"].forEach(function(ev){
        if (u) u.addEventListener(ev, hideErr);
        if (p) p.addEventListener(ev, hideErr);
      });
    })();
  </script>
</body>
</html>



