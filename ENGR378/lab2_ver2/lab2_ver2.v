//Jin Chul, Rhim 
// Lab 2. Arithmetic Circuit  



/*
	Multiplexer
	Input: 4 input 
	Selector: 2 selector 
	Output: 1 output 
*/

module Multiplexer4by1 (Cin, s,Cout);
	input [3:0]Cin;
	input [1:0]s;
	output Cout; 
	
	assign Cout = Cin[s]; 
	
endmodule
	
	
/*
	Full Adder 
	Input: A, B, Carry In
	Output: carry out
*/

	
module FullAdder(A,B,Cin,Sum,Cout);
	input A;
	input B; 
	input Cin;
	output Sum; 
	output Cout; 
	
	// XOR = (A+B)*(A'+B')
	// Sum = ((A XOR B) XOR Cin)
	
	assign Sum = (A ^ B) ^ Cin; 
	assign Cout = (A && B) || (A && Cin) || (Cin && B);
	
endmodule
// S1 S0
// 00: A + B + Cin 
// 01: A + B' + Cin
// 10: A' + B + Cin 
// 11: B' + Cin

module Arithmetic_Circuit(Cin, S, A, B, D, Cout);
	input Cin; 
	input [1:0]S; 
	input [3:0]A; 
	input [3:0]B; 
	
	output[3:0]D;
	output Cout; 
	
	wire [3:0]A_FAinput; 
	wire [3:0]B_FAinput;
	wire [2:0]Cout_Wire; 
	
	//Multiplexer4by1 (Cin,S,Cout)
	//Multiplexer for A[3:0]
	
	Multiplexer4by1 MP0(.Cin({~S[1],~A[0],A[0], A[0]}),.s(S), .Cout(A_FAinput[0]));
	Multiplexer4by1 MP2(.Cin({~S[1],~A[1],A[1], A[1]}),.s(S), .Cout(A_FAinput[1]));
	Multiplexer4by1 MP4(.Cin({~S[1],~A[2],A[2], A[2]}),.s(S), .Cout(A_FAinput[2]));
	Multiplexer4by1 MP6(.Cin({~S[1],~A[3],A[3], A[3]}),.s(S), .Cout(A_FAinput[3]));
	
	//Multiplexer for B[3:0]
	
	Multiplexer4by1 MP1(.Cin({~B[0], B[0],~B[0],B[0]}),.s(S), .Cout(B_FAinput[0]));
	Multiplexer4by1 MP3(.Cin({~B[1], B[1],~B[1],B[1]}),.s(S), .Cout(B_FAinput[1]));
	Multiplexer4by1 MP5(.Cin({~B[2], B[2],~B[2],B[2]}),.s(S), .Cout(B_FAinput[2]));
	Multiplexer4by1 MP7(.Cin({~B[3], B[3],~B[3],B[3]}),.s(S), .Cout(B_FAinput[3]));
	
	
	FullAdder FA0(A_FAinput[0], B_FAinput[0], Cin, D[0], Cout_Wire[0]);
	FullAdder FA1(A_FAinput[1], B_FAinput[1], Cout_Wire[0], D[1], Cout_Wire[1]);
	FullAdder FA2(A_FAinput[2], B_FAinput[2], Cout_Wire[1], D[2], Cout_Wire[2]);
	FullAdder FA3(A_FAinput[3], B_FAinput[3], Cout_Wire[2], D[3], Cout);



	//final output 
	// D[0], D[1], D[2], D[3] and Cout_Wire[3]
	
endmodule
	
	

	
	
	
	