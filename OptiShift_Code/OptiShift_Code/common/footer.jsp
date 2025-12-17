<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String footerText = request.getParameter("text");
  if (footerText == null || footerText.trim().length() == 0) {
    footerText = "AI Scheduling System · OptiShift";
  }
%>

<section class="footnote">
  <%= footerText %>
</section>
