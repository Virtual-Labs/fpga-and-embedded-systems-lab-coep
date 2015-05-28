<%-- 
    Document   : linuxEmulator
    Created on : 21 Jun, 2011, 11:38:30 AM
    Author     : root
--%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<style type="text/css">
<!--.term {
    font-family: courier,fixed,swiss,monospace,sans-serif;
    font-size: 14px;
    color: #f0f0f0;
    background: #000000;
}

.termReverse {
    color: #000000;
    background: #00ff00;
}
#note {
    font-size: 12px;
}
#copyright {
    font-size: 10px;
}
#clipboard {
    font-size: 12px;
}-->
</style>
</head>
<body onload="start()">
<table border="0">
<tr valign="top"><td>
<script type="text/javascript" src="term.js"></script>

<script type="text/javascript" src="jslinux.js"></script>
<div id="copyright">&copy; 2011 Fabrice Bellard - <a href="news.html">News</a> - <a href="faq.html">FAQ</a> - <a href="tech.html">Technical notes</a></div>
<td><input type="button" value="Clear clipboard" onclick="clear_clipboard();"><br><textarea row="4" cols="16" id="text_clipboard"></textarea>

</table>
</body>
</html>
