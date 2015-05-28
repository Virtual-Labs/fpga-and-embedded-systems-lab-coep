
var timeout         = 500;
var closetimer		= 0;
var ddmenuitem      = 0;
var delay=0; // Global element
var led;
var ledstatus=10;
var currentWorkingSwitch;
var swEnable=0;
var run_click=0;
var shifting=0;
var start=0;
var end=0;
var device;

function loadMyPrograms(filename){
    var url="loadMyPrograms.jsp?mypro="+filename;
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
     
    editAreaLoader.setValue("prog", xmlhttp.responseText);
    
}

function showWorkspace(){
          
    var url="showWorkspace.jsp";
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
     

    alert(xmlhttp.responseText);  
}

function callSaveAs(){

    alert("hi");
    var data=editAreaLoader.getValue("prog");
    
    var url="SaveAsOnClient?dataToSave="+data;
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
    


}






////////////////////////////////////////////////////////////////////////////////////////////////////////////
function callCCompile()
{

    var parameters="FileName="+document.F1.filename.value; //+"&tb="+tb;
    // var url="new.jsp?Prog="+param;
    var url="compilec.jsp?"+parameters;
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

    document.getElementById('output').innerHTML=xmlhttp.responseText;

//var tb=confirm("Do you want to generate the Test Bench for this program ?");
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////

function callCrossCompile(){
    var parameters="FileName="+document.F1.filename.value; //+"&tb="+tb;
    // var url="new.jsp?Prog="+param;
    var url="crossCompile.jsp?"+parameters;
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
    document.getElementById('output').innerHTML=xmlhttp.responseText;

}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

function callCompile()
{
    //verilogSyntaxPro();
    $("#cmpl").attr("style","background-color: #5970B2");
    $("#exec").attr("style","background-color: #6B8E23");
    var url="isDeviceSelected.jsp";
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

    device=xmlhttp.responseText;

    if(device.search("Device is selected")==-1){
        alert("Please Select the device first!!");
    }else{
        var parameters="FileName="+document.F1.filename.value; //+"&tb="+tb;
        // var url="new.jsp?Prog="+param;
        url="compilevl.jsp?"+parameters;
        //alert(url);
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

        document.getElementById('output').innerHTML=xmlhttp.responseText;
        var output=xmlhttp.responseText;
        if(output.search("Compiled successfully with 0 errors")==-1){
            alert(output);
        }else {
            var tb=confirm("Do you want to generate the Test Bench for this program ?");
            if(tb){
                var width  = 600;
                var height = 600;
                var left   = (screen.width  - width)/2;
                var top    = (screen.height - height)/2;
                var params = 'width='+width+', height='+height;
                params += ', top='+top+', left='+left;
                params += ', directories=no';
                params += ', location=yes';
                params += ', menubar=no';
                params += ', resizable=no';
                params += ', scrollbars=no';
                params += ', status=no';
                params += ', toolbar=no';

                //                window.open("http://59.163.223.71:8084/FPGAExp1/loadTbMapping.jsp?FileName="+document.F1.filename.value ,"Test Bench Generation Data Mapping",params);
                window.open("http://coepvlab.ac.in:28090/FPGAExp1/loadTbMapping.jsp?FileName="+document.F1.filename.value ,"Test Bench Generation Data Mapping",params);
            }

        }
    }
//var tb=confirm("Do you want to generate the Test Bench for this program ?");
}
/////////////////////////////////////////////////////////////
function callCExecute()
{
    var parameters="FileName="+document.F1.filename.value;
    //var url="new.jsp?Prog="+param;
    var url="executec.jsp?"+parameters;
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
     
    document.getElementById('output').innerHTML=xmlhttp.responseText;

}
/////////////////////////////////////////////////////////////
function callExecute()
{
    $("#exec").attr("style","background-color: #5970B2");
    $("#tanalysis").attr("style","background-color: #6B8E23");
    var parameters="FileName="+document.F1.filename.value;
    //var url="new.jsp?Prog="+param;
    var url="executevl.jsp?"+parameters;
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
     
    document.getElementById('output').innerHTML=xmlhttp.responseText;

}
function callRefresh()
{
    //alert("Hi.....");
    //document.getElementById('output').innerHTML="Session refreshed.";
    document.F1.program.value="";
    editAreaLoader.setValue("prog", "");
}
function loadProg(id,expNo)
{
    var url="loadProg.jsp?id="+id+"&expNo="+expNo;
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
    document.F1.program.value=xmlhttp.responseText;
    editAreaLoader.setValue("prog",xmlhttp.responseText);
}




/// / open hidden layer
function mopen(id)
{
    // cancel close timer
    mcancelclosetime();

    // close old layer
    if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';

    // get new layer and show it
    ddmenuitem = document.getElementById(id);
    ddmenuitem.style.visibility = 'visible';

}
// close showed layer
function mclose()
{
    if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
}

// go close timer
function mclosetime()
{
    closetimer = window.setTimeout(mclose, timeout);
}

// cancel close timer
function mcancelclosetime()
{
    if(closetimer)
    {
        window.clearTimeout(closetimer);
        closetimer = null;
    }
}

// close layer when click-out
document.onclick = mclose;

function open1(){
    var led= window.open('LED.html','Peripheral-LED','width=380,height=180,toolbar=no,location=yes,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=yes,left=800,top=700,screenX=800,screenY=700');
}

function open2(){
    var uart=window.open('UART.html','Peripheral-UART','width=380,height=180,toolbar=no,location=yes,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=yes,left=600,top=700,screenX=600,screenY=700')
}

function open3(){
    var adc= window.open('ADC.html','Peripheral-ADC','width=380,height=180,toolbar=no,location=yes,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=yes,left=400,top=700,screenX=400,screenY=700');
}

function open4(){
    var scope= window.open('scope.html','Peripheral-Scope','width=380,height=180,toolbar=no,location=yes,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=yes,left=200,top=700,screenX=200,screenY=700');
}

function open5(){
    var timer= window.open('timer.html','Peripheral-timer','width=380,height=180,toolbar=no,location=yes,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=yes,left=0,top=700,screenX=0,screenY=700');
}


function setDevice(name,clk){
    //alert("hi");
    $("#select-device").attr("style","background-color: #5970B2");
    $("#animating").attr("style","background-color: #6B8E23");
    document.getElementById("device").innerHTML=name;

    var url="setSession.jsp?clk="+clk+"&device="+name;
    if (window.XMLHttpRequest)
    {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.open("GET",url,false);
    xmlhttp.send(null); 
    document.getElementById('cmpl').setAttribute("onmouseover","mopen('m6')");
    document.getElementById('exec').setAttribute("onmouseover","mopen('m22')");
    //document.getElementById('ccmpl').setAttribute("onmouseover","mopen('m7')");
    document.getElementById('lpgm').setAttribute("onmouseover","mopen('mloadprog')");
    // document.getElementById('ypgm').setAttribute('onmouseout',"mclosetime()");
    document.getElementById('cmpl').title="Complie";
    document.getElementById('exec').title="Execute";
    //document.getElementById('ccmpl').title="Cross Compile";
    document.getElementById('lpgm').title="Load generated program";
    //alert(document.getElementById('expnum').value);
    var expLax=document.getElementById('expnum').value;
    
    var pp;
    //    alert("Hi");
    if(expLax=='1'){
        document.getElementById('liframe').src="animateexp1.jsp";
        document.getElementById('animating').setAttribute("href","animateexp1.jsp");
        document.getElementById('animating').title="Introduction to Verilog Programming Input";
        document.getElementById('tanalysis').title="Timing Analysis";
        document.getElementById('rutil').title="Resource Utilisation";
        document.getElementById('tanalysis').setAttribute("href","WaveDrom.jsp");
        document.getElementById('rutil').setAttribute("href","resourceutil.jsp");
       
    }
    
    if(expLax=="10"){
            document.getElementById('liframe').src="animateexp7new.jsp";
            document.getElementById('animating').setAttribute("href","animateexp7new.jsp");
            document.getElementById('animating').title="Animated Designing of reconfigurable architecture for PID controller Input";
            document.getElementById('tanalysis').title="Timing Analysis";
            document.getElementById('rutil').title="Resource Utilisation";
            document.getElementById('tanalysis').setAttribute("href","WaveDrom1.jsp");
            document.getElementById('rutil').setAttribute("href","resourceutil.jsp");
        }
        
   if(expLax=="8"){
            document.getElementById('liframe').src="animateexp4.jsp";
            document.getElementById('animating').setAttribute("href","animateexp4.jsp");
            document.getElementById('animating').title="Animated Designing of Pulse-Width Modulation (PWM) Generation Using FPGA";
            document.getElementById('floorPlan').title="Floor Plan";
            document.getElementById('tanalysis').title="Timing Analysis";
            document.getElementById('rutil').title="Resource Utilisation";
            document.getElementById('tanalysis').setAttribute("href","WaveDrom2.jsp");
            document.getElementById('floorPlan').setAttribute("href","FloorPlan.jsp");
            document.getElementById('rutil').setAttribute("href","resourceutil.jsp");
        }
    
    // alert(expLax);
    if((expLax=="7")||(expLax=="2") ||(expLax=="5") || (expLax=="3") || (expLax=="6") || (expLax=="4") || (expLax=="9"))//for specific experiments currently for 4,2,3,5,6,7
    {
       
        if(expLax=="6"){
            document.getElementById('liframe').src="animate.jsp";
            document.getElementById('animating').setAttribute("href","animate.jsp");
            document.getElementById('animating').title="Animated Matrix Input";
        
        }
        if(expLax=="3"){
            document.getElementById('liframe').src="animateexp2.jsp";
            document.getElementById('animating').setAttribute("href","animateexp2.jsp");
            document.getElementById('animating').title="Animated Verilog Operators Input";
        
        }
        if(expLax=="7"){
            document.getElementById('liframe').src="animateexp5.jsp";
            document.getElementById('animating').setAttribute("href","animateexp5.jsp");
            document.getElementById('animating').title="Animated Linear Equation Solver Input";
        
        }
        
        if(expLax=="9"){
            document.getElementById('liframe').src="animateexp3.jsp";
            document.getElementById('animating').setAttribute("href","animateexp3.jsp");
            document.getElementById('animating').title="Animated Architectural Design Input";
        
        }
        if(expLax=="4"){
            document.getElementById('liframe').src="animateexp6.jsp";
            document.getElementById('animating').setAttribute("href","animateexp6.jsp");
            document.getElementById('animating').title="Animated Floating Point Arithmetics Input";
        
        }
        
        if(expLax=="5"){
            document.getElementById('liframe').src="animateexpLNS.jsp";
            document.getElementById('animating').setAttribute("href","animateexpLNS.jsp");
            document.getElementById('animating').title="Animated Designing of Logarithmic Number System (LNS) Based Arithmetic Operations";
        
        }
        
        if(expLax=="2"){
            document.getElementById('liframe').src="animateExp2New.jsp";
            document.getElementById('animating').setAttribute("href","animateExp2New.jsp");
            document.getElementById('animating').title="Introduction to different verilog abstraction levels";
        
        }
        
        document.getElementById('tanalysis').title="Timing Analysis";
        document.getElementById('rutil').title="Resource Utilisation";
        document.getElementById('tanalysis').setAttribute("href","WaveDrom.jsp");
        document.getElementById('rutil').setAttribute("href","resourceutil.jsp");
       
                         
    }
    
        
        
        
}

function callExit(){
    if(confirm("Do you really want to close the Simulator"))
    {
        window.close();
    }
}



function verilogSyntaxPro(){

    var url="verilogSyntaxPro.jsp?FileName="+document.F1.filename.value;
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
    document.getElementById("bugs").innerHTML=xmlhttp.responseText;

}


        
function loadsavedprog()
{
    $("#lpgm").attr("style","background-color: #5970B2");
    $("#save-on-server").attr("style","background-color: #6B8E23");
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    var url="checkloaded.jsp";
    xmlhttp.open("GET",url,false);
    xmlhttp.send(null);
    var laxk=xmlhttp.responseText;
    var laxpk="Program not loaded";
    var laxkp="Your Session has been expired...Please Login Again";
    //alert(laxk.trim()==laxpk);

    if(laxk.trim()!=laxpk){
        //alert("hi");
        if(laxk.trim()!=laxkp){
            url="loadPrograms.jsp";


            xmlhttp.open("GET",url,false);
            xmlhttp.send(null);

            document.F1.program.value=xmlhttp.responseText;
            editAreaLoader.setValue("prog", xmlhttp.responseText);
        }
        else
        {
            alert(laxkp);
        }
        
    }
    //alert(xmlhttp.responseText);
    if(laxk.trim()==laxpk ){
        alert("Generate verilog code through Animation");
    }
         
          
   
}
        
        
        
function loadRules()
{
    var par=document.getElementById('Fname').value;
    url="SaveVerilog?fname="+par;
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
    //document.getElementById('output').innerHTML=xmlhttp.responseText;
    document.location.reload();

}

function callFromChildPage(){
   // $("#animating").attr("style","background-color: #5970B2");
    $("#lpgm").attr("style","background-color: #6B8E23");
    
}