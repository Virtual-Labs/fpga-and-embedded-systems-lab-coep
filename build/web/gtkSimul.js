function getVcd()
{
//var parameters="FileName="+document.F1.filename.value;
var url="readVcd.jsp"; //+parameters;
if (window.XMLHttpRequest)
{// code for IE7+, Firefox, Chrome, Opera, Safari
xmlhttp=new XMLHttpRequest();
}
else
{// code for IE6, IE5
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}

xmlhttp.open("GET",url,false);
xmlhttp.send(null);

document.getElementById('files').innerHTML=xmlhttp.responseText;
}

function simulate(){
var url="displayGtk.jsp"; //+parameters;
if (window.XMLHttpRequest)
{// code for IE7+, Firefox, Chrome, Opera, Safari
xmlhttp=new XMLHttpRequest();
}
else
{// code for IE6, IE5
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}

xmlhttp.open("GET",url,false);
xmlhttp.send(null);

document.getElementById('gtk').src=xmlhttp.responseText;
}