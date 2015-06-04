module counter(clk,reset,ain,bin,ca,out);
input clk;
input reset;
input [7:0] ain,bin;
output reg ca;
output reg [8:0] out;

always @(posedge clk or negedge reset)
begin
out <= ain + bin;
ca <= out[8];
end
endmodule

                        

//working program
/*
module counter(clk,reset,ain,bin,out);
input clk;
input reset;
input [7:0] ain,bin;
output reg [7:0] out;
always @(posedge clk or negedge reset)
begin
out <= ain + bin;
end
endmodule
*/
