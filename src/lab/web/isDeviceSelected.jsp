<%
    String device = (String) session.getAttribute("device");
    if (device == null) {
%>
The Device is not selected Yet!!!!!!!!!
<% } else {
%>
Device is selected
<% }%>