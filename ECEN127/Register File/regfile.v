//Important test cases to test include: 
//writing to an address, waiting some time, then reading it
//try writing to an address with enable off and on to see if enable work properly
//make sure read data 0 matches what read addr 0 asks for, same for ra1 and rd1
//ensuring bypass mode works on both ra0 and ra1
//write data with write enable on but when clk is off


module registerfile(ra0, ra1, wa, wd, we, clk, rd0, rd1);
	input [2:0] ra0, ra1, wa;
	input [7:0] wd;
	input clk, we;
	output reg [7:0] rd0, rd1;
	wire [7:0] enadd;
	wire [7:0] D0, D1, D2, D3, D4, D5, D6, D7;

	assign enadd[0] = we && (wa == 3'b000);
	assign enadd[1] = we && (wa == 3'b001);
	assign enadd[2] = we && (wa == 3'b010);
	assign enadd[3] = we && (wa == 3'b011);
	assign enadd[4] = we && (wa == 3'b100);
	assign enadd[5] = we && (wa == 3'b101);
	assign enadd[6] = we && (wa == 3'b110);
	assign enadd[7] = we && (wa == 3'b111);
	
//bypass verilog for read addr 0	
	always @(*) begin
		case ({we, wa, ra0})
			7'b1000000: rd0 = wd;
			7'b1001001: rd0 = wd;
			7'b1010010: rd0 = wd;
			7'b1011011: rd0 = wd;
			7'b1100100: rd0 = wd;
			7'b1101101: rd0 = wd;
			7'b1110110: rd0 = wd;
			7'b1111111: rd0 = wd;
			7'bxxxx000: rd0 = D0;
			7'bxxxx001: rd0 = D1;
			7'bxxxx010: rd0 = D2;
			7'bxxxx011: rd0 = D3;
			7'bxxxx100: rd0 = D4;
			7'bxxxx101: rd0 = D5;
			7'bxxxx110: rd0 = D6;
			7'bxxxx111: rd0 = D7;
			default: rd0 = D0;
		endcase
	end
	
	always @(*) begin
		case ({we, wa, ra1})
			7'b1000000: rd1 = wd;
			7'b1001001: rd1 = wd;
			7'b1010010: rd1 = wd;
			7'b1011011: rd1 = wd;
			7'b1100100: rd1 = wd;
			7'b1101101: rd1 = wd;
			7'b1110110: rd1 = wd;
			7'b1111111: rd1 = wd;
			7'bxxxx000: rd1 = D0;
			7'bxxxx001: rd1 = D1;
			7'bxxxx010: rd1 = D2;
			7'bxxxx011: rd1 = D3;
			7'bxxxx100: rd1 = D4;
			7'bxxxx101: rd1 = D5;
			7'bxxxx110: rd1 = D6;
			7'bxxxx111: rd1 = D7;
			default: rd1 = D0;
		endcase
	end
	
	register8bit R0(wd, enadd[0], clk, D0);
	register8bit R1(wd, enadd[1], clk, D1);
	register8bit R2(wd, enadd[2], clk, D2);
	register8bit R3(wd, enadd[3], clk, D3);
	register8bit R4(wd, enadd[4], clk, D4);
	register8bit R5(wd, enadd[5], clk, D5);
	register8bit R6(wd, enadd[6], clk, D6);
	register8bit R7(wd, enadd[7], clk, D7);
endmodule


module register8bit(in, en, clk, out);
	input [7:0] in;
	input en, clk;
	output reg [7:0] out;

	always @(posedge clk)
	if(en)
		out <= in;

endmodule
