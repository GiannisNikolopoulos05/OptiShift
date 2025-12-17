<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String pageTitle = (String) request.getAttribute("pageTitle");
  if (pageTitle == null) pageTitle = "OptiShift";

  String cssFile = request.getParameter("css");
  boolean hasCss = (cssFile != null && cssFile.trim().length() > 0);
%>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title><%= pageTitle %></title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<% if (hasCss) { %>
  <link rel="stylesheet" href="css/<%= cssFile %>">
<% } %>
