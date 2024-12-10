module game(clk, rst, en, M, W, L, I);
	input clk, rst, en;
	input [1:0] M;
	output W, L;
	output reg I;

	reg [3:0] ns, cs;
	
	always@(posedge clk) begin
		if(rst == 1) cs = 4'b0000;
		else cs = ns;
	end
	
	always@(*) begin
		if(en == 1'b0)
			ns = cs;
		else begin
			case(cs)
				4'b0000:begin
							case(M)
								2'b00:	begin
										ns = 4'b1000;
										I = 1'b0;
								end
								2'b01:	begin
										ns = 4'b1001;
										I = 1'b0;
								end
								2'b10: 	begin
										ns = 4'b1010;
										I = 1'b0;
								end
								2'b11: 	begin
										ns = 4'b1100;
										I = 1'b0;
								end
							endcase
						end
				4'b0001:begin	
							case(M)
								2'b00:	begin
									 	ns = 4'b1001;
										I = 1'b0;
								end
								2'b10:	begin 	
										ns = 4'b1011;
										I = 1'b0;
								end
								2'b11: 	begin
										ns = 4'b1101;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b0010:begin
							case(M)
								2'b00:	begin
										ns = 4'b1010;	
										I = 1'b0;
								end
								2'b01: 	begin
										ns = 4'b1011;
										I = 1'b0;
								end
								2'b11: 	begin
										ns = 4'b1110;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b0011:begin
							ns = cs;
							I = 1'b0;
						end
				4'b0100:begin
							case(M)
								2'b00: 	begin
										ns = 4'b1100;
										I = 1'b0;
								end
								2'b01: 	begin
										ns = 4'b1101;
										I = 1'b0;
								end
								2'b10: 	begin
										ns = 4'b1110;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b0101:begin
							case(M)
								2'b00: 	begin
										ns = 4'b1101;
										I = 1'b0;
								end
								2'b10: 	begin
										ns = 4'b1111;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b0110:begin
							ns = cs;
							I = 1'b0;
						end
				4'b0111:begin
							ns = cs;
							I = 1'b0;
						end
				4'b1000:begin
							ns = cs;
							I = 1'b0;
						end
				4'b1001:begin
							ns = cs;
							I = 1'b0;
						end
				4'b1010:begin
							case(M)
								2'b00: 	begin
										ns = 4'b0010;
										I = 1'b0;
								end
								2'b10: 	begin
										ns = 4'b0000;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b1011:begin
							case(M)
								2'b00: 	begin
										ns = 4'b0011;
										I = 1'b0;
								end
								2'b01: 	begin
										ns = 4'b0010;
										I = 1'b0;
								end
								2'b10: 	begin
										ns = 4'b0001;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b1100:begin
							ns = cs;
							I = 1'b0;
						end
				4'b1101:begin
							case(M)
								2'b00: 	begin
										ns = 4'b0101;
										I = 1'b0;
								end
								2'b01: 	begin
										ns = 4'b0100;
										I = 1'b0;
								end
								2'b11: 	begin
										ns = 4'b0001;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b1110:begin
							case(M)
								2'b00: 	begin
										ns = 4'b0110;
										I = 1'b0;
								end
								2'b10: 	begin
										ns = 4'b0100;
										I = 1'b0;
								end
								2'b11: 	begin
										ns = 4'b0010;
										I = 1'b0;
								end
								default:begin
									I = 1'b1;
									ns = cs;
								end
							endcase
						end
				4'b1111:begin
							ns = cs;
							I = 1'b0;
						end
			endcase
		end
	end
	assign L = (cs == 4'b1000 || cs == 4'b1100 || cs == 4'b1001 || cs == 4'b0110 || cs == 4'b0011);
	assign W = (cs == 4'b1111);
endmodule
