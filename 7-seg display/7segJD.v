module decoder (IN, OUT);
 input [2:0] IN;
 output [6:0] OUT;

 reg [6:0] OUT;

 always @(IN)
 begin
	case (IN)
	 3'b000 : OUT=7'b0011001;
	 3'b001 : OUT=7'b0001101;
	 3'b010 : OUT=7'b1100010;
	 3'b011 : OUT=7'b0011100;
	 3'b100 : OUT=7'b1100100;
	 3'b101 : OUT=7'b1010010;
	 3'b110 : OUT=7'b1001001;
	 3'b111 : OUT=7'b0110110;
	endcase
 end
endmodule

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


module mux41 (A, B, C, D, SEL, OUT);
 input [2:0] A, B, C, D;
 input [1:0] SEL;
 output [2:0] OUT;

 reg [2:0] OUT;

 always @(*)
 begin
	case (SEL)
	 2'b00 : OUT = A; 
	 2'b01 : OUT = B; 
	 2'b10 : OUT = C; 
	 2'b11 : OUT = D;
 	endcase
 end
endmodule 






