var chart;
var cnt=0;




$(document).ready(function() {
        $("#genGraph2").bind({
           click:function(){
               var plotting=function(){
                      this.showLoading("Loading Graph... Please Wait for few Seconds...");
                        $.ajax({
                            url: 'FetchDataSecond?cnt='+cnt,
                            
                            type: "Get",
                            success:function(e){
                           
                           var series=chart.series[0];
                           var series1=chart.series[1];
                           for(var i=0;i<e.timevalue.length;i++){
//                               var shift=series.data.length>100;
                               var points=[e.timevalue[i],e.u[i]];
                               series.addPoint(points);
                               points=[e.timevalue[i],e.spvalues[i]];
                               series1.addPoint(points);
                               
                           }
                           chart.redraw();
                           chart.hideLoading();
                           
                                
                            },
                            fail:function(e){
                                alert("Error");
                                    
                            }
                            
                        });
//                        if(cnt<15000){
//                            cnt=cnt+100;
//                            setTimeout( plotting,5000 );
//                        }
//                        else
//                            clearTimeOut();
                        
                    }
        

        chart = new Highcharts.Chart({

            chart: {

                renderTo: 'graph2',

                type: 'spline',

                events : {
                    load : plotting
                }
             

            },
            
            loading: {
              
              labelStyle:
                  {
                  color : 'white'
                  },
              
              style:{
                  backgroundColor: 'gray'
              }
            },

            title: {

                text: 'GRAPH'

                

            },

           

            xAxis: {

                type : 'linear',
                tickPixelInterval : 50,
                title : {
                    text : 'Time(msec)',
                    margin : 20
                }
                

            },

            yAxis : {
                minPadding : 0.2,
                maxPadding : 0.2,
                title : {
                    text : 'Output',
                    margin : 20
                }
            },

              

            tooltip: {

                formatter: function() {

                    return '<b>'+ this.series.name +'</b><br/>'+

                    this.x +': '+ this.y;

                }

            },
            
            plotOptions: {

                spline: {

                    marker: {

                        radius: 1,

                        lineColor: '#666666',

                        lineWidth: 1

                    }

                }

            },

            
            series : [ {
                name : 'Input Trend',
                data : []
            },
         {
                name : 'Set Point',
                data : []
            }]

        
        });
           } 
        });
        
        
    });
        
   
        


