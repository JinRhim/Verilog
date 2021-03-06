
module DLatch_test(); 

reg D; 
reg CLK; 
wire Q;
always #20 CLK = ~CLK;

DLatch DUT(D, CLK, Q);

initial begin 

CLK = 1'b0;
D = 1'b0;
#30; 
D = 1'b1; 
#30; 
end 

endmodule

module JKFF_test(); 

reg J;
reg K; 
reg CLK;
reg RN;

wire Q; 

always #30 CLK = ~CLK; 

JKFF JK(RN,J, K, CLK, Q);

initial begin 
CLK = 1'b0;
RN = 1'b0;


J = 1'b1;
K = 1'b0; 
#50; 
J = 1'b0;
K = 1'b1; 
#50; 
J = 1'b1;
K = 1'b0; 
#50; 
J = 1'b1;
K = 1'b1; 
#50;  

J = 1'b0;
K = 1'b0; 
#50; 
J = 1'b0;
K = 1'b1; 
#50; 
J = 1'b1;
K = 1'b0; 
#50; 
J = 1'b1;
K = 1'b1; 
#50;  

//This is for RN = 1 
RN = RN + 1;


J = 1'b0;
K = 1'b0; 
#50; 
J = 1'b0;
K = 1'b1; 
#50; 
J = 1'b1;
K = 1'b0; 
#50; 
J = 1'b1;
K = 1'b1; 
#50;  

end

endmodule


/*
module Counter (CLK, RN, Q); 
input CLK, RN; 
output [1:0]Q; 

wire [1:0]Qint;

JKFF JK1(RN, Qint[0], Qint[0], CLK, Qint[1]); 
JKFF JK0(RN, 1, 1, CLK, Qint[0]);

assign Q = Qint;


endmodule

*/


module counter_test(); 
reg CLK; 
reg RN; 
wire [1:0]Q;

always #20 CLK = ~CLK; 

Counter Counter1(CLK, RN,Q);

initial begin 
CLK = 1'b0;
RN = 1'b1;

#40;
RN = 1'b0;
#250;
RN = 1'b1;
#30;
RN = 1'b0; 
#200; 
RN = 1'b1;
#30;
RN = 1'b0;
#200;
end
endmodule


