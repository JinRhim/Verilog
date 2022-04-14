



module FinalExam(); 
reg [10:0] A; 
reg [10:0] B; 

reg signed [4:0] C; 
reg signed [4:0] D;  

initial begin 
A = 3'b101; 
B = 3'b011; 

C = 4'b1000; 
D = 4'b0110;

$display ("%d", ({3'b101,3'b011}));
$display ("%d", ({2{1'b0,2'b10},3'b101})); 
$display ("%d", (A | B));




$display ("%d", (C>>1));
$display ("%d", $signed(C)>>>1);

$display ("%d", (D>>1));
$display ("%d", (D>>>1));

end 
endmodule