# Verilog

## Chapter 2 

1. Combinational Circuits  
    1. concurrent statement / continuous assignment 
        1. already ready to execute 
        2. evaluated any time. 
        3. Every time right side always changes 
        4. execute repeatedly (as if they are in loop)

2. Combinational Logic Example 

```
assign #10 CLK = ~CLK;      //clock generator

assign #5 C = A&& B; 
assign #5 E = C || D;   

assign C[3] = A[3] && B[3];
assign C[2] = A[2] && B[2];
assign C[1] = A[1] && B[1];
assign C[0] = A[0] && B[0];

//Instead of this, use 4-bit vectors 

assign C = A & B;
```

3. Combinational Logic Modules 

```
module two_gates (A, B, D, E); 
output E; 

input A, B, D; 

wire C; 

    assign C = A && B;  
    assign E = C || D;   

endmodule

```

4. Combinational Logic - Full Adder 

```
module FullAdder(X, Y, Cin, Cout, Sum); 
output Cout, Sum; 

input X, Y, Cin; 
    assign #10 Sum = X ^ Y ^ Cin; 
    assign #10 Cout = (X && Y) || (X && Cin) || (Y && Cin); 
 endmodule

```

5. 4-bit adder with Full Adder 

```
module Adder4(S, Co, A, B, Ci);
output [3:0] S; 
output Co; 
input [3:0] A,B; 
input Ci; 

wire [3:1] C;  

FullAdder FA0(A[0], B[0], Ci, C[1], S[0]);
FullAdder FA0(A[1], B[1], C[1], C[2], S[1]);
FullAdder FA0(A[2], B[2], C[2], C[3], S[2]);
FullAdder FA0(A[3], B[3], C[3], Co, S[3]);

endmodule 

```


## Verilog Assignments 
Continuous Assignment | Procedural Assignment (always @ begin)
------------- | -------------
[assign] keyword  | "=" or "<=". Initial / Always Block
combinational logic circuits | Finite state machines 
All line executed together | "=" top-down evaluation. Combination circuit
All line executed together | "<=" simultaneous evaluation. Sequential Circuits




- Blocking Assignment
```
always @(A,B,D) 
Begin 
    C = A && B; 
    E = C || D; 
end 
```

- Non-blocking assignment 
```
always @(A,B,D) 
Begin 
    C <= A && B; 
    E <= C || D; 
end 
```

Blocking Assignment | Non-Blocking Assignment
------------- | -------------
First line must be evaluated before second line  | Same-time evaluation
"="| "<="
combination circuits | sequential circuits 
C = A && B; | C <= A && B;


## Basic Components 

1. D-Latch 

```
module DLatch(D, CLK, Q);   //RN = reset 
input D, CLK;
output reg Q; 

always @(posedge CLK)
    begin 
	    if (CLK) 
		    Q <= D; 
    end
endmodule
```

2. JK-Flip Flop 

```
module JKFF (RN, J, K, CLK, Q); 
input RN, J, K, CLK; 
output reg Q; 

always @(posedge CLK) 
begin
	if (RN) 
		Q <= 0;  //If reset = 1, then Q = 0 
	else
		begin
		case ({J,K})     //JK
		2'b00 : Q <= Q;  //00 = Q
		2'b01 : Q <= 0;  //01 = 0
		2'b10 : Q <= 1;  //10 = 1
		2'b11 : Q <= ~Q; //11 = (NOT) Q	
		endcase
		end
	end
endmodule
```

3. Counter 

```

module Counter (CLK, RN, Q); 
input CLK, RN; 
output [1:0]Q; 

wire [1:0]Qint;

JKFF JK1(RN, Qint[0], Qint[0], CLK, Qint[1]);  //JK1 input = Q0, Q0
JKFF JK0(RN, 1, 1, CLK, Qint[0]);              //JK0 input = 1, 1

assign Q = Qint;

endmodule

```

4. 4 by 1 multiplexer. 

```
module Multiplexer4by1 (Cin, s,Cout);
input [3:0]Cin;
input [1:0]s;
output Cout; 
	
	assign Cout = Cin[s]; 
	
endmodule
```

## Operators 
Symbol | Operation Performed | Example 
------------- | ------------|-----------------
'~' | Bitwise NOT | 0101 --> NOT --> 1010
'&' | Bitwise AND | 0101 & 1100 --> 0100 
'\|' | Bitwise OR | 0101 \| 1100 --> 1101 
'^' | Bitwise XOR | 0101 ^ 1100 --> 1001
'\~\^' or '\^\~' | Bitwise XNOR | 

Logical Operator 

Symbol  | Operation Performed | Example 
------------- | ------------- | -------------
'!'  | NOT | !(3'b010 && 3'b000) = 1'b1
'&&'  | AND | 3'b010 && 3'b000 = 1'b0 
'\|\| '  | OR | 3'b010 \|\| 3'b000 = 1'b1

Reduction Operator 

Symbol  | Operation Performed | Example 
------------- | ------------- | -------------
\&  | AND | &(10101) = 0. &(011) = 0.
\~\&  | NAND | ~&(10101) = 1. 
\|  | OR | \|(10101) = 1. 
\~\|  | NOR | \~\|(10101) = 0.
\^  | XOR |  ^(10101) = 1.
\~\^  | XNOR | \~\^(10101) = 0. 

Shift Operator 

Symbol  | Operation Performed | Example 
------------- | ------------- | ----------
\>\>  | Shift Right | 10X0>>1 --> 010X
\<\<  | Shift Left | 1010<<2 --> 1000






