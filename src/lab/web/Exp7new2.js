var chart;
var cnt=0;




$(document).ready(function() {
    var plotting=function(){
                      this.showLoading("Loading Graph... Please Wait for few Seconds");
                        $.ajax({
                            url: 'FetchData?cnt='+cnt,
                            
                            type: "Get",
                            success:function(e){
                           
                           var series=chart.series[0];
                           var series1=chart.series[1];
                           for(var i=0;i<e.tvalues.length;i++){
//                               var shift=series.data.length>100;
                               var points=[e.tvalues[i],e.uvalues[i]];
                               series.addPoint(points);
                               points=[e.tvalues[i],e.setpoint[i]];
                               series1.addPoint(points);
                               
                           }
                           chart.redraw();
                           chart.hideLoading();
                           
                                
                            },
                            fail:function(e){
                                alert("Error");
                                    
                            }
                            
                        });

                        
                    }
        
        
    
        chart = new Highcharts.Chart({

            chart: {

                renderTo: 'graph',

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
        
        
    });
        
   
        


