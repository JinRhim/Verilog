
module JKFF (RN, J, K, CLK, Q); 
input RN, J, K, CLK; 
output reg Q; 

always @(posedge CLK) 
begin
	if (RN) 
		Q <= 0;
	else
		begin
		case ({J,K})
		2'b00 : Q <= Q; 
		2'b01 : Q <= 0;
		2'b10 : Q <= 1;
		2'b11 : Q <= ~Q;	
		endcase
		end
	end
endmodule



module DLatch(D, CLK, Q);   //RN = reset 
input D, CLK;
output reg Q; 

always @(posedge CLK)
begin 
	if (CLK) 
		Q <= D; 
end

endmodule


module Counter (CLK, RN, Q); 
input CLK, RN; 
output [1:0]Q; 

wire [1:0]Qint;

JKFF JK1(RN, Qint[0], Qint[0], CLK, Qint[1]); 
JKFF JK0(RN, 1, 1, CLK, Qint[0]);

assign Q = Qint;

endmodule



