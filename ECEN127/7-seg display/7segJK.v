module my_alphabet(comb, disp);
 input [2:0] comb;
 output reg [6:0] disp;
 always @(*)
 begin
	 case(comb)
	  3'b000: disp = 7'b1011100;
	  3'b001: disp = 7'b0111000;
	  3'b010: disp = 7'b0111110;
	  3'b011: disp = 7'b1111001;
	  3'b100: disp = 7'b0111001;
	  3'b101: disp = 7'b1110111;
	  3'b110: disp = 7'b1110110;
	  3'b111: disp = 7'b1110011;
	 endcase
 end
endmodule
