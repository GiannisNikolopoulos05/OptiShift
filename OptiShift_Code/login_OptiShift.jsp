<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="el">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Είσοδος Χρήστη – OptiShift</title>

  <!-- αν το login.css είναι μέσα στον φάκελο css -->
  <link rel="stylesheet" href="css/login.css">

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
  <div class="container">
    <div class="brand-title">
      <div class="main">OptiShift</div>
      <div class="sub">AI Scheduling System</div>
    </div>

    <!-- IMPORTANT: InvokerServlet call (ΔΕΝ αλλάζουμε web.xml) -->
    <form class="login-form"
          action="<%=request.getContextPath()%>/servlet/optishift_group37.LoginServlet"
          method="post">

      <label for="username">Όνομα Χρήστη</label>
      <input type="text" id="username" name="username" required>

      <label for="password">Κωδικός Πρόσβασης</label>
      <input type="password" id="password" name="password" required>

      <div class="remember">
        <input type="checkbox" id="remember" name="remember">
        <label for="remember">Remember me</label>
      </div>

      <% if (request.getAttribute("errorMsg") != null) { %>
        <div style="margin:10px 0; padding:10px; border-radius:8px; background:#ffd9d9; color:#7b2a2a;">
          <%= request.getAttribute("errorMsg") %>
        </div>
      <% } %>

      <button type="submit" class="primary-btn">Σύνδεση</button>
    </form>
  </div>
</body>
</html>
