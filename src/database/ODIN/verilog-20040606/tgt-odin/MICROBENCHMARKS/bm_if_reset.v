// DEFINES
`define BITS 2         // Bit width of the operands

module 	bm_if_reset(clock, 
		reset_n, 
		a_in, 
		b_in,
		c_in, 
		d_in, 
		out0,
		out1);

// SIGNAL DECLARATIONS
input	clock;
input 	reset_n;

input [`BITS-1:0] a_in;
input [`BITS-1:0] b_in;
input c_in;
input d_in;

output [`BITS-1:0] out0;
output  out1;

reg [`BITS-1:0]    out0;
reg     out1;

wire [`BITS-1:0] temp_a;
wire [`BITS-1:0] temp_b;
wire temp_c;
wire temp_d;

a top_a(clock, a_in, b_in, temp_a);
//b top_b(clock, a_in, b_in, temp_b);
//c top_c(clock, c_in, d_in, temp_c);
//d top_d(clock, c_in, d_in, temp_d);

always @(posedge clock or negedge reset_n)
begin
	if (reset_n == 1'b0)
	begin
		out0 <= 2'b00;
		out1 <= 1'b0;
	end
	else
	begin
		out0 <= a_in & b_in;
		out1 <= c_in & d_in;
//		out0 <= temp_a & temp_b;
//		out1 <= temp_c & temp_d;
	end
end

endmodule

/*---------------------------------------------------------*/
module a(clock,
		a_in,
		b_in,
		out);

input	clock;
input [`BITS-1:0] a_in;
input [`BITS-1:0] b_in;
output [`BITS-1:0] out;
reg [`BITS-1:0] out;

always @(posedge clock)
begin
	case (a_in)
		2'b00: out <= 2'b11 ;
		2'b01: out <= 2'b10 ;
		2'b10: out <= 2'b01 ;
		2'b11: out <= 2'b00 ;
	endcase
end

endmodule

/*---------------------------------------------------------*/
/*
module b(clock,
		a_in,
		b_in,
		out);

input	clock;
input [`BITS-1:0] a_in;
input [`BITS-1:0] b_in;
output [`BITS-1:0]    out;
reg [`BITS-1:0] out;
reg [`BITS-1:0] temp;

always @(posedge clock)
begin
	temp <= a_in | b_in;
	out <= a_in ^ temp;
end

endmodule
*/
/*---------------------------------------------------------*/
/*
module 	c(clock, 
		c_in, 
		d_in, 
		out1);

// SIGNAL DECLARATIONS
input	clock;
input c_in;
input d_in;
output  out1;
reg     out1;
reg temp;

always @(posedge clock)
begin
	temp <= c_in & d_in;
	out1 <= temp ^ d_in;
end

endmodule
*/
/*---------------------------------------------------------*/
/*
module 	d(clock, 
		c_in, 
		d_in, 
		out1);

// SIGNAL DECLARATIONS
input	clock;
input c_in;
input d_in;
output  out1;
reg     out1;
reg temp;

always @(posedge clock)
begin
	temp <= c_in ^ d_in;
	out1 <= temp | d_in;
end
endmodule
*/
