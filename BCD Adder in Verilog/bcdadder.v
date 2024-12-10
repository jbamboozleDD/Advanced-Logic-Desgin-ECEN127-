module bcdadd (I1, I2, Ci, BCD0, BCD1);
	input [3:0] I1, I2;
	input Ci;
	output [3:0] BCD0, BCD1;
	wire [3:0] sum, rem;
	wire Co, CoUseless, overflow;
	reg [3:0] remconst;

	assign remconst = 4'b0110;
	adder4 a1 (I1, I2, Ci, Co, sum);
	adder4 a2 (sum, remconst, Co, CoUseless, rem);
	
	assign overflow = (sum[3] == 1'b1 && (sum[2] == 1'b1 || sum[1] == 1'b1)) || Co == 1'b1;
	mux21(sum, rem, overflow, BCD0);

	if(overflow == 0)
		assign BCD1 = 4'b0000;
	else
		assign BCD1 = 4'b0001;
endmodule

module mux21 (I1, I2, S, O);
	input [3:0] I1,I2;
	input S;
	output [3:0] O;

	assign O = S ? I2 : I1;
endmodule
