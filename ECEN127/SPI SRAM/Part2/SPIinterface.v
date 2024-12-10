module SPI(csb, so, sck, si);
	input csb, sck, si;
	output reg so;
	
	reg [7:0] sreg;
	reg [12:0] address;
	reg [7:0] data;
	wire [4:0] count;
	reg [1:0] cs, ns;
	reg neg;
	reg rst;
	counter c1 (sck, rst, count);
	
	always@(negedge sck)begin
		if(neg == 1'b1) cs <= ns;
	end
	//immediatley go to non selected state
	always@(posedge csb)begin
		cs <= 2'b00;
		neg <= 1'b0;
	end
	//immediatley go to idle state and wipe shift register
	always@(negedge csb)begin
		cs <= 2'b01;
		sreg <= 8'b11111111;
	end
	always@(posedge sck)begin
		if(!csb)begin
			if(neg == 1'b0) cs <= ns;
		end else begin
			cs <= 2'b00;
			neg <= 1'b0;
		end
	end
	
	always@(posedge sck)begin
		case(cs)
			//chip not selected state
			2'b00:begin
				so <= 1'bz;
				ns <= 2'b01;
			end
			
			//idle state
			2'b01:begin
				so <= 1'bz;
				sreg <= {sreg[6:0], si};
				if((sreg[6:0] == 7'b0000001) && (si == 1'b0))begin
					ns <= 2'b10;
				end
				else if((sreg[6:0] == 7'b0000001) && (si == 1'b1))begin
					ns <= 2'b11;
				end else if(ns == 2'b01)begin
					//resets counter
					rst <= 1'b0;
					ns <= 2'b01;
				end else rst <= 1'b1;
			end
			
			//write state
			2'b10:begin
				sreg <= {sreg[6:0], si};
				so <= 1'bz;
				case(count)
					default:begin
						ns <= ns;
					end
					5'b00111:begin
						address[12:8] <= sreg[4:0];
					end
					5'b01111:begin
						address[7:0] <= sreg[7:0];
					end
					5'b10111:begin
						data <= sreg;
						ns <= 2'b01;
					end
				endcase
			end
			
			//read state
			2'b11:begin
				sreg <= {sreg[6:0], si};
				case(count)
					default:begin
						if(neg == 1'b0)begin
							so <= 1'bz;
							ns <= ns;
						end
					end
					5'b00111:begin
						address[12:8] <= sreg[4:0];
						so <= 1'bz;
					end
					5'b01110:begin
						address[7:0] <= {sreg[6:0], si};
						so <= 1'bz;
					end
				endcase
			end
		endcase
	end
	always@(negedge sck)begin
		case(cs)
			default:begin
				ns <= ns;
				so <= so;
			end
			//read
			2'b11:begin
				case(count)
					default:begin
						ns <= ns;
						so <= so;
					end
					5'b01111:begin
						sreg <= data;
						so <= sreg[7];
						neg <= 1'b1;
					end
					
					5'b10000, 5'b10001, 5'b10010, 5'b10011, 5'b10100, 5'b10101, 5'b10110:begin
						so <= sreg[7];
					end
					5'b10111:begin
						so <= 1'bz;
						//back to idle state
						ns <= 2'b01;
						neg <= 1'b0;
					end
				endcase
			end
		endcase
	end
	
endmodule


module counter (clk, rstn, out);
	input clk, rstn;
	output reg[4:0] out;
	always @ (posedge clk) begin
		if (!rstn) out <= 5'b00000;
		else out <= out + 5'b00001;
	end
endmodule


