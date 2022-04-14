/*

module Arithmetic_Circuit(Cin, S, A, B, D, Cout);
	input Cin; 
	input [1:0]S; 
	input [3:0]A; 
	input [3:0]B; 
	
	output[3:0]D;
	output Cout; 
	
	wire [3:0]A_FAinput; 
	wire [3:0]B_FAinput;
	wire [3:0]Cout_Wire; 

module Arithmetic_Circuit(Cin, S, A, B, D, Cout);
*/

module top_tb(); 
	
	reg Cin; 
	reg[1:0] S; 
	reg [3:0] A; 
	reg [3:0] B; 

	integer c;
	integer m; 
	integer n;
	integer q;
 
	wire [3:0] D; 
	wire Cout;
	Arithmetic_Circuit AC(Cin, S, A, B, D, Cout);

	initial begin 
	Cin = 1'b0;
	S = 2'b0;
	A = 4'b0; 
	B = 4'b0; 
	
	#20;
/*
for (cin = 0 1) 
	for (S = 0 1 2 3)
		for (A = 0 ~ 15)
			for (B = 0 ~ 15) 
				test all 2048 cases
*/
	
	for (c= 0; c < 2; c = c + 1) begin
		for(m=0;m < 4; m = m +1) begin 
			for (n = 0; n < 16; n = n+1) begin 
				for (q = 0; q < 16; q = q+1) begin 
					B = B + 1;
					#20;
				end
				A = A + 1;
				#20;
			end
			S = S + 1; 
			#20;
		end
		Cin = Cin + 1;
	end



	end

	endmodule
	