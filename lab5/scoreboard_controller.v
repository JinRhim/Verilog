/*=====================================


Jin Rhim
922385903
jrhim@sfsu.edu

ENGR 378 Lab 5

the score can be increments by 1 or 10 by INC1 or INC10. 

Press reset for 5 times.


======================================*/


module scoreboard_controller (INC, INC10, RST, CLK, Decoded_Result_BCD1, Decoded_Result_BCD0 );

input INC;
input INC10;
input RST;
input CLK; 


reg[3:0] BCD1;  //display 1 
reg[3:0] BCD0;  //display 0

reg[3:0] reset_counter;  // reset is from 0 to 5. 
reg [1:0] state; // There is two state, 0 and 1. 

wire [6:0] Reg_BCD1; // Value input for 7-segment decoder digit 1. 
wire [6:0] Reg_BCD0; // value input for 7-segment decoder digit 0. 

output [6:0] Decoded_Result_BCD1; //decoded result for 7-segment decoder 1
output [6:0] Decoded_Result_BCD0; //decoded result for 7-segment decoder 0


//Below module will convert number input to LED input.
Seven_Segment_Hex_Decoder SSHD1(BCD1, Reg_BCD1);
Seven_Segment_Hex_Decoder SSHD0(BCD0, Reg_BCD0);

//LED is negative logic --> flip the result
assign Decoded_Result_BCD1 = ~Reg_BCD1;
assign Decoded_Result_BCD0 = ~Reg_BCD0;


//Button debouncing wire
wire debounced_INC;
wire debounced_INC10;
wire debounced_RST; 

wire pulser_INC;
wire pulser_INC10;

//BTN --> debounced_BTN
Debouncer D0(CLK, INC, debounced_INC);
Debouncer D1(CLK, INC10, debounced_INC10);
Debouncer D2(CLK, RST, debounced_RST);

Pulser P0(CLK, debounced_INC, pulser_INC);
Pulser P1(CLK, debounced_INC10, pulser_INC10);

initial begin 
	BCD1 = 4'b0000;
	BCD0 = 4'b0000; 
	reset_counter <= 0; 
	state <= 0;
end


always @(posedge CLK) 
begin 
	case (state) 
	0: 
		begin  
			//at beginning, both digit = 0, counter = 0, state = 1.
			BCD1 <= 4'b0000;
			BCD0 <= 4'b0000; 
			reset_counter <= 0; 
			state <= 1; 
		end 
		
	1: 
		begin 
		
			if (debounced_RST == 1'b0) // IF RST is pressed --> state: 0 
			begin 
				//if reset count is 5, state --> 0 (Clear LED)
				if (reset_counter == 4) 
				begin 
				 state <= 0; 
				end 
				else  
				begin 
					reset_counter <= reset_counter+1; 
				end
			end
			
			//IF INC is pressed
			else if (pulser_INC == 1'b1 && pulser_INC10 == 1'b0) 
			
			begin 
				reset_counter <= 0; 
				if (BCD0 < 4'b1001)  //if first digit is less than 9 
				
				begin 
					BCD0 <= BCD0 +1; //add 1 to digit0. 
				end 
				
				else if (BCD0 == 4'b1001 && BCD1 < 4'b1001)
				//if first digit is 9 && second digit less than 9
				
				begin 
				BCD1 <= BCD1 + 1; // add 1 to digit1. 
				BCD0 <= 4'b0000;  //set digit0 as 0.
				end
				
				else 
				
				begin 
					BCD1 <= BCD1; //nothing change, since 99
					BCD0 <= BCD0;
				end
				
			end 
			//IF INC10 is pressed
			else if (pulser_INC10 == 1'b1 && pulser_INC == 1'b0) 
			
			begin 
				reset_counter <= 0;
				
				if (BCD1 < 4'b1001) //if second digit is less than 9
				begin 
					BCD1 <= BCD1 + 1; //add 1 to digit 1
				end 
				
				else if (BCD1 == 4'b1001) 
				
				begin 
					BCD1 <= BCD1; //nothing change, since 99.
				end 
			end
			end
	endcase	

end

endmodule


module Seven_Segment_Hex_Decoder(Q, S);
input [3:0] Q;
output reg [6:0] S;

always @* begin 
	if (Q == 4'b0000)    // 0
		begin
		S = 7'b0111111;  
		end
	else if (Q == 4'b0001) // 1
		begin
		S = 7'b0000110;
		end
	else if (Q == 4'b0010) // 2
		begin
		S = 7'b1011011;
		end
	else if (Q == 4'b0011) // 3
		begin
		S = 7'b1001111;
		end
	else if (Q == 4'b0100) // 4
		begin
		S = 7'b1100110;
		end
	else if (Q == 4'b0101) // 5
		begin
		S = 7'b1101101;
		end
	else if (Q == 4'b0110) // 6
		begin
		S = 7'b1111101;
		end
	else if (Q == 4'b0111) //7 
		begin
		S = 7'b0000111;
		end
	else if (Q == 4'b1000) // 8
		begin
		S = 7'b1111111;
		end
	else if (Q == 4'b1001)   //this is 9
		begin
		S = 7'b1101111;
		end
	else if (Q == 4'b1010) // 10
		begin
		S = 7'b1110111;
		end
	else if (Q == 4'b1011) // 11
		begin
		S = 7'b1111100;
		end
	else if (Q == 4'b1100) // 12
		begin
		S = 7'b0111001;
		end
	else if (Q == 4'b1101) // 13 
		begin
		S = 7'b1011110;
		end
	else if (Q == 4'b1110) // 14 
		begin
		S = 7'b1111001;
		end
	else if (Q == 4'b1111) // 15
		begin
		S = 7'b1110001;
		end
	else 
		begin     //For debugging purpose
		$display("decoder error: Q=%d", Q);
		end
	
	
end
endmodule
		
//signal --> Debouncer --> Pulse Generator
		
		
module Debouncer(CLK, Input, Result);

input CLK; 
input Input; 
output Result;

reg [1:0] debouncer; 

always @ (posedge CLK) 
begin 
	debouncer[0] <= Input; 
	debouncer [1] <= debouncer [0];  
end 
 assign Result = debouncer[0] & debouncer[1]; //-------|________
endmodule
	
	
module Pulser(CLK, Input, Result);

input CLK; 
input Input; 
output Result;
 
reg [1:0] pulse_generator; //cannot use wire in the always@

always @ (posedge CLK) 
begin 
	pulse_generator[0] <= Input; 
	pulse_generator[1] <= pulse_generator[0];    //____|========
end 
 assign Result = (~pulse_generator[0]) & (pulse_generator[1]);
endmodule

				
			