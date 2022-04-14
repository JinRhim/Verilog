/*
B[2:0] = selector button
S[3:0] = input binary
Q[9:0] = output to decoder 

button 0 = hex
button 1 = decimal 
button 2 = BCD 

Button 2 || Button 1 || Button 0 
	1				1 				0		-> button 0 pressed
	1				0				1		-> button 1 pressed 
	0				1				1		-> button 2 presssed
	
	
	        A
	 ===============
	|               |
F  |               |   B
	|               |
	|      G        |
	 ===============
	|               |
   |               |   C
E	|               |
	|               |
	 ===============
	         D
	
	Order = 7'b GFEDCBA 
	H = 7'b1110110  HEX --> Button 0 
	d = 7'b1011110  Decimal --> Button 1 
	b = 7'b1111100  BCD  --> Button 2 
	
	
	===        ===      ===
  |   |      |   |    |   |
	===        ===      ===
  |   |      |   |    |   |
	===        ===      ===
	D2         D1       D0
	
	
*/


module MultiCodeConverter(B,S,Q);
input [2:0] B;
input [3:0] S; 
output wire [20:0] Q;

wire [20:0] Q_final;

multi_code_converter_control MCCC(B,S,Q_final);

assign Q = ~Q_final;    //Invese for 7 segment display.

endmodule





module multi_code_converter_control(B,S,Q); 

input [2:0] B;   //button
input [3:0] S;   //switches

reg [6:0] D0, D1, D2; //Those are the values that will be sent to Dispay 2,1,0

output [20:0] Q; //Merged value of D2,D1,D0. Final Output.

wire [6:0] Decoded_Result_hex;  //switch input to 7 segment value
wire [6:0] Decoded_Result_decimal; //switch - 10 value to 7 segment value.

wire [3:0] S_Subtracted;

assign S_Subtracted = S - 4'b1010; //this should be executed first
// S_Subtracted = S - 10 is illegal 

Seven_Segment_Hex_Decoder SSHD0(S, Decoded_Result_hex);
//Switch value --> 7-seg-value

Seven_Segment_Hex_Decoder SSHD1(S_Subtracted, Decoded_Result_decimal);
//Switch value - 10 --> 7-seg value. (If switch input > 10)


assign Q = {D2 , D1 , D0}; //final value
//use assign keyword outside of always @(*) bracket
always @(*) begin 

	
	if (B == 3'b110) begin //this is hex. H00 ~ H0F.
		D2 <= 7'b1110110;   //H
		D1 <= 7'b0000000;   //OFF 
		D0 <= Decoded_Result_hex;

		end
	
	else if (B == 3'b101) begin //this is decimal.
		//Display 2 = "d"          d01 ~ d15
		//Display 1 = num if > 9 
		//Display 0 = num - 10
		D2 <= 7'b1011110; 
		if (S >= 10) begin
			D1 <= 7'b0000110;   //Display 1. 
			D0 <= Decoded_Result_decimal;
		end
		else begin
			D1 <= 7'b0111111;   //Display 0
			D0 <= Decoded_Result_hex;
		end
	end
	else if ( B == 3'b011)  begin    //this is for BCD. b00 ~ b09
		D2 <=  7'b1111100;            //"b"
		D1 <=  7'b0000000;            // OFF
		if (S >= 9) 
			begin                //if bigger than 9 display 9
			D0 <= 7'b1101111;
			end
		else 
			begin
			D0 <= Decoded_Result_hex;
			end	
			
	end
	else begin
		D2 <=7'b0000000;
		D1 <=7'b0000000; 
		D0 <=7'b0000000;
	end
	
end	
endmodule


/*
Input: Q[3:0]
Output: S[6:0]

Q[3:2:1:0] = A : B : C : D 
*/

module Seven_Segment_Hex_Decoder(Q, S);
input [3:0] Q;
output reg [6:0] S;

always @* begin 
	if (Q == 4'b0000)   // 0 
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
	else if (Q == 4'b0011)  // 3
		begin
		S = 7'b1001111;
		end
	else if (Q == 4'b0100)  // 4
		begin
		S = 7'b1100110;
		end
	else if (Q == 4'b0101)  // 5 
		begin
		S = 7'b1101101;
		end
	else if (Q == 4'b0110)  // 6 
		begin
		S = 7'b1111101;
		end
	else if (Q == 4'b0111)  // 7
		begin
		S = 7'b0000111;
		end
	else if (Q == 4'b1000) // 8 
		begin
		S = 7'b1111111;
		end
	else if (Q == 4'b1001)  // 9
		begin
		S = 7'b1101111;
		end
	else if (Q == 4'b1010) // A 
		begin
		S = 7'b1110111;
		end
	else if (Q == 4'b1011) // b 
		begin
		S = 7'b1111100;
		end
	else if (Q == 4'b1100) // C
		begin
		S = 7'b0111001;
		end
	else if (Q == 4'b1101) // d
		begin
		S = 7'b1011110;
		end
	else if (Q == 4'b1110) // E 
		begin
		S = 7'b1111001;
		end
	else if (Q == 4'b1111) // F 
		begin
		S = 7'b1110001;
		end
	else 
		begin   //This should not happen. 
		$display("decoder error: Q=%d", Q);
		end
	

end
endmodule


