module turnsignals (clk, rst, dir, L, R);
	input clk, rst;
	input [1:0] dir;
	output [2:0] L, R;
	parameter [6:0] straight = 4'b0000001, Ri = 4'b0000010, Rm = 4'b00000100, Ro = 4'b0001000, Li = 4'b0010000, Lm = 4'b0100000, Lo = 4'b1000000;
	reg [6:0] cs, ns;
	
	always @(posedge clk) begin
		if (rst) cs <= straight;
		else cs <= ns;
	end
	
	always @(*) begin
		case (cs)

			straight:	if (dir == 2'b01) ns = Ri;
					else if(dir == 2'b11) ns = Li;
					else ns = straight;
						
			Ri: 		if (dir == 2'b01) ns = Rm;
					else if(dir == 2'b11) ns = Li;
					else ns = straight;
						
			Rm: 		if (dir == 2'b01) ns = Ro;
					else if(dir == 2'b11) ns = Li;
					else ns = straight;
						
			Ro: 		if (dir == 2'b01) ns = Ri;
					else if(dir == 2'b11) ns = Li;
					else ns = straight;
						
			Li: 		if (dir == 2'b01) ns = Ri;
					else if(dir == 2'b11) ns = Lm;
					else ns = straight;
						
			Lm: 		if (dir == 2'b01) ns = Ri;
					else if(dir == 2'b11) ns = Lo;
					else ns = straight;
						
			Lo: 		if (dir == 2'b01) ns = Ri;
					else if(dir == 2'b11) ns = Li;
					else ns = straight;

			default:	ns = straight;
		endcase
	end
	assign R = {(cs == Ro), (cs == Ro)||(cs == Rm), (cs == Ro)||(cs == Rm)||(cs == Ri)};
	assign L = {(cs == Lo), (cs == Lo)||(cs == Lm), (cs == Lo)||(cs == Lm)||(cs == Li)};

endmodule
