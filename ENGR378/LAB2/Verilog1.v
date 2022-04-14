



module multiplexer4by1(n,s,f);
	input [3:0] n;
	input [1:0] s;
	output f; 
	
	assign f = n[s]; 
	// s = 00 01 10 11 
	// n[s[0]] is possible
	endmodule;
	
	


	
module FullAdder(A,B,Cin,Cout, sum); 
	input A;
	input B; 
	input Cin; 
	output Cout; 
	output Sum; 
	
	wire n, m, q;
	
	assign n = (~A || B) && (A || ~B); 
	assign m = (n && Cin); 
	assign q = A && B;  
	
	assign Sum = (~n || Cin) && (n || ~Cin); 
	assign Cout = m || q; 

endmodule;

module ArithmeticOperator()

	input initial_Cin; 
	input [1:0] s;
	input [3:0] A; 
	input [3:0] B; 
	
	output[3:0] sum; 
	output final_Cout; 
	
	wire [3:0] A_input; 
	wire [3:0] B_input;
	wire [2:0] cout; 
	
	FullAdder FA0 (A[0], B[0], initial_Cin, Cout[0], sum[0] );
	FullAdder FA1 (A[1], B[1], cout[0], cout[1], sum[1]);
	FullAdder FA2 (A[2], B[2], cout[1], cout[2], sum[2]); 
	FullAdder FA3 (A[3], B[3], cout[2], cout[3], sum[3]);
	
endmodule; 
	
	
	

	
	


	
	