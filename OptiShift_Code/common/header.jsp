<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String role = (String) session.getAttribute("role"); // "manager" ή "employee"
  String activePage = (String) request.getAttribute("activePage");
  if (activePage == null) activePage = "";

  boolean inManageProfiles = activePage.equals("create_profile") || activePage.equals("delete_profile");

  String BASE = request.getContextPath() + "/OptiShift_Code/";
%>

<header class="topbar">
  <div class="brand">OptiShift</div>

  <nav class="nav" aria-label="Κύρια Πλοήγηση">

    <% if ("manager".equals(role)) { %>
      <a href="<%= BASE %>manager_home_OptiShift.jsp" class="<%= activePage.equals("manager_home") ? "active" : "" %>">Home</a>

      <div class="dropdown <%= inManageProfiles ? "active-parent" : "" %>">
        <button class="dropbtn <%= inManageProfiles ? "active" : "" %>">Manage Profiles</button>
        <div class="dropdown-content">
          <a href="<%= BASE %>create_profile_OptiShift.jsp" class="<%= activePage.equals("create_profile") ? "active" : "" %>">Create Profile</a>
          <a href="<%= BASE %>delete_profile_OptiShift.jsp" class="<%= activePage.equals("delete_profile") ? "active" : "" %>">Delete Profile</a>
        </div>
      </div>

      <a href="#">My Schedule</a>
      <a href="#">View Preferences</a>
      <a href="#">Forecast</a>
      <a href="#">Notifications</a>

    <% } else if ("employee".equals(role)) { %>
      <a href="<%= BASE %>employee_home_OptiShift.jsp" class="<%= activePage.equals("employee_home") ? "active" : "" %>">Home</a>
      <a href="<%= BASE %>MyAvailability_OptiShift.jsp" class="<%= activePage.equals("my_availability") ? "active" : "" %>">My Availability</a>
      <a href="#">Schedule</a>
      <a href="#">Notifications</a>

    <% } else { %>
      <a href="<%= BASE %>login_OptiShift.jsp" class="<%= activePage.equals("login") ? "active" : "" %>">Login</a>
    <% } %>

  </nav>
</header>
