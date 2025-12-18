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
  .form-error{
    margin: 6px 0 12px;
    padding: 10px 12px;
    background: #fff5f5;
    color: #b42318;

    /* αφαιρεί το κόκκινο αριστερά */
    border-left: none;

    border-radius: 10px;
    font-size: 13px;
    line-height: 1.3;
    box-shadow: 0 6px 14px rgba(0,0,0,.12);

    /* κεντρική στοίχιση */
    text-align: center;

    opacity: 1;
    transition: opacity .2s ease, transform .2s ease;
  }

  .form-error.hide{
    opacity: 0;
    transform: translateY(-4px);
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
        <!-- ΕΔΩ: κάτω από remember me και πάνω από το κουμπί -->
        <div class="form-error" id="loginErrorBox"><%= errorMsg %></div>
      <% } %>

      <button type="submit" class="primary-btn">Σύνδεση</button>
    </form>
  </div>

  <script>
    (function(){
      var u = document.getElementById("username");
      var p = document.getElementById("password");
      var errBox = document.getElementById("loginErrorBox");

      function hideErr(){
        if (!errBox) return;
        errBox.classList.add("hide");
        setTimeout(function(){
          if (errBox) errBox.style.display = "none";
        }, 220);
      }

      // Αν πάει να πληκτρολογήσει/κλικάρει -> να φύγει αμέσως
      ["focus","click","input","keydown"].forEach(function(ev){
        if (u) u.addEventListener(ev, hideErr);
        if (p) p.addEventListener(ev, hideErr);
      });
    })();
  </script>
</body>
</html>
